//
//  UniversityListViewController.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import UIKit

final class UniversityListViewController: UIViewController, ActivityIndicatorPresenter {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: (UniversityListPresenterProtocol & UniversityListOutputInteractorProtocol)?
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        // Asking presenter to perform viewDidLoad:
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.refresh()
    }
    
    private func setUpUI() {
        self.title = Constants.StringConstant.universityList
        tableView.register(UINib(nibName: UniversityListCell.identifier, bundle: nil), forCellReuseIdentifier: UniversityListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
    }

}

extension UniversityListViewController: UniversityListViewProtocol {
    
    func onFetchUniversityListSuccess() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func onFetchUniversityListFailure(error: String) {
        print(error)
    }
    
    func showActivity() {
        showActivityIndicator()
    }
    
    func hideActivity() {
        hideActivityIndicator()
    }
    
}
                                            

extension UniversityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowInsection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.tableViewCellHeight() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.setCell(tableView: tableView, forRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath, on: self.navigationController)
    }
    
}
