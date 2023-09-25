//
//  ReviewFormatter.swift
//  AppStoreClone
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation

class ReviewFormatter {
    static func format(with reviewCount: Int64) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let thousandLimit: Int64 = 1_000
        let tenThousandLimit: Int64 = 10_000
        
        switch reviewCount {
        case 0..<thousandLimit:
            return "\(reviewCount)"
        case thousandLimit..<tenThousandLimit:
            let thousands = Double(reviewCount) / Double(thousandLimit)
            formatter.maximumFractionDigits = (reviewCount % thousandLimit == 0) ? 0 : 1
            return "\(formatter.string(from: NSNumber(value: thousands)) ?? "")천"
        default:
            let tenThousands = Double(reviewCount) / Double(tenThousandLimit)
            formatter.maximumFractionDigits = (reviewCount % tenThousandLimit == 0) ? 0 : 1
            return "\(formatter.string(from: NSNumber(value: tenThousands)) ?? "")만"
        }
    }
}
