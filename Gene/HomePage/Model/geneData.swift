//
//  geneData.swift
//  Gene
//
//  Created by manoj on 15/12/23.
struct geneData: Decodable {
    var data: [geneUserData]
 
}

struct geneUserData: Decodable {
    var thumpnail_url: String!
    var like_count : Int!
    var share_count: Int!
    var comments_count: Int!
    var ID: Int!
    var template_config_data : String!
    
}

struct TokenResponse : Decodable {
    
  var data : TokenData
}

struct TokenData : Decodable{
    
   var Token : String
}



