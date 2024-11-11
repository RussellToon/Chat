//
//  ConversationsView.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import SwiftUI


struct ConversationsView: View {

    var model: ConversationsViewModel

    var body: some View {

        Group {
            if let conversations = model.conversations {
                conversationsList(conversations: conversations)
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle("Conversations")

    }

    private func conversationsList(conversations: [Conversation]) -> some View {
        List {
            ForEach(conversations) { conversation in
                NavigationLink {
                    let messagesViewModel = MessagesViewModel()
                    let showMessagesUseCase = ShowMessagesUseCase(messagesDisplayer: messagesViewModel)
                    MessagesView(model: messagesViewModel)
                        .onAppear {
                            showMessagesUseCase.showMessages(messages: conversation.messages)
                        }
                        .id(conversation.id)
                } label: {
                    conversationRow(conversation)
                }
            }
        }
    }

    private func conversationRow(_ conversation: Conversation) -> some View {
        VStack {
            HStack {
                Text("\(conversation.name)")
                    .lineLimit(1)
                //.font(.callout)
                //.bold()
                Spacer()
            }
            let time = model.formattedLastUpdate(conversation: conversation)
            HStack {
                Text(time)
                    .font(.footnote)
                Spacer()
            }
        }
    }
}

#Preview {
    let viewModel = ConversationsViewModel()
    Task {
        let conversations = await PreviewConversations.previewConversations()
        viewModel.show(conversations)
    }
    return ConversationsView(model: viewModel)
}
