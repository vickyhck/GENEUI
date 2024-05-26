//
//  geneProfile.swift
//  Gene
//
//  Created by manoj on 05/03/24.
//

struct GeneProfileResponse: Codable {
    let data: GeneProfile
}

struct GeneProfile: Codable {
    let userId: String
    let username: String
    let email: String
    let profilePic: String
    let followingCount: Int
    let followerCount: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case username, email, profilePic = "profile_pic", followingCount = "following_count", followerCount = "follower_count"
    }
}
