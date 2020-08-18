//
//  AppError.swift
//  Networking
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badUrl
}

extension AppError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badUrl:
            return "Bad Url request"
        }
    }
}
