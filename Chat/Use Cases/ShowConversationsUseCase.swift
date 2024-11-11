//
//  ShowConversationsUseCase.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//


struct ShowConversationsUseCase {

    var conversationsLoader: ConversationsLoading
    var conversationsDisplayer: ConversationsDisplaying

    func showConversations() {
        Task {
            let conversations = await conversationsLoader.loadConversations()
            conversationsDisplayer.show(conversations)
        }
    }

}
