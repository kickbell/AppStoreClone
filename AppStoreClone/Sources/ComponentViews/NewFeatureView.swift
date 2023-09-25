//
//  NewFeatureContainerView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//
import UIKit

class NewFeatureView: UIView {
    
    //MARK: - Models
    
    struct Info {
        let version: String
        let currentVersionReleaseDate: String
    }
    
    //MARK: - Properties
    
    var info: Info?{
        didSet{
            updateUI()
        }
    }
    
    var versionHistoryButtonClosure: () -> () = {}
    
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
    
    private let newFeatureLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 기능"
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .title3b)
        label.textColor = .label
        return label
    }()
    
    lazy var versionHistoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("버전 기록", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.dynamicSystemFont(for: .body)
        button.accessibilityLabel = "버전 기록"
        button.addTarget(self, action: #selector(versionHistoryButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "버전 정보 없음"
        label.textAlignment = .left
        label.font = UIFont.dynamicSystemFont(for: .subhead)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 정보 없음"
        label.textAlignment = .right
        label.font = UIFont.dynamicSystemFont(for: .body)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()
    
}


//MARK: - Methods

extension NewFeatureView {
    private func updateUI() {
        DispatchQueue.main.async {
            self.versionLabel.text = "버전 \(self.info?.version ?? "정보 없음")"
            self.versionLabel.accessibilityLabel = self.versionLabel.text
            
            self.lastUpdatedLabel.text = self.info?.currentVersionReleaseDate ?? "업데이트 정보 없음"
            self.lastUpdatedLabel.accessibilityLabel = self.lastUpdatedLabel.text
        }
    }
    
    @objc
    private func handleContentSize() {
        newFeatureLabel.font = UIFont.dynamicSystemFont(for: .title3b)
        versionHistoryButton.titleLabel?.font = UIFont.dynamicSystemFont(for: .caption1)
        versionLabel.font = UIFont.dynamicSystemFont(for: .caption1)
        lastUpdatedLabel.font = UIFont.dynamicSystemFont(for: .caption1)
        
        let intrinsicContentWidth = versionLabel.intrinsicContentSize.width
        let screenWidth = UIScreen.main.bounds.width
        
        if intrinsicContentWidth > (screenWidth/2) {
            self.topStackView.axis = .vertical
            self.bottomStackView.axis = .vertical
        } else {
            self.topStackView.axis = .horizontal
            self.bottomStackView.axis = .horizontal
        }
    }
    
    @objc
    private func versionHistoryButtonDidTap() {
        print(#function)
        versionHistoryButtonClosure()
    }
}

//MARK: - Setups

extension NewFeatureView {
    private func setup() {
        setupViews()
        setupConstraints()
        setupNotifications()
    }
    
    private func setupViews() {
        topStackView.addArrangedSubviews([newFeatureLabel, versionHistoryButton])
        bottomStackView.addArrangedSubviews([versionLabel, lastUpdatedLabel])
        stackView.addArrangedSubviews([topStackView, bottomStackView])
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleContentSize), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
