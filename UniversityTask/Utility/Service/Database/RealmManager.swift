//
//  RealmManager.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import RealmSwift

class RealmManager {
    
    init() {}
    
    // MARK: - Create
    
    func create<T: Object>(_ objects: [T]) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(objects)
            }
            realm.invalidate()
        } catch {
            print("Error creating objects: \(error)")
        }
    }
    
    
    // MARK: - Read
    
    func fetchAll<T: Object>(_ objectType: T.Type) -> [T] {
        let realm = try! Realm()
        let results = realm.objects(objectType)
        return Array(results)
    }
    
    // MARK: - Delete
    
    func deleteAll<T: Object>(_ objectType: T.Type, completion: @escaping(Bool) -> Void) {
        do {
            let realm = try! Realm()
            let objects = realm.objects(objectType)
            try realm.write {
                realm.delete(objects)
                completion(true)
            }
            realm.invalidate()
        } catch {
            completion(false)
            print("Error deleting all objects: \(error)")
        }
    }
    
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
