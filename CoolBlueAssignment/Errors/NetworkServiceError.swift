//
//  NetworkServiceError.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//

import Foundation

enum NetworkServiceError: Error {
	case failedToDecode
	case graphqlResponseError
	case failedToFetchStoreList
	case failedToGetUserLocation
	
	var description: String {
		switch self {
		case .failedToDecode:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		case .graphqlResponseError:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		case .failedToFetchStoreList:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		case .failedToGetUserLocation:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		}
	}
}
