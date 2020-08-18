//
//  VehicleListViewModel.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

class VehicleListViewModel {
    
    // MARK:- Properties
    private let vehicleDetail     : VehicleDetail
    
    var vehicleYear: String {
        "\(vehicleDetail.year)"
    }
    
    var vehicleHDImage: String {
        vehicleDetail.images.firstPhoto.large
    }
    
    var vehicleMediumImage: String {
        vehicleDetail.images.firstPhoto.small
    }
    
    var vehicleSDImage: String {
        vehicleDetail.images.firstPhoto.small
    }
    
    // MARK:- init
    init(detail: VehicleDetail) {
        self.vehicleDetail             = detail
    }
}
