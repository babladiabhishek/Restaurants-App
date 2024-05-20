//
//  Error.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation

struct AppError: Error, LocalizedError {

    let reason: String
    let error: Bool

    var errorDescription: String? {
        reason
    }
}

enum NetworkError: Error {
    case badURL
    case invalidJSON
    case serverError
    case noResponse
    case generalError
    case decodeFailed
    case notFound
}
