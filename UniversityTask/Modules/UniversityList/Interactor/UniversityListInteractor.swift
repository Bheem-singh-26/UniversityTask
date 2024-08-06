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
    
    func fetchUniversityList() {
        
    }
    
}
