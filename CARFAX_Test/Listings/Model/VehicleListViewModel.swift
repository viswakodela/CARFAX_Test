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
    
    var vehicleModel: String {
        vehicleDetail.model
    }
    
    var vehicleMake: String {
        vehicleDetail.make
    }
    
    var vehiclePrice: String {
        vehicleDetail.currentPrice.formattedPrice
    }
    
    var vehicleMileage: String {
        "\(formatNumber(vehicleDetail.mileage))"
    }
    
    var carDealerAddress: String {
        vehicleDetail.dealer.address
    }
    
    var carDealerContact: String {
        vehicleDetail.dealer.phone
    }
    
    var dealerLocationCoordinates: (String, String) {
        (vehicleDetail.dealer.latitude, vehicleDetail.dealer.longitude)
    }
    
    // MARK:- init
    init(detail: VehicleDetail) {
        self.vehicleDetail             = detail
    }
}


extension VehicleListViewModel: Hashable {
    static func == (lhs: VehicleListViewModel, rhs: VehicleListViewModel) -> Bool {
        lhs.vehicleDetail.id == rhs.vehicleDetail.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(vehicleDetail.id)
    }
}
