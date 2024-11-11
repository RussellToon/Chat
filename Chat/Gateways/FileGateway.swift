//
//  FileGateway.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//


protocol ConversationsLoading {
    func loadConversations() async /* throws */ -> [Conversation]
}


struct FileGateway: ConversationsLoading {

    let fileReader: FileReader


    func loadConversations() async /* throws */ -> [Conversation] {

        let load = Task {
            let content = fileReader.readFromFile()

            let conversations = content.map { conversation in
                Conversation(
                    id: conversation.id,
                    name: conversation.name,
                    lastUpdated: conversation.lastUpdated,
                    messages: conversation.messages.map({ message in
                        Message(id: message.id, timestamp: message.lastUpdated, text: message.text)
                    })
                )
            }

            return conversations
        }

        return await load.value
    }

}
