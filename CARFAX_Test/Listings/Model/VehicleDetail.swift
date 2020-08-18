//
//  VehicleDetail.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct VehicleDetail    : Decodable {
    let images          : VehicleImage
    let year            : Int
    let id              : String
    let make            : String
    let model           : String
    let currentPrice    : Int
    let mileage         : Int
    let dealer          : Dealer
    
    struct Dealer       : Decodable {
        let address     : String
    }
}

struct VehicleImage     : Decodable {
    let firstPhoto      : ImageSize
}

struct ImageSize        : Decodable {
    let large           : String
    let medium          : String
    let small           : String
}
