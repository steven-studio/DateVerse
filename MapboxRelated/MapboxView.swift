//
//  MapboxView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

import Foundation
import SwiftUI
import MapboxMaps
import CoreLocation

struct MapBoxView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var zoom: CGFloat = 14.0
    var allowRotate: Bool = true  // 默認允許旋轉
    
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> MapView {
        // 假設 access token 已經透過 Info.plist 或其他方式設定好
        let options = MapInitOptions(
            cameraOptions: CameraOptions(center: coordinate, zoom: zoom)
        )
        let mapView = MapView(frame: .zero, mapInitOptions: options)
        // 設定旋轉手勢是否啟用
        mapView.gestures.options.rotateEnabled = allowRotate

        mapView.gestures.delegate = context.coordinator
        
        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {
        let cameraOptions = CameraOptions(center: coordinate, zoom: zoom)
        uiView.mapboxMap.setCamera(to: cameraOptions)
        uiView.gestures.options.rotateEnabled = allowRotate
    }
    
    class Coordinator: NSObject, GestureManagerDelegate {
        func gestureManager(_ gestureManager: MapboxMaps.GestureManager, didBegin gestureType: MapboxMaps.GestureType) {
            
        }
        
        func gestureManager(_ gestureManager: MapboxMaps.GestureManager, didEnd gestureType: MapboxMaps.GestureType, willAnimate: Bool) {
            
        }
        
        func gestureManager(_ gestureManager: MapboxMaps.GestureManager, didEndAnimatingFor gestureType: MapboxMaps.GestureType) {
            
        }
        
        func gestureManager(
            _ gestureManager: GestureManager,
            shouldBegin gestureType: GestureType,
            for gestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            if gestureType == .pan,
               let panGesture = gestureRecognizer as? UIPanGestureRecognizer,
               let view = gestureRecognizer.view {
                let location = panGesture.location(in: view)
                if location.x < 30 {
                    return false
                }
            }
            return true
        }
    }
}
