//
//  Constants.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import UIKit

struct Constants {
    
    struct Storyboard {
        static let main = UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    struct StoryboardsIds {
        static let universityList = "UniversityListViewController"
        static let universityDetail = "UniversityDetailViewController"
    }
    
    struct StringConstant {
        static let universityList = "University List"
        static let universityDetail = "University Detail"
        
        static let universityDetailNotFound = "We are not having any details about this university."
        static let NetworkNotFound = "You're not conneted, check your internet connectivity and try again"
        static let ok = "Ok"
    }
    
    struct Image {
        static let refresh = UIImage(systemName: "arrow.clockwise")
    }
  
}
