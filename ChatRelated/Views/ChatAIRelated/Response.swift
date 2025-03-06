//
//  Response.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/6.
//

import Foundation

struct Response: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}
