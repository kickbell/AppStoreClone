//
//  SpacerView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/20/23.
//

import UIKit

class SpacerView: UIView {
    
    enum Axis {
        case horizontal, vertical
    }
    
    init(space: CGFloat? = nil, for axis: Axis? = nil) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let validSpace = space {
            // space 값이 주어지면 해당 높이/너비 설정 (기본값: .vertical)
            let direction: NSLayoutDimension = (axis == .horizontal) ? self.widthAnchor : self.heightAnchor
            NSLayoutConstraint.activate([
                direction.constraint(equalToConstant: validSpace)
            ])
        } else if let validAxis = axis {
            switch validAxis {
            case .horizontal:
                self.setContentHuggingPriority(UILayoutPriority(0), for: .horizontal)
                self.setContentCompressionResistancePriority(UILayoutPriority(0), for: .horizontal)
            case .vertical:
                self.setContentHuggingPriority(UILayoutPriority(0), for: .vertical)
                self.setContentCompressionResistancePriority(UILayoutPriority(0), for: .vertical)
            }
        } else {
            // No space or axis is provided, so default to vertical space of 10
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 10)
            ])
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
