//
//  UniversityDetailInteractor.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation

final class UniversityDetailInteractor: UniversityDetailInputInteractorProtocol {
    
    var university: University?
    
    weak var presenter: UniversityDetailOutputInteractorProtocol?
    
    func fetchUniversityDetail() {
        if let detail = university {
            presenter?.fetchUniversityDetailSuccess(university: detail)
        } else {
            presenter?.fetchUniversityDetailFailure(error: Constants.StringConstant.universityDetailNotFound)
        }
    }
}
