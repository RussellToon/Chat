//
//  Conversation.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import Foundation


struct Conversation: Identifiable {

    let id: String
    let name: String
    let lastUpdated: Date
    let messages: [Message]

}
