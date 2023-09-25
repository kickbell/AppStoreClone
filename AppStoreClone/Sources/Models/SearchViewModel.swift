//
//  SearchViewModel.swift
//  AppStoreClone
//
//  Created by ksmartech on 2023/09/20.
//

import UIKit

struct SearchViewModel: Equatable {
    let screenshotImages: [String]
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
    let userRatingCount: String
}
