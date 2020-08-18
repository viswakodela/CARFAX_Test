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
    func fetchVehicleListings(completion: @escaping (Result<CarfaxList, Error>) -> Void) {
        listingsApi
            .request(.fetchListings) { (data, resp, err) in
                if let error = err {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                DataDecoder.decodeData(as: CarfaxList.self,
                                       from: data) { (list, err) in
                                        if let error = err {
                                            completion(.failure(error))
                                            return
                                        }
                                        guard let vehicleList = list else { return }
                                        completion(.success(vehicleList))
                }
        }
    }
}
