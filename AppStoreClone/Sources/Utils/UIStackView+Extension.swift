//
//  UIStackView+Extension.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { self.addArrangedSubview($0) }
  }
}
