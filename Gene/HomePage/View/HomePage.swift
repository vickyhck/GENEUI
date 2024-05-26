//
//  HomePage.swift
//  Gene
//
//  Created by manoj on 02/02/24.
//

import UIKit
import SDWebImage
class HomePage: UIViewController, UITableViewDataSource {
    let openVC = cameraViewController()

//    var imageUrl: [String] = []
//    var images: [UIImage?] = []
//    var likes : String!
//    var comments : String!
    
    
    var templateData : geneData!
   var likeButtonTapped = false
    var viewModel = HomeViewModel()
    var lastContentOffSet : CGFloat = 0
    var refreshControll = UIRefreshControl()

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var activityIndicate: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    activityIndicate.startAnimating()

        
        tableView!.dataSource = self
        tableView.delegate = self
        
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicate.stopAnimating()
                
                
            }
        }
        
        cameraButton.transform = CGAffineTransform(scaleX: 2, y: 2)
        navigationItem.hidesBackButton = true
        
        refreshControll.addTarget(self, action: #selector(refreshaTable), for: .valueChanged)
        tableView.refreshControl = refreshControll
      
//      fetchData()
        
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
                 print("Auth token not received")
            SDWebImageDownloader.shared.setValue(authToken, forHTTPHeaderField: "Authorization")
             }
//             activityIndicate.stopAnimating()
//             activityIndicate.isHidden = true
        
        
    }
    
  
//    func startLoding() {
//        
//        activityIndicate.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//     
//    }
//
//    func stopLoading() {
//        
//        activityIndicate.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
//    }
    
    @objc func refreshaTable() {
        viewModel.fetchData { [self] in
            tableView.reloadData()
            refreshControll.endRefreshing()
        }
    }
  
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        if likeButtonTapped {
            sender.tintColor = .red
        } else {
            
            sender.tintColor = .black
        }
        likeButtonTapped = !likeButtonTapped
    }
    
    
    @IBAction func useButtonTapped(_ sender: UIButton) {
        

        print("templates\(viewModel.templateData)") 
        print()
        let index  = sender.tag
        print("index\(index)")
       if index < viewModel.templateData.count {
            
            
            let imageData = viewModel.templateData[index]
            
            if let jsonData = imageData.data(using: .utf8) {
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    if let jsonDict = jsonObject as? [String:Any] {
                        
                                                        let exposureValue = jsonDict["exposureValue"] as? Float ?? 0.0
                                                        print(exposureValue)
                        
                                                        let zoomLevel = jsonDict["zoomLevel"] as? Double ?? 0.0
                                                        print(zoomLevel)
                        
                                                        let flashMode = jsonDict["flasMode"] as? Bool
                                                        print(flashMode )
                        
                                                        let focusLevel = jsonDict["focusLevel"] as? Float ?? 0.0
                                                        print(focusLevel)
                        
                                                        let timer = jsonDict["Timer"] as? Double ?? 0.0
                                                        print(timer)
                        
                                                        let AspectRatio = jsonDict["aspectRatio"]
                                                        print(AspectRatio )
                        
                                                       let cameralens = jsonDict["cameralens"] as? String
                                                        print(cameralens )
                        
                                                        let cameraangle = jsonDict["cameraangle"] as? Double ?? 0.0
                                                        print(cameraangle)
                        
                                                        let cameraposition = jsonDict["cameraposition"] as? String
                                                        print(cameraposition )
                        
                        
                        openVC.updateZoomFactor(zoomLevel)
                        openVC.updateExposure2(Double(exposureValue))
                        openVC.isFlashOn = flashMode!
                        openVC.timerDuration = timer
                        openVC.setAspectRatio(AspectRatio as! String)
                        openVC.setCameralens(cameralens!)
                        openVC.setupMotionManager(finalAngle: cameraangle)
                        openVC.switchcamera(to: cameraposition!)
                        
                        print(jsonObject)
                    }
                } catch {
                    print("Error parsing JSON :\(error)")
                }
            }
        }
    
        navigationController?.pushViewController(openVC, animated: true)
    }
    
//    func applyFilters() {
//        
//        openVC.updateZoomFactor(CGFloat(viewModel.zoomLevel))
//        print(viewModel.zoomLevel!)
//        openVC.updateExposure2(Double(Float(viewModel.exposureValue)))
//        print(viewModel.exposureValue!)
//        openVC.isFlashOn = viewModel.flashMode ?? false
//        print(viewModel.flashMode!)
//        openVC.timerDuration = viewModel.timer
//        print(viewModel.timer!)
//        openVC.setAspectRatio(viewModel.AspectRatio )
//        print(viewModel.AspectRatio!)
//        openVC.setCameralens(viewModel.cameralens!)
//        print(viewModel.cameralens!)
//        openVC.setupMotionManager(finalAngle: viewModel.cameraangle)
//        print(viewModel.cameraangle!)
//        openVC.switchcamera(to: viewModel.cameraposition!)
//        print(viewModel.cameraposition!)
//    }
//    
    
    @IBAction func profileTapped(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileView = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController")
        navigationController?.pushViewController(profileView, animated: true)
        
    }
    
    
    @IBAction func openCameraView(_ sender: UIButton) {
        let cameraView = cameraViewController()
        cameraView.updateExposure2(0.5)
//        cameraView.setAspectRatio(default)
        navigationController?.pushViewController(cameraView, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY =  scrollView.contentOffset.y
        
        if offsetY > lastContentOffSet && offsetY > 0 {
            hideCameraButton()
           
        } else  {
            showCameraButton()
        }
        lastContentOffSet = offsetY
    }
    
    func hideCameraButton() {
        
        UIView.animate(withDuration: .infinity) { [self] in
            cameraButton.isHidden = true
            
        }
    }
    
    func showCameraButton() {
        UIView.animate(withDuration: 0.3) { [self] in
            
            cameraButton.isHidden = false
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return images.count
        return viewModel.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomImageCell.reuseIdentifier, for: indexPath) as? CustomImageCell else {
            fatalError("Failed to dequeue CustomImageCell")
        }
        
        cell.configure(with: viewModel.imageUrl[indexPath.row] , likeCounts: viewModel.likes ?? "0", commentCounts: viewModel.comments ?? " 0", index: indexPath.row)
//        cell.delegate = self
        return cell
    }
    
    
    
    
}

extension HomePage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//extension HomePage: CustomImageCellDelegate {
//    func reloadCellAt(_ index: Int) {
//        DispatchQueue.main.async { [self] in
//            tableView.reloadData()
//        }
//      
//    }
//}
