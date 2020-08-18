//
//  String+Extension.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pureNumber)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func callIfCallable(to number: String, viewController: UIViewController) {
        if let url = URL(string: "tel://" + number),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            viewController.showAlert(with: "The number is not valid, please try again", actions: [
                UIAlertAction(title: "Ok", style: .default, handler: nil)
            ])
        }
    }
}

fileprivate extension String {
    func indexOf(char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
}
