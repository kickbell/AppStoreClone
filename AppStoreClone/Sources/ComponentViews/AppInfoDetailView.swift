//
//  AppInfoDetailView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/17/23.
//

import UIKit

class AppInfoDetailView: UIView {
  
  //MARK: - Models
  
  struct Info {
    let userRatingCount: String //평가수
    let averageUserRating: Double //평균 평점
    let contentAdvisoryRating: String //연령
    let trackContentRating: String //장르에서의 랭킹순위
    let genres: [String] //장르
    let artistName: String //개발자
    let languageCodesISO2A: [String] //지원언어
  }
  
  //MARK: - Properties
  
  var info: Info?{
    didSet{
      updateUI()
    }
  }
  
  //MARK: - LifeCycles
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  //MARK: - Views
  
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
  
  private let horizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.alignment = .fill
    return stackView
  }()
}


//MARK: - Methods

extension AppInfoDetailView {
  @objc
  private func expandButtonDidTap() {
    print(#function)
  }
  
  private func updateUI() {
    guard let info = self.info else { return }
    
    let appInfo = AppInfoVStackView.Info(
      userRatingCount: info.userRatingCount,
      averageUserRating: info.averageUserRating,
      contentAdvisoryRating: info.contentAdvisoryRating,
      trackContentRating: info.trackContentRating,
      genres: info.genres,
      artistName: info.artistName,
      languageCodesISO2A: info.languageCodesISO2A
    )
    
    horizontalStackView.addArrangedSubviews([
      ViewFactory.create(AppInfoVStackView.self, info: appInfo, style: .star),
      ViewFactory.create(SeparatorView.self, direction: .vertical),
      ViewFactory.create(AppInfoVStackView.self, info: appInfo, style: .age),
      ViewFactory.create(SeparatorView.self, direction: .vertical),
      ViewFactory.create(AppInfoVStackView.self, info: appInfo, style: .genre),
      ViewFactory.create(SeparatorView.self, direction: .vertical),
      ViewFactory.create(AppInfoVStackView.self, info: appInfo, style: .artist),
      ViewFactory.create(SeparatorView.self, direction: .vertical),
      ViewFactory.create(AppInfoVStackView.self, info: appInfo, style: .language),
    ])
  }
}

//MARK: - Setups

extension AppInfoDetailView {
  private func setup() {
    setupUI()
    setupViews()
    setupConstraints()
    setupDelegates()
  }
  
  private func setupUI() {
  }
  
  
  private func setupViews() {
    contentView.addSubview(horizontalStackView)
    scrollView.addSubview(contentView)
    addSubview(scrollView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      
      horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  private func setupDelegates() {
    
  }
}
