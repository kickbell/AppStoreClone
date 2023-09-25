//
//  ViewFactory.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

struct ViewFactory {
    static func create<T: UIView>(_ viewType: T.Type, initializer: (() -> T)? = nil) -> T {
        if let initializer = initializer {
            return initializer()
        } else {
            return viewType.init()
        }
    }
}

extension ViewFactory {
  static func create(_ viewType: SeparatorView.Type, direction: SeparatorView.Direction) -> SeparatorView {
      return SeparatorView(direction: direction)
  }
  
  static func create(
    _ viewType: AppInfoVStackView.Type,
    info: AppInfoVStackView.Info,
    style: AppInfoVStackView.Style) -> AppInfoVStackView {
      return AppInfoVStackView(info: info, style: style)
  }
}
