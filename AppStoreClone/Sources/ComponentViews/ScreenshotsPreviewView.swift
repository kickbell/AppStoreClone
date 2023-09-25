//
//  ScreenshotsPreviewView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/18/23.
//

import UIKit
import Kingfisher

class ScreenshotsPreviewView: UIView {
    
    //MARK: - Models
    
    struct Info {
        enum DeviceType: String, CustomStringConvertible {
            case iphone
            case ipad
            case watch
            case mac
            
            var description: String {
                switch self {
                case .iphone: return "iPhone"
                case .ipad: return "iPad"
                case .watch: return "Watch"
                case .mac: return "Mac"
                }
            }
        }
        
        let images: [String]
        let imageSize: CGSize
        let type: DeviceType
    }
    
    //MARK: - Properties
    
    private var didSetupOnce: Bool = false
    
    private var isTitleAndTypeHidden: Bool = false
    
    var info: Info?
    
    //MARK: - LifeCycles
    
    init(isTitleAndTypeHidden: Bool = false) {
        self.isTitleAndTypeHidden = isTitleAndTypeHidden
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Views
    
    private let previewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "미리 보기"
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .title3b)
        label.textColor = .label
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let screenShotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let deviceTypeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.tintColor = .secondaryLabel
        button.titleLabel?.font = UIFont.dynamicSystemFont(for: .subhead)
        return button
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton()
        button.tintColor = .clear //구현 전 임시 숨김처리
        //        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        //        button.addTarget(self, action: #selector(expandButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let deviceTypeStackView: UIStackView = {
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
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
}

extension ScreenshotsPreviewView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let info = self.info else { return }
        
        let pageWidth = info.imageSize.width + screenShotStackView.spacing
        let currentPage = round(scrollView.contentOffset.x / pageWidth)
        
        if velocity.x > 0 {
            targetContentOffset.pointee.x = (currentPage + 1) * pageWidth
        } else {
            targetContentOffset.pointee.x = (currentPage - 1) * pageWidth
        }
    }
}


//MARK: - Methods

extension ScreenshotsPreviewView {
    func reset() {
        screenShotStackView.arrangedSubviews.forEach { subview in
            screenShotStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        deviceTypeButton.setTitle(nil, for: .normal)
        deviceTypeButton.setImage(nil, for: .normal)
        didSetupOnce = false
        info = nil
        previewTitleLabel.isHidden = isTitleAndTypeHidden
        deviceTypeStackView.isHidden = isTitleAndTypeHidden
    }
    
    @objc
    private func expandButtonDidTap() {
        print(#function)
    }
    
    func configure(with info: Info) {
        guard !didSetupOnce else { return }
        
        self.info = info
        
        let totalWidth = CGFloat(info.images.count) * info.imageSize.width + CGFloat(info.images.count - 1) * screenShotStackView.spacing
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: totalWidth)
        ])
        
        info.images.forEach { imageURL in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 20
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = UIColor.lightGray
            imageView.layer.masksToBounds = true
            imageView.kf.setImage(with: URL(string: imageURL))
            screenShotStackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: info.imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: info.imageSize.height)
            ])
        }
        
        deviceTypeButton.setTitle("   \(info.type.description)", for: .normal)
        deviceTypeButton.setImage(UIImage(systemName: info.type.rawValue), for: .normal)
        
        didSetupOnce = true
    }
    
}

//MARK: - Setups

extension ScreenshotsPreviewView {
    private func setup() {
        setupUI()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupUI() {
        previewTitleLabel.isHidden = isTitleAndTypeHidden
        deviceTypeStackView.isHidden = isTitleAndTypeHidden
    }
    
    private func setupViews() {
        contentView.addSubview(screenShotStackView)
        scrollView.addSubview(contentView)
        deviceTypeStackView.addArrangedSubviews([deviceTypeButton, expandButton])
        totalStackView.addArrangedSubviews([previewTitleLabel, scrollView, deviceTypeStackView])
        addSubview(totalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            previewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: previewTitleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            screenShotStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            screenShotStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screenShotStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screenShotStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            totalStackView.topAnchor.constraint(equalTo: topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupDelegates() {
        scrollView.delegate = self
    }
}

