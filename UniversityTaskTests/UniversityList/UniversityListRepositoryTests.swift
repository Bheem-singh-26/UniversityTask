//
//  UniversityListRepositoryTests.swift
//  UniversityTaskTests
//
//  Created by Bheem Singh on 07/08/24.
//

import XCTest
import RealmSwift
@testable import UniversityTask

class UniversityListRepositoryTests: XCTestCase {
    
    var apiClient: MockAPIClient!
    var database: MockRealmManager!
    var network: MockNetwork!
    var repository: UniversityListRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        database = MockRealmManager()
        network = MockNetwork()
        repository = UniversityListRepositoryImpl(apiClient: apiClient, database: database, network: network)
    }
    
    override func tearDown() {
        apiClient = nil
        database = nil
        network = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchList_ShouldReturnLocalList_WhenLocalListIsNotEmptyAndShouldRefreshIsFalse() {
        // Arrange
        let university = University()
        database.universities = [university]
        
        // Act
        var result: Result<[University], Error>?
        repository.fetchList(shouldRefresh: false) { res in
            result = res
        }
        
        // Assert
        switch result {
        case .success(let list):
            XCTAssertEqual(list.count, 1)
        case .failure:
            XCTFail("Expected success, but got failure")
        case .none:
            XCTFail("Expected result, but got none")
        }
    }
    
    func testFetchList_ShouldFetchRemoteList_WhenLocalListIsEmptyOrShouldRefreshIsTrue() {
        // Arrange
        apiClient.result = .success([University()])
        network.isConnected = true
        
        // Act
        var result: Result<[University], Error>?
        repository.fetchList(shouldRefresh: true) { res in
            result = res
        }
        
        // Assert
        switch result {
        case .success(let list):
            XCTAssertEqual(list.count, 1)
        case .failure:
            XCTFail("Expected success, but got failure")
        case .none:
            XCTFail("Expected result, but got none")
        }
    }
    
    func testFetchList_ShouldReturnError_WhenNetworkIsNotConnected() {
        // Arrange
        network.isConnected = false
        
        // Act
        var result: Result<[University], Error>?
        repository.fetchList(shouldRefresh: true) { res in
            result = res
        }
        
        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure(let error):
            XCTAssertEqual((error as NSError).code, 401)
        case .none:
            XCTFail("Expected result, but got none")
        }
    }
    
    func testSaveList_ShouldSaveUniversities_WhenCalled() {
        // Arrange
        let universities = [University()]
        
        // Act
        repository.saveList(result: universities)
        
        // Assert
        XCTAssertEqual(database.universities.count, 1)
    }
}
