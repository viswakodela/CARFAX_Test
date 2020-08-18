//
//  UIColor+Extension.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

extension UIColor {
    /// Convenience initializer that generates a UIColor based on an RGB integer value. Takes an
    /// optional `alpha` value.
    ///
    /// - Parameters:
    ///   - rgb: The color's RGB value, e.g. `0xE87722`.
    ///   - alpha: The color's alpha value, from 0 to 1. Defaults to full opacity.
    ///
    convenience init(rgb: Int, alpha: CGFloat = 1) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    
    struct CustomColors {
        static let grayColor        = UIColor(rgb: 0xbfbfbd)
    }
}

public extension UIColor {

    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        }
        else {
            self.init(cgColor: light.cgColor)
        }
    }
}
