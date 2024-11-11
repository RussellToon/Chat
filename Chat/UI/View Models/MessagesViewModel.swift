//
//  MessagesViewModel.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import Foundation


protocol MessagesDisplaying {
    func show(_ messages: [Message])
}


@Observable
class MessagesViewModel: MessagesDisplaying {

    var messages: [Message]?

    func show(_ messages: [Message]) {
        Task { @MainActor in
            self.messages = messages.sorted(by: { messageA, messageB in
                messageA.timestamp < messageB.timestamp
            })
        }
    }

    func send(messageText: String) {
        messages?.append(
            Message(
                id: UUID().uuidString,
                timestamp: Date(),
                text: messageText)
        )
    }

    static func formattedLastUpdate(message: Message) -> String {
        message.timestamp.formatted()
    }

}
