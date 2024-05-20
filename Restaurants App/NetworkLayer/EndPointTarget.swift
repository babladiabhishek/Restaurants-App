//
//  EndPointTarget.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation

protocol EndPointTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func getURL() -> URL?
}

extension EndPointTarget {
    func getURL() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        return component.url
    }
}

enum HTTPMethod: String {
    case get = "GET"
}


