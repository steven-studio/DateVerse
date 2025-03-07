//
//  ContentView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/5.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var selectedTab: Int = 0 // Add this to track the selected tab
    @State private var selectedTurboTab: Int = 0 // Add this to track the selected tab for TurboView
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().isTranslucent = true
    }

    var body: some View {
//        RealityView { content in
//
//            // Create a cube model
//            let model = Entity()
//            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
//            let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
//            model.components.set(ModelComponent(mesh: mesh, materials: [material]))
//            model.position = [0, 0.05, 0]
//
//            // Create horizontal plane anchor for the content
//            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
//            anchor.addChild(model)
//
//            // Add the horizontal plane anchor to the scene
//            content.add(anchor)
//
//            content.camera = .spatialTracking
//
//        }
//        .edgesIgnoringSafeArea(.all)
        ZStack {
            // 你可以在這裡放置背景內容
            Color.clear.edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selectedTab) { // Bind TabView selection to selectedTab
                ARSwipeCardView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                    .tag(0) // Assign a tag for SwipeCardView tab
                
                // Pass the selectedTab to TurboView
                TurboView(contentSelectedTab: $selectedTab, turboSelectedTab: $selectedTurboTab, showBackButton: false) // Match the parameter name here
                    .tabItem {
                        Image(systemName: "star.fill")
                    }
                    .tag(1) // Assign a tag for TurboView tab

    //            // Only show UserGuideView if the user is male
    //            if userSettings.globalUserGender == .male { // Use globalUserGender for the gender check
    //                NavigationView {
    //                    UserGuideView()
    //                }
    //                .tabItem {
    //                    Image(systemName: "questionmark.circle.fill")
    //                }
    //                .tag(2) // Assign a tag for UserGuideView tab
    //            } else {
    //                NavigationView {
    //                    AstrologyView() // ✅ 針對女性用戶顯示命理學相關內容
    //                }
    //                .tabItem {
    //                    Image(systemName: "moon.stars.fill") // 使用更符合命理學的 SF Symbol
    //                }
    //                .tag(2)
    //            }
                
                ChatView(contentSelectedTab: $selectedTab) // Pass the binding to contentSelectedTab
                    .tabItem {
                        Image(systemName: "message.fill")
                    }
                    .tag(3) // Assign a tag for ChatView tab
                
                NavigationView {
                    ProfileView(contentSelectedTab: $selectedTab) // Pass the binding variable
                        .environmentObject(UserSettings.shared) // 確保傳遞 userSettings
//                        .environmentObject(appState) // 傳遞 appState
                }
                .tabItem {
                    Image(systemName: "person.fill")
                }
                .tag(4) // Assign a tag for ProfileView tab
            }
            .onChange(of: selectedTab) { newValue in
                AnalyticsManager.shared.trackEvent("tab_switched", parameters: [
                    "new_tab_index": newValue
                ])
            }
        }
    }
}

#Preview {
    ContentView()
}
