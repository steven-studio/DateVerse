//
//  ARFriendFinderView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

import Foundation
import SwiftUI
import ARKit

struct ARFriendFinderView: UIViewRepresentable {
    @Binding var useFrontCamera: Bool  // 新增绑定：是否使用前置摄像头
    
    func makeCoordinator() -> FaceTrackingCoordinator {
        return FaceTrackingCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        // 初始配置：依据 useFrontCamera 判断使用哪种配置
        let configuration = useFrontCamera ? ARFaceTrackingConfiguration() : ARWorldTrackingConfiguration()
        if let faceConfig = configuration as? ARFaceTrackingConfiguration {
            faceConfig.isLightEstimationEnabled = true
        } else if let worldConfig = configuration as? ARWorldTrackingConfiguration {
            worldConfig.planeDetection = [.horizontal, .vertical]
        }
        arView.session.run(configuration)
        arView.autoenablesDefaultLighting = true
        arView.delegate = context.coordinator // 设置代理
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // 如果切换了摄像头模式，则重启 session
        uiView.session.pause()
        let configuration = useFrontCamera ? ARFaceTrackingConfiguration() : ARWorldTrackingConfiguration()
        if let faceConfig = configuration as? ARFaceTrackingConfiguration {
            faceConfig.isLightEstimationEnabled = true
        } else if let worldConfig = configuration as? ARWorldTrackingConfiguration {
            worldConfig.planeDetection = [.horizontal, .vertical]
        }
        uiView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

class FaceTrackingCoordinator: NSObject, ARSCNViewDelegate {
    var parent: ARFriendFinderView

    init(parent: ARFriendFinderView) {
        self.parent = parent
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 如果检测到面部 anchor，切换到 ARFaceTrackingConfiguration
        if let faceAnchor = anchor as? ARFaceAnchor {
            print("Detected face: \(faceAnchor)")
            if ARFaceTrackingConfiguration.isSupported {
                let blendShapes = faceAnchor.blendShapes
                // 示例：获取左眼闭合程度
                if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float {
                    print("Left eye blink intensity: \(leftEyeBlink)")
                }
                // 你可以在这里添加更多对 blendShapes 的分析，用于微表情识别
                // 切换配置：暂停当前 session，然后运行 face tracking 配置
                if let arView = renderer as? ARSCNView {
                    let faceConfig = ARFaceTrackingConfiguration()
                    faceConfig.isLightEstimationEnabled = true
                    arView.session.pause()
                    arView.session.run(faceConfig, options: [.resetTracking, .removeExistingAnchors])
                }
            }
        }
    }
}
