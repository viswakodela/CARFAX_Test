//
//  CarfaxList.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct CarfaxList: Decodable {
    let listings            : [VehicleList]
    let page                : Int
    let pageSize            : Int
}
