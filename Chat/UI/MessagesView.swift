//
//  MessagesView.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import SwiftUI


struct MessagesView: View {

    var model: MessagesViewModel

    @State private var replyCompose: String = ""
    @FocusState private var replyFieldIsFocused: Bool
    @State private var scrollToRow: String = ""

    var body: some View {

        Group {
            if let messages = model.messages {
                VStack {
                    messagesList(messages: messages, scrollTo: scrollToRow)
                    composeField()
                        .padding(8)
                }
                .onChange(of: replyFieldIsFocused) { old, new in
                    scrollUp()
                }
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle("Messages")
    }

    private func messagesList(messages: [Message], scrollTo rowId: String) -> some View {
        ScrollViewReader { scrollProxy in
            List(messages, id: \.id) { message in
                MessageView(message: message)
                    .listRowSeparator(.hidden)
                    .id(message.id)
            }
            .defaultScrollAnchor(.bottom)
            .listStyle(.plain)
            .onChange(of: rowId) { oldValue, newValue in
                withAnimation {
                    scrollProxy.scrollTo(rowId)
                }
            }
        }
    }

    private func composeField() -> some View {
        HStack {
            TextField("Reply", text: $replyCompose)
                .focused($replyFieldIsFocused)
                .textFieldStyle(.roundedBorder)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            Button {
                withAnimation(.bouncy) {
                    model.send(messageText: replyCompose)
                    scrollUp()
                }
                replyCompose = ""
            } label: {
                Label("Send", systemImage: "arrow.up.circle.fill")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .bold()
                    .padding(.trailing)
            }
            .controlSize(.extraLarge)
        }
    }

    private func scrollUp() {
        Task { @MainActor in
            try await Task.sleep(for: .seconds(0.3))
            scrollToRow = model.messages?.last?.id ?? ""
        }
    }

    struct MessageView: View {

        let message: Message

        var body: some View {
            HStack {
                Spacer()
                HStack {
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(message.text)")
                                .lineLimit(nil)
                                .multilineTextAlignment(.trailing)
                                .colorInvert()
                        }
                        let time = MessagesViewModel.formattedLastUpdate(message: message)
                        HStack {
                            Text(time)
                                .colorInvert()
                                .font(.footnote)
                        }
                    }
                    .padding()
                    .background(.blue)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 16,
                            bottomLeadingRadius: 16,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 16,
                            style: .continuous
                        )
                    )
                }
            }
        }
    }
}




#Preview {
    let viewModel = MessagesViewModel()
    Task {
        let messages = await PreviewConversations.previewConversations().first!.messages
        viewModel.show(messages)
    }
    return MessagesView(model: viewModel)
}
