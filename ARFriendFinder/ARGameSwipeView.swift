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

struct ARSwipeCardView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var showPrivacySettings = false
    @State private var isARSessionActive = true
    @State private var users: [User] = []
    @State private var showMapPage: Bool = false
    @State private var useFrontCamera = false // 新增状态：是否使用前置摄像头

    // 用 @StateObject 建立一個 LocationManager 實例
    @StateObject private var locationManager = LocationManager()

    // 目前的座標，若 locationManager.currentLocation 為 nil 則預設一個值
    var coordinate: CLLocationCoordinate2D {
        if let location = locationManager.currentLocation {
            return location.coordinate
        }
        // 預設台北101附近
        return CLLocationCoordinate2D(latitude: 25.0330, longitude: 121.5654)
    }
    
    var body: some View {
        ZStack {
            if isARSessionActive {
                ZStack(alignment: .topTrailing) {
                    ARFriendFinderView(useFrontCamera: $useFrontCamera)
                        .edgesIgnoringSafeArea(.all)
                    
                    // 右下：關閉 AR 按鈕
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
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
                            .padding(.bottom, 50)
                            .padding(.trailing, 16)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showMapPage) {
                    // 全屏版的 MapBoxView，允許旋轉
                    MapBoxView(coordinate: coordinate, allowRotate: true)
                        .edgesIgnoringSafeArea(.all)
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
                    
                    // 使用 MapBoxView 顯示地圖，禁止旋轉
                    MapBoxView(coordinate: coordinate, allowRotate: false)
                        .frame(height: 200)
                        .cornerRadius(12)
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
            VStack(spacing: 8) {
                if isARSessionActive {
                    // 設定按鈕
                    Button(action: {
                        showPrivacySettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                } else {
                    Button(action: {
                        showPrivacySettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                
                if isARSessionActive {
                    // 地圖切換按鈕：位於 gear 按鈕下方
                    Button(action: {
                        showMapPage = true
                    }) {
                        Image(systemName: "map")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                
                if isARSessionActive {
                    // 新增倒轉攝像頭按鈕
                    Button(action: {
                        // 切換前/後置攝像頭
                        useFrontCamera.toggle()
                    }) {
                        Image(systemName: "camera.rotate")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
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
