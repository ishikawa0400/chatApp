//
//  User.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/29.
//

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    // サーバーとの通信機能は未実装のため以下でログインユーザーを再現
    var isCurrentUser: Bool {
        self.id == "1"
    }
}
