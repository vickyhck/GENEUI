//
//  authGlobal.swift
//  Gene
//
//  Created by manoj on 10/02/24.
//

import Foundation

struct ApiUrl {
 
    
//    static var authString = String()
    
    static var host : String = "http://10.10.101.89:8000"

    
//    static var host : String = "http://127.0.0.1:8000"
    
    static var getApi : String = "/api/gettemplate"
    

    
    static var putApi : String = "/api/puttemplate"
    
    static var login : String = "/api/login"
    
    static var signup : String = "/api/signup"
    
    static var getProfile : String = "/api/get_profile_detail"
    
    static var changeProfilePic : String = "/api/change_profile_pic"
    
    static var getUserTemplate : String = "/api/get_user_templete"
    
    static var mediaType : String = "/local_data/"
}
