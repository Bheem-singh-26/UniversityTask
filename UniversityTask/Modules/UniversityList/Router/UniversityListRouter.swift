//
//  UniversityListRouter.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import UIKit

final class UniversityListRouter: UniversityListRouterProtocol {
    
    static func createModule() -> UniversityListViewController? {
        
        guard let view = Constants.Storyboard.main.instantiateViewController(withIdentifier: Constants.StoryboardsIds.universityList) as? UniversityListViewController else {
            return nil
        }
        
        let presenter: UniversityListPresenterProtocol & UniversityListOutputInteractorProtocol = UniversityListPresenter()
        let interactor: UniversityListInputInteractorProtocol = UniversityListInteractor(repository: UniversityListRepositoryImpl())
        let router:UniversityListRouter = UniversityListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func pushToUniversityDetail(on view: UniversityListViewProtocol?, with university: University) {
        
    }
}
