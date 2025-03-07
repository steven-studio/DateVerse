//
//  SignalingClient.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/6.
//

import Foundation

class SignalingClient: ObservableObject {
    func send(_ event: String, payload: [String: Any]) {
        // e.g. 透過 WebSocket / Socket.io 傳送
        print("Sending \(event) with payload: \(payload)")
        // ...
    }
}
