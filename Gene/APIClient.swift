//
//  APIClient.swift
//  Gene
//
//  Created by manoj on 22/02/24.
//

import Foundation
import UIKit


enum HTTPMethod : String {
    
    case GET
    case POST
}


struct APIClient {
    
    static let shared = APIClient()
    
    private init () {}
    
    func UploadImage(image: UIImage, completion: @escaping(Data?, URLResponse?,Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            
            print("Failed to conert image to data")
            return
        }
        
        let url = URL(string: ApiUrl.host + ApiUrl.putApi)
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/from-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; fileName=\"user_image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type; image/jpeg\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
            
            completion(responseData, response, error)
            
        }
        task.resume()
        
    }
    
    
    func Log(apiUrl: String, parameters: [String:Any], completion: @escaping(Data?, URLResponse?, Error?) -> Void){
        
        let url = URL(string: apiUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        _ = Data()
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
           
            completion(data,response, error)
           
            
        }
        task.resume()
    }
    
    func  signup(apiUrl: String, /*imag: UIImage,*/parameters: [String:Any],completion: @escaping(Data?, URLResponse?, Error?) -> Void){
        guard let url = URL(string: apiUrl) else {
                print("Invalid URL")
                return
            }
        
//        guard let imageData = imag.jpegData(compressionQuality: 0.8) else {
//            print("Failed to convert image to data")
//            return
//        }
        let boundary = UUID().uuidString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var bodyData = Data()

        for (key, value) in parameters {
            bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            bodyData.append("\(value)\r\n".data(using: .utf8)!)
        }

       
//        bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        bodyData.append("Content-Disposition: form-data; name=\"file\"; filename=\"user_image.jpg\"\r\n".data(using: .utf8)!)
//        bodyData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//        bodyData.append(imageData)
//        bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
           
            completion(data,response, error)
           
            
        }
       
        task.resume()
    }
    

    
    
}
