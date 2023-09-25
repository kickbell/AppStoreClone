//
//  AppIconListView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/18/23.
//

import UIKit
import Kingfisher

class AppIconListView: UIView {
    
    //MARK: - Models
    
    struct Info {
        let artworkUrl512: String
        let sellerName: String //판매자
        let trackName : String //앱이름
    }
    
    //MARK: - Properties
    
    private var didSetupOnce: Bool = false
    
    var downloadButtonClosure: () -> () = {}
    
    //MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIContentSizeCategory.didChangeNotification, object: nil
        )
    }
    
    //MARK: - Views
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .body)
        label.textColor = .label
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .subhead)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("      받기      ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.dynamicSystemFont(for: .subheadb)
        button.addTarget(self, action: #selector(downloadButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        return button
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.alignment = .fill
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
}


//MARK: - Methods

extension AppIconListView {
    func reset() {
        iconImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        
        didSetupOnce = false
    }
    
    func configure(with info: Info) {
        guard !didSetupOnce else { return }
        
        DispatchQueue.main.async {
            self.iconImageView.kf.setImage(with: URL(string: info.artworkUrl512))
            self.titleLabel.text = info.trackName
            self.titleLabel.accessibilityLabel = info.trackName
            self.subtitleLabel.text = info.sellerName
            self.subtitleLabel.accessibilityLabel = info.sellerName
            
            self.downloadButton.accessibilityLabel = "\(info.trackName) 받기"
        }
        
        didSetupOnce = true
    }
    
    @objc
    private func handleContentSize() {
        titleLabel.font = UIFont.dynamicSystemFont(for: .title3b)
        subtitleLabel.font = UIFont.dynamicSystemFont(for: .caption1)
        
        let intrinsicContentWidth = titleLabel.intrinsicContentSize.width
        let screenWidth = UIScreen.main.bounds.width
        
        if intrinsicContentWidth > (screenWidth/2) {
            self.totalStackView.axis = .vertical
        } else {
            self.totalStackView.axis = .horizontal
        }
    }
    
    @objc
    private func downloadButtonDidTap() {
        print(#function)
        downloadButtonClosure()
    }
}

//MARK: - Setups

extension AppIconListView {
    private func setup() {
        setupViews()
        setupConstraints()
        setupNotifications()
    }
    
    private func setupViews() {
        vStackView.addArrangedSubviews([titleLabel, subtitleLabel, SpacerView()])
        totalStackView.addArrangedSubviews([iconImageView, vStackView, downloadButton])
        addSubview(totalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleContentSize), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}

