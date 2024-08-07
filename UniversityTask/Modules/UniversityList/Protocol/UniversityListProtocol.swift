//
//  UniversityListProtocol.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import UIKit

protocol UniversityListPresenterProtocol: AnyObject {
    // view -> presenter
    var view: UniversityListViewProtocol? {get set}
    var interactor: UniversityListInputInteractorProtocol? {get set}
    var router: UniversityListRouterProtocol? {get set}
    func viewDidLoad()
    func refresh()
    
    func numberOfRowInsection() -> Int
    func tableViewCellHeight() -> CGFloat
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, on navigationController: UINavigationController?)
    
}

protocol UniversityListViewProtocol: AnyObject {
    // presenter -> view
    func onFetchUniversityListSuccess()
    func onFetchUniversityListFailure(error: String)
    func showActivity()
    func hideActivity()
}

protocol UniversityListInputInteractorProtocol: AnyObject {
    // presenter -> interactor
    var presenter:UniversityListOutputInteractorProtocol? {get set}
    var universities: [University]? {get set}
    func fetchUniversityList(shouldRefresh: Bool)
}

protocol UniversityListOutputInteractorProtocol: AnyObject {
    // interactor -> presenter
    func fetchUniversityListSuccess(universities: [University])
    func fetchUniversityListFailure(error: String)
}

protocol UniversityListRouterProtocol: AnyObject {
    // presenter -> router
    static func createModule()-> UniversityListViewController?
    func pushToUniversityDetail(on navigationController: UINavigationController?, with university: University)
}
