//
//  SmartPhotoToggle.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

import Foundation
import SwiftUI

// 智慧照片曝光開關
struct SmartPhotoToggle: View {
    var body: some View {
        Toggle(isOn: .constant(true)) {
            Text("智慧照片曝光")
        }
        .padding()
    }
}
