//
//  geneUser.swift
//  Gene
//
//  Created by manoj on 11/03/24.
//

struct geneUser: Codable {
    let data: [PostData]
}

struct PostData: Codable {
    let thumpnailUrl : String
    
    enum CodingKeys: String, CodingKey {
        case thumpnailUrl = "thumpnail_url"
    }
}

