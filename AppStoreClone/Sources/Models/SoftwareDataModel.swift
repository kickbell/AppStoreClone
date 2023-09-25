//
//  SoftwareDataModel.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/19/23.
//

import UIKit
import Kingfisher

struct SoftwareDataModel: Codable, Equatable {
    let screenshotUrls: [String]
    let ipadScreenshotUrls: [String]
    let artworkUrl512: String
    let languageCodesISO2A: [String]
    let contentAdvisoryRating: String
    let trackContentRating: String
    let sellerName: String
    let trackName: String
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let version: String
    let description: String
    let artistName: String
    let genres: [String]
    let averageUserRating: Double
    let userRatingCount: Int64
}

extension SoftwareDataModel {
    func toViewModel(completion: @escaping (SearchViewModel?) -> Void) {
        let releaseDateCalculator = ReleaseDateCalculator()
        let formattedCurrentVersionReleaseDate = releaseDateCalculator.timeSinceRelease(self.currentVersionReleaseDate)
        let formattedAverageUserRating = averageUserRating.rounded(toDecimalPlaces: 1)
        let formattedUserRatingCount = ReviewFormatter.format(with: userRatingCount)
        
        let viewModel = SearchViewModel(
            screenshotImages: self.screenshotUrls,
            ipadScreenshotUrls: self.ipadScreenshotUrls,
            artworkUrl512: self.artworkUrl512,
            languageCodesISO2A: self.languageCodesISO2A,
            contentAdvisoryRating: self.contentAdvisoryRating,
            trackContentRating: self.trackContentRating,
            sellerName: self.sellerName,
            trackName: self.trackName,
            currentVersionReleaseDate: formattedCurrentVersionReleaseDate,
            releaseNotes: self.releaseNotes,
            version: self.version,
            description: self.description,
            artistName: self.artistName,
            genres: self.genres,
            averageUserRating: formattedAverageUserRating,
            userRatingCount: formattedUserRatingCount
        )
        
        completion(viewModel)
    }
}
