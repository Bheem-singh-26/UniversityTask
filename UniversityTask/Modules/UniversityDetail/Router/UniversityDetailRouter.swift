//
//  UniversityDetailRouter.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import UIKit

final class UniversityDetailRouter: UniversityDetailRouterProtocol {
    
    static func createModule(with university: University) -> UniversityDetailViewController? {
        
        guard let view = Constants.Storyboard.main.instantiateViewController(withIdentifier: Constants.StoryboardsIds.universityDetail) as? UniversityDetailViewController else {
            return nil
        }
        
        let presenter: UniversityDetailPresenterProtocol & UniversityDetailOutputInteractorProtocol = UniversityDetailPresenter()
        let interactor: UniversityDetailInputInteractorProtocol = UniversityDetailInteractor()
        let router: UniversityDetailRouter = UniversityDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.interactor?.university = university
        interactor.presenter = presenter
        
        return view
        
    }
    
    func popToUniversityList(on navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
}

