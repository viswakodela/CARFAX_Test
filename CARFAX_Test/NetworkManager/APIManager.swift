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
    private let networkingQueue = DispatchQueue(label: "ca.carfax.com",
                                                qos: .userInitiated,
                                                attributes: .concurrent)
}

extension APIManager {
    func fetchVehicleListings(completion: @escaping (Result<[VehicleListViewModel], Error>) -> Void) {
        networkingQueue.async {
            self.listingsApi
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
                                            let listViewModel = vehicleList.listings.map({ VehicleListViewModel(detail: $0) })
                                            completion(.success(listViewModel))
                    }
            }
        }
    }
}
