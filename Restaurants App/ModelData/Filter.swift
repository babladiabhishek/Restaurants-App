//
//  Filter.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
struct Filter: Codable, Hashable {
    let name, id: String
    let imageURL: String

       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageURL = "image_url"
    }
}
