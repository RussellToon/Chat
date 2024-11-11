//
//  FileReader.swift
//  Chat
//
//  Created by Russell Toon on 11/11/2024.
//

import Foundation
import OSLog


protocol FileReader {
    func readFromFile(fileName: String) -> [JsonFileReader.Conversation]
}

extension FileReader {
    func readFromFile() -> [JsonFileReader.Conversation] {
        return readFromFile(fileName: "code_test_data")
    }
}


struct JsonFileReader: FileReader {
    private let log = Logger()

    func readFromFile(fileName: String) -> [Conversation] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            // TODO: Would be better to throw these errors
            log.error("Failed to find \("fileName")")
            return []
        }

        do {
            let content = try Data(contentsOf: fileURL)
            let result = try decoder.decode([Conversation].self, from: content)
            return result
        }
        catch {
            log.error("Failed to read file. \(error)")
            return []
        }
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let isoDateFormatter = Date.ISO8601FormatStyle()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date: Date =
                try? isoDateFormatter.parse(dateString+"Z") {
                return date
            }
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Date string does not match expected format: \(dateString)"
            )
        })
        return decoder
    }

    struct Conversation: Codable {
        let id: String
        let name: String
        let lastUpdated: Date
        let messages: [Message]

        enum CodingKeys: String, CodingKey {
            case lastUpdated = "last_updated"
            case id, name, messages
        }
    }

    struct Message: Codable {
        let id: String
        let lastUpdated: Date
        let text: String

        enum CodingKeys: String, CodingKey {
            case lastUpdated = "last_updated"
            case id, text
        }
    }
}
