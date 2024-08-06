//
//  UniversityListCell.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import UIKit

final class UniversityListCell: UITableViewCell {

    static let identifier: String = "UniversityListCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setData(for university: University) {
        self.nameLabel.text = university.name
        self.stateLable.text = university.stateProvince
    }
    
}
