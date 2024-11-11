//
//  PreviewData.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//


struct PreviewConversations {
    static var fileReader: FileReader = JsonFileReader()
    static func previewConversations() async -> [Conversation] {
        let conversationsLoader: ConversationsLoading = FileGateway(fileReader: fileReader)
        return await conversationsLoader.loadConversations()
    }
}
