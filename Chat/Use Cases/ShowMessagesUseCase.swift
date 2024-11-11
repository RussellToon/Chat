//
//  ShowMessagesUseCase.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//


struct ShowMessagesUseCase {

    var messagesDisplayer: MessagesDisplaying

    func showMessages(messages: [Message]) {
        Task {
            messagesDisplayer.show(messages)
        }
    }

}
