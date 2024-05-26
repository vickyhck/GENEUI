//
//  profileDetails.swift
//  Gene
//
//  Created by manoj on 28/12/23.
//

import UIKit
import SDWebImage
//@available(iOS 17.0, *)
class profileViewController: UIViewController, UINavigationControllerDelegate & UIImagePickerControllerDelegate {
    
    
   
//    var userName = UILabel()
//    var followersCount = UILabel()
//    var followingCount = UILabel()
    var refreshControll = UIRefreshControl()
    var images = [UIImage]()
    var imageURLs: [String] = []
    
    @IBOutlet var userName: UILabel!
    

    @IBOutlet var coverImageView: UIImageView!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var activityIndicate: UIActivityIndicatorView!
    
    @IBOutlet var followersCount: UILabel!
    
    @IBOutlet var followingCount: UILabel!
    
    @IBOutlet var postCount: UILabel!
    
    @IBOutlet var followLayer: UIView!
    
    @IBOutlet var followButton: UIButton!
    
    
    var isFollow : Bool = false
    
    
//        lazy var ProfileImageView : UIImageView = {
//              let imageView = UIImageView()
//                  imageView.contentMode = .scaleAspectFit
//                  imageView.clipsToBounds = true
//                  imageView.layer.cornerRadius = 50
//          imageView.layer.borderWidth = 2
//          imageView.layer.borderColor = UIColor.black.cgColor
//          
//
//               //   imageView.backgroundColor = .init(white: 5, alpha: 5)
//                  imageView.translatesAutoresizingMaskIntoConstraints = false
////          imageView.image = UIImage(named: "image9")?.resize(targetSize: CGSize(width: 100, height: 100))
//
//                  imageView.tintColor = .black
//                  return imageView
//              
//      }()
//      
//    
//    
//    lazy var settingButton : UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "gearshape")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//        
//    }()
//    
//
//    lazy var followingLabel : UILabel = {
//        
//        let label = UILabel()
//        label.text = "Following"
//        label.font = .boldSystemFont(ofSize: 18)
//        label.textColor = .black
//        
//        return label
//    }()
//
//    lazy var followersLabel : UILabel =  {
//        
//        let label = UILabel()
//        label.text = "Followers"
//        label.font = .boldSystemFont(ofSize: 18)
//        label.textColor = .black
//        return label
//    }()
// 
//    lazy var postLabel : UILabel =  {
//        
//        let label = UILabel()
//        label.text = "Posts"
//        label.textColor = .black
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
//    
//    lazy var postCount : UILabel = {
//        
//        let label = UILabel()
//        label.textColor = .black
//        label.font = .boldSystemFont(ofSize:  15)
//        return label
//        
//    }()
//    
//    lazy var collectionView : UICollectionView = {
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 2
//        layout.minimumInteritemSpacing = 2
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 2, height: UIScreen.main.bounds.width / 3 - 2)
//        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
//        return collectionView
//    }()
//    
//    
//   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicate.startAnimating()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 2, height: UIScreen.main.bounds.width / 3 - 2)
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")

            
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        
        navigationItem.hidesBackButton = true
        
        refreshControll.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        //       collectoinView.addSubview(refreshControll)
        profileImageView.layer.cornerRadius = 67
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        followLayer.layer.cornerRadius = 20
        followLayer.layer.borderWidth = 1
        followLayer.layer.borderColor = UIColor.systemBlue.cgColor
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = customBackButton
        
        
        
        
        
        view.backgroundColor = GlobalColor().Background
        
        
        
//        
//        view.addSubview(userName)
//        view.addSubview(followingLabel)
//        view.addSubview(followingCount)
//        view.addSubview(followersLabel)
//        view.addSubview(followersCount)
//        view.addSubview(collectionView)
//        view.addSubview(postLabel)
//        view.addSubview(postCount)
//        //        view.addSubview(ProfileImageView)
//        //        view.addSubview(closeButton)
//        // view.addSubview(editProfile)
//        view.addSubview(settingButton)
//        
//        
//        
//        
//        userName.translatesAutoresizingMaskIntoConstraints = false
//        followingLabel.translatesAutoresizingMaskIntoConstraints = false
//        followingCount.translatesAutoresizingMaskIntoConstraints = false
//        followersLabel.translatesAutoresizingMaskIntoConstraints = false
//        followersCount.translatesAutoresizingMaskIntoConstraints = false
//        postLabel.translatesAutoresizingMaskIntoConstraints = false
//        postCount.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        settingButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            
//            
//            
//            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            
//            //            ProfileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            //           //            ProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            //                                   ProfileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            //                       ProfileImageView.widthAnchor.constraint(equalToConstant: 100),
//            //                       ProfileImageView.heightAnchor.constraint(equalToConstant: 100),
//            
//            
//            userName.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
//            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            
//            
//            followingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
//            followingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            followingCount.topAnchor.constraint(equalTo: followingLabel.bottomAnchor),
//            followingCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            
//            
//            followersLabel.topAnchor.constraint(equalTo: followingLabel.topAnchor),
//            followersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
//            
//            followersCount.topAnchor.constraint(equalTo: followersLabel.bottomAnchor),
//            followersCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            
//            postLabel.topAnchor.constraint(equalTo: followersLabel.topAnchor),
//            postLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            postCount.topAnchor.constraint(equalTo: postLabel.bottomAnchor),
//            postCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            //            collectionView.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 150),
//            //            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            //            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            //            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            
//            
//        ])
        
        fetchProfileDetails()
        fetchImage()
        
        activityIndicate.stopAnimating()
        
    }
    
    
    @objc func refreshData() {
        
        fetchProfileDetails()
        
    }
  
    func fetchProfileDetails() {
        guard let url = URL(string: ApiUrl.host + ApiUrl.getProfile) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Auth token not received")
            return
        }
        
        request.setValue(authToken,  forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let profileResponse = try decoder.decode(GeneProfileResponse.self, from: data)
                let profile = profileResponse.data
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                                  userName.text = profile.username
                                  userName.textColor = .black
                                  userName.font = .boldSystemFont(ofSize: 20)
                                  
                                  followingCount.text = "\(profile.followingCount)"
                                  followingCount.textColor = .black
                                  followingCount.font = .boldSystemFont(ofSize: 20)
                                  
                                  followersCount.text = "\(profile.followerCount)"
                                  followersCount.textColor = .black
                                  followersCount.font = .boldSystemFont(ofSize: 20)
                    
                    if let imageUrl = URL(string: ApiUrl.host + ApiUrl.mediaType + profile.profilePic) {
                        var request = URLRequest(url: imageUrl)
                        request.addValue(authToken, forHTTPHeaderField: "Authorization")
                        
                        URLSession.shared.dataTask(with: request) { [weak self] imageData, _, error in
                            guard let self = self else { return }
                            
                            if let error = error {
                                print("Error fetching image: \(error.localizedDescription)")
                                return
                            }
                            
                            guard let imageData = imageData else {
                                print("No Image Data")
                                return
                            }
                            
                            print("Received image data: \(imageData)")
                            
                            if let image = UIImage(data: imageData) {
                                DispatchQueue.main.async {
                                    self.profileImageView.image = image
                                }
                            } else {
                                //print("Failed to create image")
                                self.profileImageView.image = UIImage(named: "Default profile")?.resize(targetSize: CGSize(width: 100, height: 100))
                                    profileImageView.backgroundColor = .white
                            }
                        }.resume()
                    } else {
                        print("Invalid URL for image")
                    }
                }
            } catch {
                print("Error decoding profile data: \(error.localizedDescription)")
            }
        }.resume()
    }
   
   
    // Inside fetchImage() method
    func fetchImage() {
        guard let url = URL(string: ApiUrl.host + ApiUrl.getUserTemplate) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Auth token not received")
            return
        }
        
        request.setValue(authToken,  forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(geneData.self, from: data)
                
                // Extract image URLs from the response
                imageURLs =  response.data.map { ApiUrl.host + ApiUrl.mediaType + $0.thumpnail_url }
                
                print(imageURLs)
                // Download images asynchronously and convert them to UIImage
                
                guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
                    print("Auth token not received")
                    return
                }
                
//                var images = [UIImage]()
                let group = DispatchGroup()
//
//                for imageURL in imageURLs {
//                    group.enter()
//                    var request = URLRequest(url: imageURL)
//                    request.addValue(authToken, forHTTPHeaderField: "Authorization")
//                    
//                    URLSession.shared.dataTask(with: request) { imageData, response, error in
//                        defer { group.leave() }
//                        
//                        if let error = error {
//                            print("Error fetching image: \(error.localizedDescription)")
//                            return
//                        }
//                        guard let imageData = imageData else {
//                            print("No Image Data")
//                            return
//                        }
//                        
//                        if let image = UIImage(data: imageData) {
//                            images.append(image)
//                        }
//                    }.resume()
//                }
//               
                
                group.notify(queue: .main) {
                    // All images are downloaded, update UI
//                    self.images = images
                    self.collectionView.reloadData()
//                    self.collectoinView.reloadData()
                    self.postCount.text = "\(self.imageURLs.count)"
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

   
    @objc func backAction() {
        
        navigationController?.popViewController(animated: true)
    }
    @objc func closeButtonPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func coverImageCamera(_ sender: Any) {
        
        presentImagePicker()
    }
    
    
    
    
    func presentImagePicker() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    
        present(imagePicker, animated: true, completion: nil)


    }

   

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
        
            coverImageView.image = selectedImage

        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
         coverImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func followButtonTapped(_ sender: Any) {
        
        isFollow = !isFollow
        
        let title =  isFollow ? "Unfollow" : "Follow"
        
        followButton.setTitle(title, for: .normal)
        
    }
    
    
    

    @IBAction func ediitButtonTapped(_ sender: Any) {
        
        print("tapped")
        let goto = editProfileViewController()
navigationController?.pushViewController(goto, animated: true)
        
    }
    
    
    
//    @objc func settingButtonTapped() {
//                let goto = editProfileViewController()
//        navigationController?.pushViewController(goto, animated: true)
//        
//
//        
//    }
}

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageURLs.count
            
           // return 5
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
//            let imageURL = imageURLs[indexPath.item]
            
            let imageURL = URL(string: imageURLs[indexPath.item])
            cell.imageView.sd_setImage(with: imageURL)
         
    
            return cell
        }
    }
    
    class PostCell: UICollectionViewCell {
        
        
        static let reuseIdentifier = "PostCell"
        @IBOutlet var imageView: UIImageView!
        
        

//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    }
    
  
