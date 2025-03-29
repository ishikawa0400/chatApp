//
//  Chat.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/29.
//

import Foundation

struct Chat: Decodable {
    let id: String
    let messages: [Message]
}
