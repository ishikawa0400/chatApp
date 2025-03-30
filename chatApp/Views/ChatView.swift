//
//  ChatView.swift
//  chatApp
//
//  Created by Ishikawa Yuki on 2025/03/16.
//

import SwiftUI

struct ChatView: View {

    let chat: Chat

    @State private var textFieldText: String = ""
    @FocusState private var textFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    // @ObservedObject var vm: ChatViewModel = ChatViewModel()
    @EnvironmentObject var vm: ChatViewModel

    var body: some View {
        VStack(spacing: 0) {
            // メッセージエリア
            messageArea

                // ナビゲーションエリア
                .overlay(navigationArea, alignment: .top)

            // 入力エリア
            inputArea
        }
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}

//#Preview {
//    ChatView()
//}

extension ChatView {
    private var messageArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(chat.messages) { message in
                        MessageRow(message: message)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 72)
            }
            .background(Color("Background"))
            // メッセージエリアをタップした時にキーボードを閉じる
            .onTapGesture {
                textFieldFocused = false
            }
            // 初回表示時
            .onAppear {
                scrollToLast(proxy: proxy)
            }
            // 新規メッセージが追加された時
            .task(id: chat.messages.count) {
                scrollToLast(proxy: proxy)
            }
        }
    }

    private var navigationArea: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            Text("Title")
                .font(.title2.bold())
            Spacer()
            HStack(spacing: 16) {
                Image(systemName: "text.magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
        }
        .padding()
        .background(Color("Background").opacity(0.9))
    }

    private var inputArea: some View {
        HStack {
            HStack {
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            TextField("Aa", text: $textFieldText, axis: .vertical)
                .padding(10)
                .padding(.trailing, 20)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(20)
                .overlay(
                    Image(systemName: "face.smiling")
                        .font(.title2)
                        .padding(.trailing, 5)
                        .foregroundColor(.gray), alignment: .trailing
                )
                .focused($textFieldFocused)
            if !textFieldText.isEmpty {
                Image(systemName: "paperplane.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        textFieldFocused = true
                        sendMessage()
                    }
            } else {
                Image(systemName: "paperplane")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(uiColor: .systemBackground))
    }

    // メッセージ送信
    private func sendMessage() {
        if !textFieldText.isEmpty {
            vm.addMessage(chatId: chat.id, text: textFieldText)
            textFieldText = ""
        }
    }

    // 一番下までスクロールする
    private func scrollToLast(proxy: ScrollViewProxy) {
        if let lastMessage = chat.messages.last {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }

}
