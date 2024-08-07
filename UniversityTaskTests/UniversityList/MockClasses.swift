//
//  MockClasses.swift
//  UniversityTaskTests
//
//  Created by Bheem Singh on 07/08/24.
//

import XCTest
import RealmSwift
@testable import UniversityTask

class MockAPIClient: APIClient {
    var result: Result<[University], Error>?
    
    override func getAPIData<T>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let result = result as? Result<T, Error> {
            completionHandler(result)
        }
    }
}

class MockRealmManager: RealmManager {
    var universities: [University] = []
    
    override func fetchAll<T>(_ objectType: T.Type) -> [T] where T : Object {
        return universities as! [T]
    }
    
    override func create<T>(_ objects: [T]) where T : Object {
        universities.append(contentsOf: objects as! [University])
    }
}

class MockNetwork: Network {
    var isConnected: Bool = true
    
    func isConnectedToNetwork() -> Bool {
        return isConnected
    }
}
