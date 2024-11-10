//
//  ClaudeAPI.swift
//  iClaudius MessagesExtension
//

import Foundation

class ClaudeAPI: NSObject
{
    static let instance = ClaudeAPI()  // Singleton instance

    private let anthropicEndpoint = URL(string: "https://api.anthropic.com/v1/messages")!
  
    let apiKey = "YOUR_API_KEY"  // Replace with your actual API key

    //---------------------------------------------------------------------------------------------------------------------------

    // Decodable structs to parse the response
    struct ClaudeResponse: Decodable {
        let content: [Content]
        let id: String
        let model: String
        let role: String
        let stopReason: String?
        let stopSequence: String?
        let type: String
        let usage: Usage

        enum CodingKeys: String, CodingKey {
            case content
            case id
            case model
            case role
            case stopReason = "stop_reason"
            case stopSequence = "stop_sequence"
            case type
            case usage
        }
    }

    struct Content: Decodable {
        let text: String
        let type: String
    }

    struct Usage: Decodable {
        let inputTokens: Int
        let outputTokens: Int

        enum CodingKeys: String, CodingKey {
            case inputTokens = "input_tokens"
            case outputTokens = "output_tokens"
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------

    // Function to send a message and parse Claude's response
    func sendMessageToClaude(message: String, completion: @escaping (String?) -> Void)
    {
        // Define the request payload
        let parameters: [String: Any] = [
            "model": "claude-3-5-sonnet-20241022",  // Select model
            "max_tokens": 1024,
            "messages": [
                ["role": "user", "content": message]
            ]
        ]

        // Convert parameters to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion("Error creating request data")
            return
        }

        // Create a URLRequest
        var request = URLRequest(url: anthropicEndpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2023-06-01", forHTTPHeaderField: "anthropic-version")  // Anthropic API version
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")  // API key header
        request.httpBody = jsonData

        // Debugging prints
        print("Request URL: \(request.url!)")
        print("Request Headers: \(request.allHTTPHeaderFields!)")
        print("Request Body: \(String(data: jsonData, encoding: .utf8)!)")

        // Create a URLSession data task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            // Debug response status and data
            if let httpResponse = response as? HTTPURLResponse
            {
                print("Response Status Code: \(httpResponse.statusCode)")
            }
            print("Response Data: \(String(data: data, encoding: .utf8)!)")

            // Parse the response using JSONDecoder
            do
            {
                let decodedResponse = try JSONDecoder().decode(ClaudeResponse.self, from: data)
                // Extract the assistant's response text from the content array
                let assistantResponse = decodedResponse.content.first?.text
                completion(assistantResponse)
            }
            catch
            {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
