//
//  MapContainerView.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/10/26.
//

import SwiftUI
import CoreLocation

struct MapContainerView: View {
    @Environment(\.dismiss) var dismiss
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MapBoxView(coordinate: coordinate)
                .ignoresSafeArea()
            
            // 返回按鈕
            Button {
                dismiss()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                    Text("返回")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color.black.opacity(0.7))
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 2)
                )
            }
            .padding(.top, 50)  // 避開動態島
            .padding(.leading, 16)
        }
    }
}
