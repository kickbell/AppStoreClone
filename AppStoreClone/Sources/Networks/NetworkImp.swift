//
//  NetworkImp.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation
import RxSwift

final class NetworkImp: Network {
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func send<T: Request>(_ request: T, _ requestData: T.RequestDataType) -> Observable<T.ResponseDataType> {
    do {
      let urlRequest = try request.makeRequest(from: requestData)
      
      return session.rx.data(request: urlRequest)
        .map { data in
          let response = try request.parseResponse(data: data)
          return response
        }
    } catch {
      return Observable.error(error)
    }
  }
  
}
