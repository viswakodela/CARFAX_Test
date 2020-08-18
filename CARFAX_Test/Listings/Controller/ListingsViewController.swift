//
//  ListingsViewController.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    
    // MARK:- Properties
    private var vehicleListing      = [VehicleListViewModel]()
    
    // MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchListings()
    }
}

// MARK:- Networking Code
private extension ListingsViewController {
    func fetchListings() {
        APIManager
            .shared
            .fetchVehicleListings { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    self.vehicleListing = list
                }
        }
    }
}

