//
//  ClaudeChatView.swift
//  iClaudius
//

import SwiftUI

struct ClaudeChatView: View
{
    @State private var userInput: String = ""
    @State private var chatHistory: [String] = []
    @State private var respondAsClaudius: Bool = false  // Toggle for Emperor Claudius mode
    @State private var isLoading: Bool = false  // Tracks whether to show the spinner
   
    
    var body: some View
    {
        VStack
        {
            // Input field and send button
            HStack
            {
                TextField("Type or paste a message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               
                // Spinner to show loading state
               if isLoading { ProgressView() }
           
                Button(action: {
                    let prompt = respondAsClaudius
                        ? "You are responding as Emperor Claudius of Rome. Answer in the style of a Roman Emperor, using formal and ancient Roman language, as if you were addressing a citizen or ally. Speak with authority, wisdom, and grace: \(userInput)"
                        : userInput
                    
                    chatHistory.append("You: \(userInput)")
                    
                    // Show spinner and start loading
                    isLoading = true
                    
                    // Call sendMessageToClaude from ClaudeAPI
                    ClaudeAPI.instance.sendMessageToClaude(message: prompt) { response in
                        DispatchQueue.main.async
                        {
                            // Hide spinner after receiving the response
                            isLoading = false
                            
                            if let response
                            {
                                let responsePrefix = respondAsClaudius ? "Claudius: " : "Me: "
                                let responseMessage = "\(responsePrefix)\(response)"
                                chatHistory.append(responseMessage)
                                
                                // Copy Claude's response to clipboard
                                UIPasteboard.general.string = responseMessage
                            }
                            else
                            {
                                chatHistory.append("Claude API: I couldn't process that.")
                            }
                            userInput = ""
                        }
                    }
                }) {
                    Text("Send")
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 4)
            
            // Toggle switch for "Respond as Emperor Claudius"
            Toggle(isOn: $respondAsClaudius) {
                Text("Respond as Emperor Claudius")
                    .font(.body)
            }
            .padding(.horizontal, 4)
    
            // Scroll view with scroll bar and automatic scrolling to latest message
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    ForEach(chatHistory.indices, id: \.self) { index in
                        Text(chatHistory[index])
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .id(index)  // Add an identifier for each message to enable auto-scroll
                    }
                }
                .onChange(of: chatHistory.count) {
                    // Scroll to the latest message when chat history updates
                    if let lastIndex = chatHistory.indices.last
                    {
                        scrollViewProxy.scrollTo(lastIndex, anchor: .bottom)
                    }
                }
            }
        }
    }
}
