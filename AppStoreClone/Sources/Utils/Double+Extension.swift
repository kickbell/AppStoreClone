//
//  Double+Extension.swift
//  AppStoreClone
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation

extension Double {
    func rounded(toDecimalPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
