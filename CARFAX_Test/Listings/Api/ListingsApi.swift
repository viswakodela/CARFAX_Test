//
//  ListingsApi.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation
import Networking

enum ListingApi {
    case fetchListings
}

extension ListingApi: EndPointType {
    var path: String {
        switch self {
        case .fetchListings:
            return "/assignment.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchListings:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .fetchListings:
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
}

