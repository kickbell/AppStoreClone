//
//  UIFont+Utils.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/19/23.
//

import UIKit

struct FontStyle {
    var size: CGFloat
    var weight: UIFont.Weight
}

enum TextStyles {
    case title3
    case title3b
    case body
    case bodyb
    case subhead
    case subheadb
    case caption1
    case caption1b
    case caption2
    case caption2b
    case custom(fontSize: CGFloat, weight: UIFont.Weight)
    
    var fontStyle: FontStyle {
        switch self {
        case .title3:
            return FontStyle(size: 20, weight: .regular)
        case .title3b:
            return FontStyle(size: 20, weight: .bold)
        case .body:
            return FontStyle(size: 17, weight: .regular)
        case .bodyb:
            return FontStyle(size: 17, weight: .bold)
        case .subhead:
            return FontStyle(size: 15, weight: .regular)
        case .subheadb:
            return FontStyle(size: 15, weight: .bold)
        case .caption1:
            return FontStyle(size: 12, weight: .regular)
        case .caption1b:
            return FontStyle(size: 12, weight: .bold)
        case .caption2:
            return FontStyle(size: 11, weight: .regular)
        case .caption2b:
            return FontStyle(size: 11, weight: .bold)
        case .custom(let fontSize, let weight):
            return FontStyle(size: fontSize, weight: weight)
        }
    }
}

extension UIFont {
    static func dynamicSystemFont(
        for style: TextStyles,
        minPointSize: CGFloat = 10.0,
        maxPointSize: CGFloat = 50.0
    ) -> UIFont {
        let font = UIFont.systemFont(ofSize: style.fontStyle.size, weight: style.fontStyle.weight)
        let metrics = UIFontMetrics(forTextStyle: .body)
        return metrics.scaledFont(for: font, maximumPointSize: maxPointSize, compatibleWith: nil)
    }
}
