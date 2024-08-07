//
//  Repository.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation

protocol Repository {
    associatedtype T
    func fetchList(shouldRefresh: Bool, completionHandler: @escaping (Result<[University], Error>) -> Void)
}
