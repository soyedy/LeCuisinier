//
//  Extensions+Enums.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

enum FetchError: Error {
  case invalidURL
  case requestFailed(Int)
  case failedWhileFetching
  case failedWhileDecoding
  case noCategoriesFound
  case noInternetConnectionFound
}

enum NetworkServiceError: Error {
  case invalidURL
  case requestFailed
  case failedWhileDecoding
}
