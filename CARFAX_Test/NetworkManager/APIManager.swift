//
//  APIManager.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Networking

class APIManager {
    
    // MARK:- Properties
    static let shared           = APIManager()
    private let listingsApi     = CarfaxRouter<ListingApi>()
}

extension APIManager {
    func fetchVehicleListings() {
        listingsApi
            .request(.fetchListings) { (data, resp, err) in
                print(data?.prettyPrintedJSONString ?? "")
        }
    }
}
