//
//  User.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/29.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    // サーバーとの通信機能は未実装のため以下でログインユーザーを再現
    var isCurrentUser: Bool {
        self.id == User.currentUser.id
    }
    
    static var currentUser: User {
        User(id: "1", name: "Tom", image: "user01")
    }
}
