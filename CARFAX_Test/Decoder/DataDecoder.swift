//
//  DataDecoder.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct DataDecoder {
    /// Generic method which helps us to reduce the code reuse while decoding the Network JSON response into requested Models.
    /// - Parameters:
    ///   - modelObject: Type of the Model requested.
    ///   - data: data to decode.
    ///   - completion: callback that gets called if the response is success in the do block or failed in the catch block.
    static func decodeData<T: Decodable>(as modelObject: T.Type, from data: Data, completion: (T?, Error?) -> Void) {
        do {
            let decodedObject = try JSONDecoder().decode(modelObject, from: data)
            completion(decodedObject, nil)
        } catch {
            print(data.prettyPrintedJSONString ?? "Decoding Error")
            print("Error decoding \(modelObject) with error: \(error.localizedDescription)")
            completion(nil, error)
        }
    }
}
