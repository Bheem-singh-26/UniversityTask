//
//  UniversityListPresenter.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import UIKit

final class UniversityListPresenter: UniversityListPresenterProtocol {
    
    var universities = [University]()
    
    var view: UniversityListViewProtocol?
    
    var interactor: UniversityListInputInteractorProtocol?
    
    var router: UniversityListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchUniversityList()
    }
    
    func refresh() {
        interactor?.fetchUniversityList()
    }
    
    func numberOfRowInsection() -> Int {
        return self.universities.count
    }
    
    func tableViewCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversityListCell.identifier) as? UniversityListCell else {
            return UITableViewCell()
        }
        //cell.setData(for: universities[indexPath.row])
        
        return cell
    }
    
    func didSelectRowAt(index: IndexPath) {
        
    }
    
}

extension UniversityListPresenter: UniversityListOutputInteractorProtocol {
    
    func fetchUniversityListSucess(universities: [University]) {
        self.universities = universities
        view?.onFetchUniversityListSucess()
    }
    
    func fetchUniversityListFailure(error: String) {
        view?.onFetchUniversityListFailure(error: "Getting Error \(error)")
    }
    
}
