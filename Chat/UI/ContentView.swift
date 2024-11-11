//
//  ContentView.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import SwiftUI


struct ContentView: View {

    var conversationsViewModel: ConversationsViewModel
    var showConversationsUseCase: ShowConversationsUseCase

    var body: some View {

        NavigationSplitView {
            ConversationsView(model: conversationsViewModel)
                .listStyle(.plain)
                .onAppear {
                    showConversationsUseCase.showConversations()
                }
#if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                .toolbar {
#if os(iOS)
                // TODO: Toolbar content if needed
#endif
                }
        } detail: {
            Text("Select a conversation")
        }
    }

}

// TODO: Enable
//#Preview {
//    ContentView()
//}
