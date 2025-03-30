//
//  ChatViewModel.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/29.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    var chatData: [Chat] = []
    @Published var messages: [Message] = []
    
    init() {
        chatData = fetchChatData()
        messages = chatData[0].messages
    }
    
    private func fetchChatData() -> [Chat]{
        let fileName = "chatData.json"
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError( "File not found: \(fileName)")
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("Failed to load \(fileName)")
        }
        
        do {
            return try JSONDecoder().decode([Chat].self, from: data)
        } catch {
            fatalError("Failed to convert JSON to [Chat] in \(fileName)")
        }
        
        
    }
    
    func addMessage(text: String){
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            user: User.currentUser,
            date: Date().description,
            readed: false
        )
        messages.append(newMessage)
    }
    
}
