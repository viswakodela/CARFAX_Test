//
//  JSONParameterEncoder.swift
//  Networking
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

/// **JSONParameterEncoder** is used to add the *httpBody* to the *URLRequest*
public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let jsonAsData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        urlRequest.httpBody = jsonAsData
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
