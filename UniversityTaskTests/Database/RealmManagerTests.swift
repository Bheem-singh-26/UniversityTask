//
//  RealmManagerTests.swift
//  UniversityTaskTests
//
//  Created by Bheem Singh on 08/08/24.
//

import XCTest
import RealmSwift
@testable import UniversityTask

class TestObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class RealmManagerTests: XCTestCase {
    
    var realmManager: RealmManager!
    var inMemoryRealm: Realm!
    
    override func setUp() {
        super.setUp()
        realmManager = RealmManager()
        
        // Configure in-memory Realm
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        inMemoryRealm = try! Realm(configuration: config)
        
        // Set the default Realm configuration to the in-memory Realm for the duration of the tests
        Realm.Configuration.defaultConfiguration = config
    }
    
    override func tearDown() {
        realmManager = nil
        inMemoryRealm = nil
        super.tearDown()
    }
    
    func testCreate() {
        // Arrange
        let testObjects = [TestObject(value: ["id": 1, "name": "Test1"]), TestObject(value: ["id": 2, "name": "Test2"])]
        
        // Act
        realmManager.create(testObjects)
        
        // Assert
        let results = inMemoryRealm.objects(TestObject.self)
        XCTAssertEqual(results.count, 2)
        XCTAssertEqual(results[0].name, "Test1")
        XCTAssertEqual(results[1].name, "Test2")
    }
    
    func testFetchAll() {
        // Arrange
        let testObjects = [TestObject(value: ["id": 1, "name": "Test1"]), TestObject(value: ["id": 2, "name": "Test2"])]
        try! inMemoryRealm.write {
            inMemoryRealm.add(testObjects)
        }
        
        // Act
        let results = realmManager.fetchAll(TestObject.self)
        
        // Assert
        XCTAssertEqual(results.count, 2)
        XCTAssertEqual(results[0].name, "Test1")
        XCTAssertEqual(results[1].name, "Test2")
    }
    
    func testDeleteAll() {
        // Arrange
        let testObjects = [TestObject(value: ["id": 1, "name": "Test1"]), TestObject(value: ["id": 2, "name": "Test2"])]
        try! inMemoryRealm.write {
            inMemoryRealm.add(testObjects)
        }
        
        // Act
        let expectation = self.expectation(description: "Delete completion")
        realmManager.deleteAll(TestObject.self) { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 1, handler: nil)
        let results = inMemoryRealm.objects(TestObject.self)
        XCTAssertEqual(results.count, 0)
    }
}
