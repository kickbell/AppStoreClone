//
//  AppIconDetailView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//
import UIKit
import Kingfisher

class AppIconDetailView: UIView {
    
    //MARK: - Models
    
    struct Info {
        let artworkUrl512: String
        let sellerName: String //판매자
        let trackName : String //앱이름
    }
    
    //MARK: - Properties
    
    var info: Info?{
        didSet{
            updateUI()
        }
    }
    
    var downloadButtonClosure: () -> () = {}
    
    var shareButtonClosure: () -> () = {}
    
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
        label.font = UIFont.dynamicSystemFont(for: .title3b)
        label.textColor = .label
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .body)
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
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.setImage(
            UIImage(
                systemName: "square.and.arrow.up",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)
            ), for: .normal)
        button.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
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
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .fill
        return stackView
    }()
    
}


//MARK: - Methods

extension AppIconDetailView {
    private func updateUI() {
        guard let info = self.info else { return }
        
        DispatchQueue.main.async {
            self.iconImageView.kf.setImage(with: URL(string: info.artworkUrl512))
            self.titleLabel.text = info.trackName
            self.titleLabel.accessibilityLabel = info.trackName
            self.subtitleLabel.text = info.sellerName
            self.subtitleLabel.accessibilityLabel = info.sellerName
            
            self.downloadButton.accessibilityLabel = "\(info.trackName) 받기"
        }
    }
    
    @objc
    private func handleContentSize() {
        titleLabel.font = UIFont.dynamicSystemFont(for: .title3b)
        subtitleLabel.font = UIFont.dynamicSystemFont(for: .body)
        
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
    
    @objc
    private func shareButtonDidTap() {
        print(#function)
        shareButtonClosure()
    }
}

//MARK: - Setups

extension AppIconDetailView {
    private func setup() {
        setupViews()
        setupConstraints()
        setupNotifications()
    }
    
    private func setupViews() {
        buttonsStackView.addArrangedSubviews([downloadButton, shareButton])
        vStackView.addArrangedSubviews([titleLabel, subtitleLabel, SpacerView(for: .vertical), buttonsStackView])
        totalStackView.addArrangedSubviews([iconImageView, vStackView])
        addSubview(totalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            iconImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4),
            iconImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4),
            
            downloadButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleContentSize), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
