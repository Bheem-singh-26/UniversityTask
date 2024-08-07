//
//  UniversityDetailProtocol.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation
import UIKit

protocol UniversityDetailPresenterProtocol: AnyObject {
    // University ->
    var view: UniversityDetailViewProtocol? {get set}
    var interactor: UniversityDetailInputInteractorProtocol? {get set}
    var router: UniversityDetailRouterProtocol? {get set}
    func viewDidLoad()
    
    func populateDataIn(nameLabel: UILabel, stateLabel: UILabel, countryLabel: UILabel, codeLabel: UILabel, webPageLabel: UILabel)
    func popToUniversityList(on navigationController: UINavigationController?)
}

protocol UniversityDetailViewProtocol: AnyObject {
    func onFetchUniversityDetailSuccess()
    func onFetchUniversityDetailFailure(error: String)
}

protocol UniversityDetailInputInteractorProtocol: AnyObject {
    var university: University? {get set}
    var presenter:UniversityDetailOutputInteractorProtocol? {get set}
    func fetchUniversityDetail()
}

protocol UniversityDetailOutputInteractorProtocol: AnyObject {
    func fetchUniversityDetailSuccess(university: University)
    func fetchUniversityDetailFailure(error: String)
}

protocol UniversityDetailRouterProtocol: AnyObject {
    static func createModule(with university: University)-> UniversityDetailViewController?
    func popToUniversityList(on navigationController: UINavigationController?)
}
