//
//  RippleCircle.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/6.
//

import Foundation
import SwiftUI

struct RippleCircle: View {
    @State private var animate = false
    var color: Color
    var scale: CGFloat
    var animationDuration: Double

    var body: some View {
        Circle()
            .fill(color)
            .opacity(animate ? 0 : 0.6)
            .scaleEffect(animate ? scale : 0.1)
            .animation(
                Animation.easeOut(duration: animationDuration)
                    .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                self.animate = true
            }
    }
}

struct RippleCircle_Previews: PreviewProvider {
    static var previews: some View {
        RippleCircle(
            color: .blue.opacity(0.4),
            scale: 3,
            animationDuration: 2
        )
    }
}
