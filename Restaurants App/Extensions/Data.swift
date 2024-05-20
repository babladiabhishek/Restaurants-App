//
//  Data.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data,
                                                 encoding: String.Encoding.utf8.rawValue) as String? else { return nil }

        return prettyPrintedString
    }
}
