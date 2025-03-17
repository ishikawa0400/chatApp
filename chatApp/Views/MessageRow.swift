//
//  MessageRow.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/16.
//

import SwiftUI

struct MessageRow: View {
    var body: some View {
        HStack(alignment: .top){
            // ユーザーアイコン
            userIcon
            // メッセージ
            messageText
            // メッセージステータス
            messageStatus
            Spacer()
        }
        .padding(.bottom)
    }
}

#Preview {
    MessageRow()
        .background(.cyan)
}

extension MessageRow{
    private var userIcon: some View {
        Image(systemName: "person.circle")
            .resizable()
            .frame(width:48, height:48)
    }
    
    private var messageText: some View {
        Text("こんにちは！こんにちは！こんにちは！こんにちは！")
            .padding()
            .background(.white)
            .cornerRadius(20)
    }
    
    private var messageStatus: some View {
        VStack(alignment: .trailing){
            Spacer()
            Text("既読")
            Text(formatterdDateString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    
    private var formatterdDateString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}
