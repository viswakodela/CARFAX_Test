//
//  VehicleList.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct VehicleList  : Decodable {
    let images      : VehicleImage
}

struct VehicleImage : Decodable {
    let firstPhoto  : ImageSize
}

struct ImageSize    : Decodable {
    let large       : String
    let medium      : String
    let small       : String
}
