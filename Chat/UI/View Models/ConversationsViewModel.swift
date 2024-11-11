//
//  ConversationsViewModel.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import Foundation


protocol ConversationsDisplaying {
    func show(_ conversations: [Conversation])
}


@Observable
class ConversationsViewModel: ConversationsDisplaying {

    var conversations: [Conversation]?

    func show(_ conversations: [Conversation]) {
        Task { @MainActor in
            self.conversations = conversations.sorted(by: { conversationA, conversationB in
                conversationA.lastUpdated > conversationB.lastUpdated
            })
        }
    }

    func formattedLastUpdate(conversation: Conversation) -> String {
        conversation.lastUpdated.formatted()
    }

}
