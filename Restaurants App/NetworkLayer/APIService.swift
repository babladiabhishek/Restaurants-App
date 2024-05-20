//
//  APIService.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation

enum ServiceEndPoint {
    case getRestaurants
    case getAllTags(String)
    case getStatus(String)
}

extension ServiceEndPoint: EndPointTarget {
    var path: String {
        switch self {
        case .getRestaurants:
            return "/api/v1/restaurants"
        case .getAllTags(let id):
            return "/api/v1/filter/\(id)"
        case .getStatus(let restaurantID):
            return "/api/v1/open/\(restaurantID)"
        }
    }

    var baseURL: String {
        return "food-delivery.umain.io"
    }

    var method: HTTPMethod {
        return .get
    }
}



