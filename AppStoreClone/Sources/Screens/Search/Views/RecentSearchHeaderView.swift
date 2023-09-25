//
//  RecentSearchHeaderView.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/19/23.
//

import UIKit

final class RecentSearchHeaderView: UITableViewHeaderFooterView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최근 검색어"
        label.textColor = .label
        label.font = UIFont.dynamicSystemFont(for: .title3b)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
}
