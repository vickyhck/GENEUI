//
//  HomeViewModel.swift
//  Gene
//
//  Created by manoj on 14/03/24.
//

import UIKit

class HomeViewModel {
    
    var imageUrl: [String] = []
    var images: [UIImage?] = []
    var likes : String!
    var comments : String!
    var buttonID : Int!
    var select_templateData : geneData!
    var exposureValue : Float!
    var zoomLevel : Double!
    var flashMode : Bool!
    var  focusLevel : Float!
    var timer : Double!
    var   AspectRatio : String!
    var   cameralens : String!
    var   cameraangle : Double!
    var   cameraposition : String!
    var templateData : [String] = []
    
    //    func fetchData(completion: @escaping ()->Void ) {
    //        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
    //            print("Auth token not received")
    //            return
    //        }
    //
    //        let apiUrl = ApiUrl.host + ApiUrl.getApi
    //        guard let url = URL(string: apiUrl) else {
    //            print("Invalid Url")
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.setValue(authToken, forHTTPHeaderField: "Authorization")
    //
    //        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
    //            guard let self = self else { return }
    //            if let error = error {
    //                print("Error: \(error.localizedDescription)")
    //                return
    //            }
    //            if let data = data {
    //                do {
    //                    let decoder = JSONDecoder()
    //                    let geneData = try decoder.decode(geneData.self, from: data)
    //                    print(geneData)
    //
    //
    //                    self.imageUrl = geneData.data.map { ApiUrl.host + ApiUrl.mediaType + $0.thumpnail_url }
    //                    self.likes = geneData.data.map { $0.like_count} as? String
    //                    self.comments = geneData.data.map { $0.comments_count } as? String
    //                    self.buttonID = geneData.data.map { $0.ID} as? Int
    //                    self.images = Array(repeating: nil, count: geneData.data.count)
    //
    //                    completion()
    //
    //
    //                } catch {
    //                    print("Error decoding JSON: \(error.localizedDescription)")
    //                }
    //            }
    //        }.resume()
    //    }
    //
    //}
    
    func fetchData(completion: @escaping () -> Void) {
        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Auth token not received")
            return
        }
        
        let apiUrl = ApiUrl.host + ApiUrl.getApi
        guard let url = URL(string: apiUrl) else {
            print("Invalid Url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let geneData = try decoder.decode(geneData.self, from: data)
                    print(geneData)
                    
                    self.imageUrl = geneData.data.map { ApiUrl.host + ApiUrl.mediaType + $0.thumpnail_url }
                    self.likes = geneData.data.map { $0.like_count } as? String
                    self.comments = geneData.data.map { $0.comments_count} as? String
                    self.buttonID = geneData.data.map { $0.ID } as? Int
                    self.images = Array(repeating: nil, count: geneData.data.count)
                    templateData = geneData.data.map { $0.template_config_data}
                    print("template\(templateData)")
                    completion()

                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
  
}

