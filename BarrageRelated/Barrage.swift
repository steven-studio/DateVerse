//
//  Barrage.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/9.
//

import Foundation
import SwiftUI

struct BarrageMessage: Identifiable {
    let id = UUID()
    let text: String
    // 可以根據需要增加顏色、字體大小、速度等屬性
}

func generateRandomMessage() -> String {
    let messages = ["Hello World!", "SwiftUI 彈幕效果", "快來看彈幕！", "這是彈幕示範"]
    return messages.randomElement()!
}

struct BarrageView: View {
    // 一組彈幕訊息
    @State private var messages: [BarrageMessage] = (0..<10).map { _ in
        BarrageMessage(text: generateRandomMessage())
    }
    
    // 用於隨機高度
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            // 依據訊息產生彈幕視圖
            ForEach(messages) { message in
                BarrageMessageView(
                    message: message,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    animationDuration: Double.random(in: 5...10)
                ) {
                    // 动画完成后，从数组中移除该消息
                    if let index = messages.firstIndex(where: { $0.id == message.id }) {
                        messages.remove(at: index)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // 每隔 2 秒加入一條新訊息
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                let newCount = Int.random(in: 1...10)
                for _ in 0..<newCount {
                    messages.append(BarrageMessage(text: generateRandomMessage()))
                }
            }
        }
    }
}

struct BarrageMessageView: View {
    let message: BarrageMessage
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let animationDuration: Double
    let onComplete: () -> Void  // 动画完成后调用的闭包
    
    // 隨機產生一個初始位置（垂直位置）
    @State private var yPosition: CGFloat = CGFloat.random(in: 0...UIScreen.main.bounds.height)
    // 初始偏移為螢幕寬度
    @State private var offsetX: CGFloat = 0
    
    // 控制漸層動畫的角度
    @State private var gradientAngle: Angle = .degrees(0)
    
    var body: some View {
        Text(message.text)
            .padding(8)
//            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .cornerRadius(8)
            // 這層作為彩虹文字，透過 mask 使文字呈現漸層效果
            .overlay(
                Text(message.text)
                    .padding(8)
                    .foregroundColor(.clear)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .mask(
                        Text(message.text)
                            .padding(8)
                    )
            )
            .position(x: screenWidth + 100, y: yPosition)
            .offset(x: offsetX)
            .onAppear {
                print("生成的 yPosition: \(yPosition)")
                // 設定動畫：讓文字從右側滑向左側
                withAnimation(Animation.linear(duration: animationDuration)) {
                    offsetX = -screenWidth - 200
                }
                // 動畫讓彩虹漸層持續旋轉
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                    gradientAngle = .degrees(360)
                }
                // 在动画持续时间后调用 onComplete 回调
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    onComplete()
                }
            }
    }
}
