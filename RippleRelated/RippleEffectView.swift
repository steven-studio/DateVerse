//
//  RippleEffectView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/6.
//

import Foundation
import SwiftUI

struct RippleEffectView: View {
    var body: some View {
        ZStack {
            // 多層的RippleCircle以製造波紋效果
            RippleCircle(color: .blue.opacity(0.4), scale: 3, animationDuration: 2)
            RippleCircle(color: .blue.opacity(0.3), scale: 2.5, animationDuration: 1.6)
            RippleCircle(color: .blue.opacity(0.2), scale: 2, animationDuration: 1.2)
            
            // 中間的裝置圖示或圖片
            Image(systemName: "iphone.gen3")
                .font(.system(size: 60))
                .foregroundColor(.blue)
        }
        .frame(width: 200, height: 200)
    }
}

struct RippleEffectView_Previews: PreviewProvider {
    static var previews: some View {
        RippleEffectView()
    }
}
