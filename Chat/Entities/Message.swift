//
//  Message.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import Foundation


struct Message: Identifiable {

    let id: String
    let timestamp: Date
    let text: String
}
