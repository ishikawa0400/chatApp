//
//  Message.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/29.
//

import Foundation

struct Message: Decodable, Identifiable {
    let id: String
    let text: String
    let user: User
    let date: String
    let readed: Bool
}
