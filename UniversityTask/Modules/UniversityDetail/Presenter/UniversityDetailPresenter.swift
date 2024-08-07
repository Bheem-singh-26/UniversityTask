//
//  UniversityDetailPresenter.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import UIKit

final class UniversityDetailPresenter: UniversityDetailPresenterProtocol {
    
    var university: University?
    
    weak var view: UniversityDetailViewProtocol?
    
    var interactor: UniversityDetailInputInteractorProtocol?
    
    var router: UniversityDetailRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchUniversityDetail()
    }
    
    func populateDataIn(nameLabel: UILabel, stateLabel: UILabel, countryLabel: UILabel, codeLabel: UILabel, webPageLabel: UILabel) {
        nameLabel.text = university?.name
        stateLabel.text = university?.stateProvince
        countryLabel.text = university?.country
        codeLabel.text = university?.alphaTwoCode
        webPageLabel.text = university?.webPages?.first ?? ""
    }
    
    func popToUniversityList(on navigationController: UINavigationController?) {
        router?.popToUniversityList(on: navigationController)
    }
    
}

extension UniversityDetailPresenter: UniversityDetailOutputInteractorProtocol {
    
    func fetchUniversityDetailSuccess(university: University) {
        self.university = university
        self.view?.onFetchUniversityDetailSuccess()
        print(university.name)
    }
    
    func fetchUniversityDetailFailure(error: String) {
        self.view?.onFetchUniversityDetailFailure(error: error)
    }
}
