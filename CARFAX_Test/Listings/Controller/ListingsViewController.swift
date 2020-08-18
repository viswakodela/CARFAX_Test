//
//  ListingsViewController.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager
            .shared
            .fetchVehicleListings()
    }
}

