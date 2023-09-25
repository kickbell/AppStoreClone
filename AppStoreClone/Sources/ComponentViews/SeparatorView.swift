//
//  SeparatorView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

class SeparatorView: UIView {
  
  //MARK: - Enums
  
  enum Direction {
    case horizontal
    case vertical
  }
  
  //MARK: - LifeCycles
  
  init(direction: Direction) {
    self.direction = direction
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    self.direction = .vertical
    super.init(coder: coder)
    setup()
  }
  
  //MARK: - Properties
  
  private var direction: Direction
  
  //MARK: - Views
  
  private let lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .opaqueSeparator
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
}

//MARK: - Setups

extension SeparatorView {
  private func setup() {
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    addSubview(lineView)
  }
  
  private func setupConstraints() {
    switch direction {
    case .horizontal:
      NSLayoutConstraint.activate([
        lineView.topAnchor.constraint(equalTo: topAnchor),
        lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        lineView.heightAnchor.constraint(equalToConstant: 1),
      ])
    case .vertical:
      NSLayoutConstraint.activate([
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        lineView.widthAnchor.constraint(equalToConstant: 1),
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
      ])
    }
  }
}
