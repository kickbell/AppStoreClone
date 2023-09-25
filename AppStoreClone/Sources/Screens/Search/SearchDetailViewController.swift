//
//  SearchDetailViewController.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import UIKit

class SearchDetailViewControler: UIViewController {
    //MARK: - Properties
    
    
    //MARK: - LifeCycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: - Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let releaseNoteView = ShowMoreView()
    
    private let appIconDetailView = AppIconDetailView()
    
    private let appInfoDetailView = AppInfoDetailView()
    
    private let screenshotsPreviewView = ScreenshotsPreviewView()
    
    private let newFeatureView = NewFeatureView()
    
    private let descriptionView = ShowMoreView()
    
    private let subtitleView = SubtitleView()
}


//MARK: - Methods


extension SearchDetailViewControler {
    private func createView<T: UIView>(
        _ viewType: T.Type,
        initializer: (() -> T)? = nil) -> T {
            if let initializer = initializer {
                return initializer()
            } else {
                return T.init()
            }
        }
    
    
    func configure(with info: SearchViewModel) {
        let appIconContainerInfo = AppIconDetailView.Info(
            artworkUrl512: info.artworkUrl512,
            sellerName: info.sellerName,
            trackName: info.trackName
        )
        appIconDetailView.info = appIconContainerInfo
        
        let appInfoContainerInfo = AppInfoDetailView.Info(
            userRatingCount: info.userRatingCount,
            averageUserRating: info.averageUserRating,
            contentAdvisoryRating: info.contentAdvisoryRating,
            trackContentRating: info.trackContentRating,
            genres: info.genres,
            artistName: info.artistName,
            languageCodesISO2A: info.languageCodesISO2A
        )
        appInfoDetailView.info = appInfoContainerInfo
        
        let newFeatureContainerInfo = NewFeatureView.Info(
            version: info.version,
            currentVersionReleaseDate: info.currentVersionReleaseDate
        )
        newFeatureView.info = newFeatureContainerInfo
        newFeatureView.versionHistoryButton.accessibilityLabel = "\(info.trackName)의 버전 기록"

        releaseNoteView.text = info.releaseNotes
        releaseNoteView.showMoreButton.accessibilityLabel = "\(info.trackName)의 새로운 기능 더보기"
        
        let screenshotsPreviewInfo = ScreenshotsPreviewView.Info(
            images: info.screenshotImages,
            imageSize: CGSize(width: 250, height: 500),
            type: .iphone
        )
        screenshotsPreviewView.configure(with: screenshotsPreviewInfo)
        
        descriptionView.text = info.description
        descriptionView.showMoreButton.accessibilityLabel = "\(info.trackName)의 앱 설명 더보기"

        let subtitleInfo = SubtitleView.Info(title: info.artistName, subtitle: "개발자")
        subtitleView.info = subtitleInfo
    }
}


//MARK: - Setups

extension SearchDetailViewControler {
    private func setup() {
        setupUI()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupViews() {
        stackView.addArrangedSubviews([
            appIconDetailView,
            ViewFactory.create(SeparatorView.self, direction: .horizontal),
            appInfoDetailView,
            ViewFactory.create(SeparatorView.self, direction: .horizontal),
            newFeatureView,
            releaseNoteView,
            ViewFactory.create(SeparatorView.self, direction: .horizontal),
            screenshotsPreviewView,
            ViewFactory.create(SeparatorView.self, direction: .horizontal),
            descriptionView,
            SpacerView(),
            subtitleView,
        ])
        contentView.addSubview(stackView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -44),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupDelegates() {
    }
}







