//
//  SearchedTableViewCell.swift
//  TESTAPP
//
//  Created by jc.kim on 9/18/23.
//

import UIKit

class SearchedTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var tapClosure: () -> () = {}
  
    //MARK: - LifeCycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private let appIconListView = AppIconListView()
    
    private let screenshotsPreviewView = ScreenshotsPreviewView(isTitleAndTypeHidden: true)
    
    //MARK: - Views
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
}


//MARK: - Methods

extension SearchedTableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        appIconListView.reset()
        screenshotsPreviewView.reset()
    }
    
    @objc
    private func handleTap() {
        print(#function)
        tapClosure()
    }
    
    func configure(with info: SearchViewModel) {
        let appIconListinfo = AppIconListView.Info(
            artworkUrl512: info.artworkUrl512,
            sellerName: info.sellerName,
            trackName: info.trackName
        )
        appIconListView.configure(with: appIconListinfo)
        
        let width = UIScreen.main.bounds.width/3 - 20
        let height = width * 2
        let screenshotsPreviewInfo = ScreenshotsPreviewView.Info(
            images: Array(info.screenshotImages.prefix(3)),
            imageSize: CGSize(width: width, height: height),
            type: .iphone
        )
        screenshotsPreviewView.configure(with: screenshotsPreviewInfo)
    }
}

//MARK: - Setups

extension SearchedTableViewCell {
    private func setup() {
        setupViews()
        setupConstraints()
        setupGestures()
    }
    
    private func setupViews() {
        stackView.addArrangedSubviews([appIconListView, screenshotsPreviewView])
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        screenshotsPreviewView.addGestureRecognizer(tapGesture)
    }
}
