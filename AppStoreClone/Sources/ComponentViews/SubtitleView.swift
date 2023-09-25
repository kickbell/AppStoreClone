//
//  SubtitleView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

class SubtitleView: UIView {
    
    //MARK: - Models
    
    struct Info {
        let title: String
        let subtitle: String
    }
    
    var info: Info?{
        didSet{
            updateUI()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.dynamicSystemFont(for: .subhead)
        label.textColor = .systemBlue
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.dynamicSystemFont(for: .subhead)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupViews()
    }
    
    private func setupUI() {
    }
    
    private func updateUI() {
        guard let info = self.info else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = info.title
            self.subtitleLabel.text = info.subtitle
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(accessoryImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            accessoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            accessoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 15),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}
