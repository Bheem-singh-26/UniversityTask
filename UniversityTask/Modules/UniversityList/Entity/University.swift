//
//  University.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation

struct University: Decodable {
    let alphaTwoCode: String?
    let webPages: [String]?
    let country: String
    let domains: [String]?
    let name: String
    let stateProvince: String?

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case country, domains, name
        case stateProvince = "state-province"
    }
}
