//
//  MessageRow.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/16.
//

import SwiftUI

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top){
            if message.user.isCurrentUser {
                Spacer()
                messageStatus
                messageText
                    
            } else {
                userIcon
                messageText
                messageStatus
                Spacer()
            }
            
        }
        .padding(.bottom)
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

//#Preview {
//    MessageRow()
//        .background(.cyan)
//}

extension MessageRow{
    private var userIcon: some View {
        Image(message.user.image)
            .resizable()
            .frame(width:48, height:48)
            .clipShape(Circle())
    }
    
    private var messageText: some View {
        Text(message.text)
            .padding()
            .background(message.user.isCurrentUser ? Color("Bubble") :
                            Color(uiColor: .tertiarySystemBackground))
            .foregroundColor(message.user.isCurrentUser ? .black : .primary)
            .cornerRadius(20)
    }
    
    private var messageStatus: some View {
        VStack(alignment: .trailing){
            Spacer()
            
            if message.user.isCurrentUser && message.readed {
                Text("既読")
            }
            Text(formatterdDateString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    
    private var formatterdDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: message.date) else {return ""}
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
