//
//  OptionalISO8601Date.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/10.
//

import Foundation

public struct OptionalISO8601Date {
    private let date: Date?
    private let formatter = DateFormatter.iso8601Full

    public init(date: Date? = nil) {
        self.date = date
    }
}

extension OptionalISO8601Date: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)

        if dateString == "none" || dateString.isEmpty {
            self.date = nil
        } else if let date = formatter.date(from: dateString) {
            self.date = date
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date format"
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let date = self.date {
            let dateString = formatter.string(from: date)
            try container.encode(dateString)
        } else {
            try container.encode("none")
        }
    }
}

extension OptionalISO8601Date: Hashable {
    public static func == (lhs: OptionalISO8601Date, rhs: OptionalISO8601Date) -> Bool {
        lhs.date == rhs.date
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
