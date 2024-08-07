//
//  University.swift
//  UniversityTask
//
//  Created by Bheem Singh on 06/08/24.
//

import Foundation
import RealmSwift

class University: Object, Decodable {
    @objc dynamic var alphaTwoCode: String?
    var webPages = List<String>()
    @objc dynamic var country: String = ""
    var domains = List<String>()
    @objc dynamic var name: String = ""
    @objc dynamic var stateProvince: String?

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case country, domains, name
        case stateProvince = "state-province"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.alphaTwoCode = try container.decodeIfPresent(String.self, forKey: .alphaTwoCode)
        let webPagesArray = try container.decodeIfPresent([String].self, forKey: .webPages) ?? []
        self.webPages.append(objectsIn: webPagesArray)
        self.country = try container.decode(String.self, forKey: .country)
        let domainsArray = try container.decodeIfPresent([String].self, forKey: .domains) ?? []
        self.domains.append(objectsIn: domainsArray)
        self.name = try container.decode(String.self, forKey: .name)
        self.stateProvince = try container.decodeIfPresent(String.self, forKey: .stateProvince)
    }
}

