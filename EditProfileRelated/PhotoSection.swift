//
//  PhotoSection.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

import Foundation
import SwiftUI

// 照片區域組件
struct PhotoSection: View {
    @Binding var photos: [String]
    @Binding var deletedPhotos: [String]

    var body: some View {
        PhotoSectionView(photos: $photos, deletedPhotos: $deletedPhotos)
            .padding()
    }
}
