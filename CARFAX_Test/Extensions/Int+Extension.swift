//
//  Int+Extension.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

extension Int {
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    var formattedPrice: String {
        "\(Int.numberFormatter.string(from: NSNumber(value: self)) ?? String(self))"
    }
}
