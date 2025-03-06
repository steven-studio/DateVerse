//
//  ARGameSwipeView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/6.
//

import Foundation
import SwiftUI
import ARKit
import FirebaseFirestore

private let db = Firestore.firestore()

struct User: Identifiable {
    var id: String
    var name: String
    var age: Int
    var zodiac: String
    var location: String
    var height: Int
    var photos: [String]
}

struct ARFriendFinderView: UIViewRepresentable {

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)
        arView.autoenablesDefaultLighting = true
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Update AR content if needed
    }
}

struct ARSwipeCardView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var showPrivacySettings = false
    @State private var isARSessionActive = false
    @State private var users: [User] = []

    var body: some View {
        ZStack {
            if isARSessionActive {
                ZStack(alignment: .topTrailing) {
                    ARFriendFinderView()
                        .edgesIgnoringSafeArea(.all)
                    
                    // 關閉AR按鈕
                    Button(action: {
                        isARSessionActive = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white.opacity(0.9))
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(.top, 50)
                    .padding(.trailing, 16)
                }
            } else {
                VStack(spacing: 20) {
                    Text("發現新的朋友！")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("使用AR探索身邊的用戶，點擊發現的用戶來互動與結識更多朋友。")
                        .multilineTextAlignment(.center) // 文字置中
                        .foregroundColor(.white)
                        .padding()

                    Button(action: {
                        isARSessionActive = true
                    }) {
                        Text("開始AR體驗")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 確保整個 VStack 置中
                .background(Color.black) // 背景黑色
                .foregroundColor(.white) // 文字顏色為白色
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                showPrivacySettings = true
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .padding()
            }
        }
        .fullScreenCover(isPresented: $showPrivacySettings) {
            PrivacySettingsView(isPresented: $showPrivacySettings)
        }
    }
    
    func fetchNearbyUsersForAR() {
        db.collection("users")
            .whereField("location", isEqualTo: userSettings.globalSubadministrativeArea)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("獲取附近用戶失敗：\(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self.users = documents.compactMap { doc -> User? in
                    let data = doc.data()
                    guard let name = data["name"] as? String,
                          let age = data["age"] as? Int,
                          let zodiac = data["zodiac"] as? String,
                          let location = data["location"] as? String,
                          let height = data["height"] as? Int,
                          let photos = data["photos"] as? [String] else { return nil }
                    
                    return User(id: doc.documentID, name: name, age: age, zodiac: zodiac, location: location, height: height, photos: photos)
                }
                
                // 透過這些資料，在ARGamingView中標註用戶
            }
    }
}

struct ARSwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ARSwipeCardView()
    }
}
