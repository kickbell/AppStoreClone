//
//  EndPoint.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation

protocol EndPoint {  
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: HttpMethod { get }
  var header: [String: String]? { get }
  var body: [String: String]? { get }
  var queryItems: [URLQueryItem] { get }
}
