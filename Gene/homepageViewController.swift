//
//  homepageViewController.swift
//  Gene
//
//  Created by manoj on 14/03/24.
//


import UIKit
//import AVFoundation
//
//@available(iOS 17.0, *)
class homePageViewController: UIViewController, UIScrollViewDelegate {
    
   // var authToken: String!
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var cameraButton : UIButton!
    var latestTimeStamp : TimeInterval = 0
    var refreshControl : UIRefreshControl!
    
    var templateData : geneData!
    
    
    let openVC = cameraViewController()
    
    var lastContentOffset : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .white
        print(UserDefaults.standard.string(forKey: "AuthToken")!)
        
        
        let titleAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: GlobalColor().label,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
       navigationItem.hidesBackButton = true
//        navigationItem.title = "G e n e"
//        navigationController?.navigationBar.frame.size.height = 22
        
        self.navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.navigationItem.title = "G e n e"
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
        
//        let customNavBar = UIView(frame: CGRect(x: 0, y: 0, width: Int(view.frame.width), height: Int(44)))
//        customNavBar.backgroundColor = .black
//        view.addSubview(customNavBar)
//
//        customNavBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//
//            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            customNavBar.heightAnchor.constraint(equalToConstant: 54)
//
//        ])
//
//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(customNavBar.frame.width), height: Int(customNavBar.frame.height)))
//        titleLabel.text = "G e n e"
//        titleLabel.textColor = .systemMint
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        titleLabel.textAlignment = .center
//        customNavBar.addSubview(titleLabel)
//
                
        let profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = .black
//        profileButton.addTarget(self, action: #selector(profileButtonPressed(_:)), for: .touchUpInside)
        profileButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let profileBarBUtoon = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarBUtoon
        
        
        // scrollView.delegate = self
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView?.refreshControl = refreshControl
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 130
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        
        
        
        
        
        
        
        let cameraImage = UIImage(systemName: "plus.app.fill")?.withTintColor(GlobalColor().Button, renderingMode: .alwaysOriginal)
       cameraButton = UIButton()
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(cameraImage, for: .normal)
        cameraButton.transform = CGAffineTransform(scaleX: 2, y: 2)
        cameraButton.addTarget(self, action: #selector(openCamera(_:)), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            cameraButton.widthAnchor.constraint(equalToConstant: 40),
            cameraButton.heightAnchor.constraint(equalTo: cameraButton.widthAnchor),
            
            
        ])
        
        
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 35),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
        ])
        
        fetchData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        let offsetY = scrollView.contentOffset.y

        
        if offsetY > lastContentOffset && offsetY > 0 {
            hideCameraButton()
        } else {
            showCameraButton()
        }
        lastContentOffset = offsetY
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
    
    @available(iOS 17.0, *)
    @objc func profileButtonPressed(_ sender: UIButton) {
        // Create and present the profile details view controller
        let profileDetailsVC = profileViewController() // Replace with the\        navigationController?.pushViewController(profileDetailsVC, animated: true)

    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        
        fetchData()
        
    }
    
    
    
    
    
    @objc func openCamera(_ sender: UIButton) {
        
        _ = openVC
        DispatchQueue.main.async {
            
            self.openVC.updateExposure2(0.5)
            self.navigationController?.pushViewController(self.openVC, animated: true)
        }
    }
    @objc func useButtonPressed(_ sender: UIButton){
        print("tag index", sender.tag)
        var select_templateData : geneUserData!
        for Template in templateData.data {
            if Template.ID == sender.tag {
                select_templateData = Template
            }
            
            
            
        }
        
 
        if let jsonString =  select_templateData.template_config_data {
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    
                    if let dict = jsonObject as? [String:Any] {
                        
                        let exposureValue = dict["exposureValue"] as? Float ?? 0.0
                        print(exposureValue)
                        
                        let zoomLevel = dict["zoomLevel"] as? Double ?? 0.0
                        print(zoomLevel)
                        
                        let flashMode = dict["flasMode"] as? Bool
                        print(flashMode as Any)
                        
                        let focusLevel = dict["focusLevel"] as? Float ?? 0.0
                        print(focusLevel)
                        
                        let timer = dict["Timer"] as? Double ?? 0.0
                        print(timer)
                        
                        let AspectRatio = dict["aspectRatio"]
                        print(AspectRatio as Any)
                        
                        let cameralens = dict["cameralens"] as? String
                        print(cameralens as Any)
                        
                        let cameraangle = dict["cameraangle"] as? Double ?? 0.0
                        print(cameraangle)
                        
                        let cameraposition = dict["cameraposition"] as? String
                        print(cameraposition as Any)
                        
                        
                        //  openVC.switchCamera(to: backCamera)
                        openVC.updateZoomFactor(CGFloat(zoomLevel))
                        openVC.updateExposure2(Double(Float(exposureValue)))
                        // openVC.updateFocus(at:( Float(focusLevel)))
                        //openVC.changeAspectRatio(preset: .AspectRatio as! AVCaptureSession.Preset)
                        openVC.isFlashOn = flashMode ?? false
                        openVC.timerDuration = timer
                        openVC.setAspectRatio(AspectRatio as! String)
                        openVC.setCameralens(cameralens!)
                        openVC.setupMotionManager(finalAngle: cameraangle)
                        openVC.switchcamera(to: cameraposition!)
                        
                        
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            } else {
                print("Failed to convert string to data")
            }
        }   else {
            print("Optional is nil")
        }
        
        
        
        //   openVC.updateZoomFactor(CGFloat((dict["zoomLevel"] as? Float ?? 0)))
        
        navigationController?.pushViewController(openVC, animated: true)
        
    }
    
    
    
    
    func fetchData() {
    
        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            
            print("Auth token not recived")
            return
        }
        

        
        let apiUrl = ApiUrl.host +  ApiUrl.getApi

        
        guard let url = URL(string: apiUrl) else {
            print("Invalid Url")
            return
        }
   
      
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.setValue(authToken,  forHTTPHeaderField: "Authorization")
        
        let task =    URLSession.shared.dataTask(with: request) {[weak self ] data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
        
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "Data Could not be printed as UTF-8")
                do {
                    let decoder = JSONDecoder()
                    let geneData = try decoder.decode(geneData.self, from: data)
                    self!.templateData = geneData
                    
               //     print(geneData)
                    
                    DispatchQueue.main.async {
                        self!.processFetchedData(geneData)
                        self!.refreshControl.endRefreshing()
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    func processFetchedData(_ geneData: geneData) {
        
        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            
            print("Auth token not recived")
            return
        }
        
        for userData in geneData.data {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
           
            if let imageUrl = URL(string: ApiUrl.host + ApiUrl.mediaType + userData.thumpnail_url ){
                
                var requset = URLRequest(url: imageUrl)

                requset.addValue(authToken, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: requset) { [weak self, imageView, userData] imageData, _, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error fetching image: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let imageData = imageData else {
                        print("No Image Data")
                        return
                    }
                    
                    print("Recived image data:\(imageData)")
                    
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async { //[self]  in
                            imageView.image = image
                            
                            self.stackView.addArrangedSubview(imageView)
                            
                            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width / image.size.height).isActive = true
                            
                            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                            
                            
                            let profileImage = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let profileButton = UIButton()
                            //                            profileButton.setTitle(userData.Id, for: .normal)
                            profileButton.setTitleColor(.black, for: .normal)
                            profileButton.setImage(profileImage, for: .normal)
                            profileButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                            profileButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(profileButton)
                            
                            
                            let likeImage = UIImage(systemName: "suit.heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
                            let likeButton = UIButton()
                            likeButton.setImage(likeImage, for: .normal)
                            likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            likeButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(likeButton)
                            
                            
                            let commandImage = UIImage(systemName: "message")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let commentButton = UIButton()
                            commentButton.setImage(commandImage, for: .normal)
                            commentButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            commentButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(commentButton)
                            
                            let usersCountLabel = UILabel()
                            usersCountLabel.text = "\(userData.share_count ?? 0)"
                            usersCountLabel.textColor = .black
                            usersCountLabel.textAlignment = .center
                            usersCountLabel.font = UIFont.systemFont(ofSize: 14)
                            usersCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(usersCountLabel)
                            
                            
                            
                            
                            let likesCountLabel = UILabel()
                            likesCountLabel.text = "\(userData.like_count ?? 0)"
                            likesCountLabel.textColor = .black
                            likesCountLabel.textAlignment = .center
                            likesCountLabel.font = UIFont.systemFont(ofSize: 14)
                            likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(likesCountLabel)
                            
                            let userImage = UIImage(systemName: "chevron.up.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let useButton = UIButton(type: .system)
                            useButton.setImage(userImage, for: .normal)
                            useButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            useButton.translatesAutoresizingMaskIntoConstraints = false
                            useButton.tag = (userData.ID ?? 0)
                            useButton.addTarget(self, action: #selector(self.useButtonPressed), for: .touchUpInside)
                            self.view.addSubview(useButton)
                            
                            let commentsCountLabel = UILabel()
                            commentsCountLabel.text = "\(userData.comments_count ?? 0)"
                            commentsCountLabel.textColor = .black
                            commentsCountLabel.font = UIFont.systemFont(ofSize: 14)
                            commentsCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(commentsCountLabel)
                            
                            
                            NSLayoutConstraint.activate([
                                
                                profileButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
                                profileButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -23),
                                
                                
                                likeButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
                                likeButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
                                
                                
                                commentButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
                                commentButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
                                
                                useButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                                useButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
                                
                                
                                
                                usersCountLabel.centerXAnchor.constraint(equalTo: useButton.centerXAnchor),
                                usersCountLabel.bottomAnchor.constraint(equalTo: useButton.bottomAnchor, constant: 23),
                                
                                
                                
                                
                                likesCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: -15),
                                // likesCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
                                likesCountLabel.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 23),
                                
                                commentsCountLabel.trailingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: -10),
                                commentsCountLabel.bottomAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 23),
                            ])
                            
                            
                        }
                    } else {
                        print("Failed to create UIImage from data")
                    }
                }.resume()
                
                
                
                
                
            } else {
                
                print("Invalid image url :\(String(describing: userData.thumpnail_url))")
            }
        }
    }
    
}
  
class CustomNavigatioBar: UINavigationBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 33
        return newSize
    }
}

