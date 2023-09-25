//
//  NetworkError.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation
import RxSwift

protocol Network: AnyObject {
  func send<T: Request>(_ request: T, _ requestData: T.RequestDataType) -> Observable<T.ResponseDataType>
}

enum NetworkError: Error {
  case unknown
  case invalidURL(url: String?)
  case requestFailed(response: HTTPURLResponse, data: Data?)
}
