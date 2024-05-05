//
//  NetworkService.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

protocol NetworkServiceProtocol {
  func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
  func fetchData<T>(from urlString: String, as type: T.Type) async throws -> T where T : Decodable {
    guard let url = URL(string: urlString) else {
      throw NetworkServiceError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
      throw NetworkServiceError.requestFailed
    }
    return try decodeData(data: data, as: type)
  }
  
  private func decodeData<T: Decodable>(data: Data, as type: T.Type) throws -> T {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(type, from: data)
    } catch {
      throw NetworkServiceError.failedWhileDecoding
    }
  }
}
