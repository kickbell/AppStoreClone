//
//  UITableView+Utils.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}

extension UITableViewHeaderFooterView: Reusable {}

public extension UITableView {
  func register<T: UITableViewCell>(cellType: T.Type) {
    self.register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type) {
    self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier )
  }
}
