//
//  UniversityListViewController.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import UIKit

final class UniversityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: (UniversityListPresenterProtocol & UniversityListOutputInteractorProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        // Asking presenter to perform viewDidLoad:
        presenter?.viewDidLoad()
    }
    
    private func setUpUI() {
        tableView.register(UINib(nibName: UniversityListCell.identifier, bundle: nil), forCellReuseIdentifier: UniversityListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
    }

}

extension UniversityListViewController: UniversityListViewProtocol {
    
    func onFetchUniversityListSucess() {
        tableView?.reloadData()
    }
    
    func onFetchUniversityListFailure(error: String) {
        print(error)
    }
    
    func showActivity() {
        // show activity:
    }
    
    func hideActivity() {
        // hide activity:
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
        presenter?.didSelectRowAt(index: indexPath)
    }
    
}
