//
//  ShowMoreView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

class ShowMoreView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var showMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.dynamicSystemFont(for: .subhead)
        button.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
        button.backgroundColor = .systemBackground
        button.isAccessibilityElement = true
        return button
    }()
    private var isExpanded = false
    
    var text: String?
    {
        didSet {
            label.text = text
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        showMoreButton.isHidden = label.numberOfLines < 6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        
        addSubview(label)
        addSubview(showMoreButton)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            showMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6),
        ])
    }
    
    
    @objc private func toggleExpand() {
        guard isExpanded == false else { return }
        isExpanded = true
        label.numberOfLines = isExpanded ? 0 : 6
        showMoreButton.isHidden = true
    }
}



