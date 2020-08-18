//
//  VehicleListCell.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class VehicleListCell: UICollectionViewCell {
    
    // MARK:- Properties
    static let cellId           = String(describing: self)
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
