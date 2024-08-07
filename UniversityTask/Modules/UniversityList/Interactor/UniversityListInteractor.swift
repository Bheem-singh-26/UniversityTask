//
//  UniversityListInteractor.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation

final class UniversityListInteractor: UniversityListInputInteractorProtocol {
    
    weak var presenter: UniversityListOutputInteractorProtocol?
    
    var universities: [University]?
    
    private var respository: UniversityListRepository
    
    init(repository: UniversityListRepository) {
        self.respository = repository
    }
    
    func fetchUniversityList() {
        respository.fetchUniversityList { [weak self] result in
            switch result {
            case .success(let universities):
                self?.universities = universities
                self?.presenter?.fetchUniversityListSuccess(universities: universities)
            case .failure(let error):
                self?.presenter?.fetchUniversityListFailure(error: error.localizedDescription)
            }
        }
    }
    
}
