//
//  UniversityListRepository.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import RealmSwift

protocol UniversityListRepository: Repository {}

final class UniversityListRepositoryImpl: UniversityListRepository {
    
    typealias T = University
    
    private let apiClient: APIClient!
    private let database: RealmManager!
    private let network: Network!
        
    init(apiClient: APIClient, database: RealmManager, network: Network) {
        self.apiClient = apiClient
        self.database = database
        self.network = network
    }
    
    func fetchList(shouldRefresh: Bool, completionHandler: @escaping (Result<[University], Error>) -> Void) {
        
        let localList = fetchLocalList()
        if localList.isEmpty || shouldRefresh {
            
            if !Reachability().isConnectedToNetwork(){
                let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: Constants.StringConstant.NetworkNotFound])
                completionHandler(.failure(error))
            }
                
            fetchRemoteList { result in
                completionHandler(result)
            }
        } else {
            completionHandler(.success(localList))
        }
    }
    
    private func fetchRemoteList(completionHandler: @escaping (Result<[University], Error>) -> Void) {
        apiClient.getAPIData(requestUrl: APIEndpoint.universityList, resultType: [University].self) { [weak self] result in
            switch result {
            case .success(let result):
                self?.saveList(result: result)
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    private func saveList(result: [University]) {
        if fetchLocalList().isEmpty {
            database.create(result)
        }
    }
    
    
    private func fetchLocalList() -> [University] {
        return database.fetchAll(University.self)
    }
    
}
