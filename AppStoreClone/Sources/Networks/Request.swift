//
//  Request.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation

protocol Request {
  associatedtype RequestDataType
  associatedtype ResponseDataType
  
  func makeRequest(from endpoint: RequestDataType) throws -> URLRequest
  func parseResponse(data: Data) throws -> ResponseDataType
}

