//
//  UniversityListRepository.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation

protocol UniversityListRepository {
    func fetchUniversityList(completion: @escaping(Result<[University], Error>)-> Void)
}

final class UniversityListRepositoryImpl: UniversityListRepository {
    
    func fetchUniversityList(completion: @escaping (Result<[University], Error>) -> Void) {
        HttpUtility.shared.getAPIData(requestUrl: APIEndpoint.universityList, resultType: [University].self) { result in
            completion(result)
        }
    }
    
}
