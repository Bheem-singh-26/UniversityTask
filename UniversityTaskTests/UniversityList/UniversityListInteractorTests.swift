//
//  UniversityListInteractorTests.swift
//  UniversityTaskTests
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import XCTest
@testable import UniversityTask

class MockUniversityListRepository: UniversityListRepository {
    typealias T = University
    
    var shouldReturnError = false
    var universities: [University] = []

    func fetchList(shouldRefresh: Bool, completionHandler: @escaping (Result<[University], Error>) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error fetching universities"])
            completionHandler(.failure(error))
        } else {
            completionHandler(.success(universities))
        }
    }
}

class MockUniversityListOutputInteractor: UniversityListOutputInteractorProtocol {
    var fetchUniversityListSuccessCalled = false
    var fetchUniversityListFailureCalled = false
    var universities: [University]?
    var error: String?

    func fetchUniversityListSuccess(universities: [University]) {
        fetchUniversityListSuccessCalled = true
        self.universities = universities
    }

    func fetchUniversityListFailure(error: String) {
        fetchUniversityListFailureCalled = true
        self.error = error
    }
}

class UniversityListInteractorTests: XCTestCase {
    
    var interactor: UniversityListInteractor!
    var mockRepository: MockUniversityListRepository!
    var mockPresenter: MockUniversityListOutputInteractor!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUniversityListRepository()
        mockPresenter = MockUniversityListOutputInteractor()
        interactor = UniversityListInteractor(repository: mockRepository)
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        interactor = nil
        mockRepository = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testFetchUniversityList_Success() {
        // Arrange
        let university = University()
        mockRepository.universities = [university]
        
        // Act
        interactor.fetchUniversityList(shouldRefresh: false)
        
        // Assert
        XCTAssertTrue(mockPresenter.fetchUniversityListSuccessCalled)
        XCTAssertEqual(mockPresenter.universities?.count, 1)
        XCTAssertEqual(mockPresenter.universities?.first, university)
    }
    
    func testFetchUniversityList_Failure() {
        // Arrange
        mockRepository.shouldReturnError = true
        
        // Act
        interactor.fetchUniversityList(shouldRefresh: false)
        
        // Assert
        XCTAssertTrue(mockPresenter.fetchUniversityListFailureCalled)
        XCTAssertEqual(mockPresenter.error, "Error fetching universities")
    }
}

