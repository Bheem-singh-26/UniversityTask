//
//  UniversityDetailInteractorTests.swift
//  UniversityTaskTests
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import XCTest
@testable import UniversityTask

class MockUniversityDetailOutputInteractor: UniversityDetailOutputInteractorProtocol {
    var fetchUniversityDetailSuccessCalled = false
    var fetchUniversityDetailFailureCalled = false
    var university: University?
    var error: String?
    
    func fetchUniversityDetailSuccess(university: University) {
        fetchUniversityDetailSuccessCalled = true
        self.university = university
    }
    
    func fetchUniversityDetailFailure(error: String) {
        fetchUniversityDetailFailureCalled = true
        self.error = error
    }
}

class UniversityDetailInteractorTests: XCTestCase {
    
    var interactor: UniversityDetailInteractor!
    var mockPresenter: MockUniversityDetailOutputInteractor!
    var testUniversity: University!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockUniversityDetailOutputInteractor()
        interactor = UniversityDetailInteractor()
        interactor.presenter = mockPresenter
        
        // Sample University data for testing
        testUniversity = University()
        
    }
    
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        testUniversity = nil
        super.tearDown()
    }
    
    func testFetchUniversityDetailSuccess() {
        // Arrange
        interactor.university = testUniversity
        
        // Act
        interactor.fetchUniversityDetail()
        
        // Assert
        XCTAssertTrue(mockPresenter.fetchUniversityDetailSuccessCalled)
        XCTAssertEqual(mockPresenter.university?.name, testUniversity.name)
    }
    
    func testFetchUniversityDetailFailure() {
        // Arrange
        interactor.university = nil
        
        // Act
        interactor.fetchUniversityDetail()
        
        // Assert
        XCTAssertTrue(mockPresenter.fetchUniversityDetailFailureCalled)
        XCTAssertEqual(mockPresenter.error, Constants.StringConstant.universityDetailNotFound)
    }
}

