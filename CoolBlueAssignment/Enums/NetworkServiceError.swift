enum NetworkServiceError: Error {
	case failedToDecode
	case graphqlResponseError
	case failedToFetchStoreList
	
	var description: String {
		switch self {
		case .failedToDecode:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		case .graphqlResponseError:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		case .failedToFetchStoreList:
			return "Opps!!! Something is wrong but don't worry. Please contact us!"
		}
	}
}
