//
//  UniversityDetailViewController.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import UIKit

class UniversityDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    @IBOutlet weak var webPageLabel: UILabel!
    
    var presenter: (UniversityDetailPresenterProtocol & UniversityDetailOutputInteractorProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        presenter?.viewDidLoad()
    }
    
    private func setUpUI(){
        self.title = Constants.StringConstant.universityDetail
        self.navigationItem.hidesBackButton = true
        setupRightBarButton()
    }
    
    private func setupRightBarButton() {
        let rightBarButton = UIButton(type: .custom)
        rightBarButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        rightBarButton.addTarget(self, action: #selector(refreshButtonAction(sender:)), for: .touchUpInside)
        rightBarButton.frame=CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func refreshButtonAction(sender: UIBarButtonItem) {
        presenter?.popToUniversityList(on: self.navigationController)
    }

}

extension UniversityDetailViewController: UniversityDetailViewProtocol {
    
    func onFetchUniversityDetailSuccess() {
        presenter?.populateDataIn(nameLabel: nameLabel, stateLabel: stateLabel, countryLabel: countryLabel, codeLabel: countryCodeLabel, webPageLabel: webPageLabel)
    }
    
    func onFetchUniversityDetailFailure(error: String) {
        print(error)
    }
    
}
