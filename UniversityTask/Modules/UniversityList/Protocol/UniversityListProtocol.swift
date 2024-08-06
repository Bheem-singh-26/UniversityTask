//
//  UniversityListProtocol.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import UIKit

protocol UniversityListPresenterProtocol: AnyObject {
    // University ->
    var view: UniversityListViewProtocol? {get set}
    var interactor: UniversityListInputInteractorProtocol? {get set}
    var router: UniversityListRouterProtocol? {get set}
    func viewDidLoad()
    func refresh()
    
    //func showMovieController(navigationController:UINavigationController)
    func numberOfRowInsection() -> Int
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(index: IndexPath)
    func tableViewCellHeight() -> CGFloat
}

protocol UniversityListViewProtocol: AnyObject {
    func onFetchUniversityListSucess()
    func onFetchUniversityListFailure(error: String)
    func showActivity()
    func hideActivity()
}

protocol UniversityListInputInteractorProtocol: AnyObject {
    var presenter:UniversityListOutputInteractorProtocol? {get set}
    var universities: [University]? {get set}
    func fetchUniversityList()
}

protocol UniversityListOutputInteractorProtocol: AnyObject {
    func fetchUniversityListSucess(universities: [University])
    func fetchUniversityListFailure(error: String)
}

protocol UniversityListRouterProtocol: AnyObject {
    static func createModule()-> UniversityListViewController?
    func pushToUniversityDetail(on view: UniversityListViewProtocol?, with university: University)
}
