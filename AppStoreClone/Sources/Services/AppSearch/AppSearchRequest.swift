//
//  AppSearchRequest.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation

struct AppSearchRequest: Request {
    func makeRequest(from endpoint: AppSearchEndpoint) throws -> URLRequest {
      var urlComponents = URLComponents()
      urlComponents.scheme = endpoint.scheme
      urlComponents.host = endpoint.host
      urlComponents.path = endpoint.path
      urlComponents.queryItems = endpoint.queryItems
      
      guard let url = urlComponents.url else {
        throw NetworkError.invalidURL(url: urlComponents.url?.absoluteString)
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = endpoint.method.rawValue
      request.allHTTPHeaderFields = endpoint.header
      
      if let body = endpoint.body {
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
      }
      
      return request
    }
    
    func parseResponse(data: Data) throws -> SoftwareDataResponseModel {
      return try JSONDecoder().decode(SoftwareDataResponseModel.self, from: data)
    }
}
