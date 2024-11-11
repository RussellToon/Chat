//
//  ChatApp.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import SwiftUI

@main
struct ChatApp: App {

    private var conversationsViewModel: ConversationsViewModel
    private var showConversations: ShowConversationsUseCase

    init() {
        let conversationsViewModel = ConversationsViewModel()
        let fileGateway = FileGateway(fileReader: JsonFileReader())
        let showConversations = ShowConversationsUseCase(conversationsLoader: fileGateway, conversationsDisplayer: conversationsViewModel)
        self.conversationsViewModel = conversationsViewModel
        self.showConversations = showConversations
    }

    var body: some Scene {
        WindowGroup {
            ContentView(conversationsViewModel: conversationsViewModel, showConversationsUseCase: showConversations)
        }
    }
}
