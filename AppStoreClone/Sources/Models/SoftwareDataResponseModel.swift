//
//  SoftwareDataResponseModel.swift
//  AppStoreClone
//
//  Created by ksmartech on 2023/09/20.
//

import Foundation

struct SoftwareDataResponseModel: Codable {
    let resultCount: Int
    let results: [SoftwareDataModel]
}
