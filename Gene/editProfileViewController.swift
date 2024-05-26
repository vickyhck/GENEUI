//
//  editProfileViewController.swift
//  Gene
//
//  Created by manoj on 14/02/24.
//

import UIKit

//@available(iOS 17.0, *)
class editProfileViewController: UIViewController , UINavigationControllerDelegate & UIImagePickerControllerDelegate {
    

    
    var imagePicker = UIImagePickerController()
    var imageView = UIImageView()

    var cropRect : CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
    var croppedImage : UIImage?
    var croplayer : CAShapeLayer?
    
    var profilePicURL: String?
    
    lazy var ProfileImageView : UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "Default image")?.resize(targetSize: CGSize(width: 100, height: 100))
        imageView.backgroundColor = .white

                imageView.translatesAutoresizingMaskIntoConstraints = false
     

                imageView.tintColor = .black
                return imageView
            
    }()
    
    lazy var profileSetButton : UIButton = {
   
                let ProfileSetButton = UIButton()
                ProfileSetButton.setImage(UIImage(systemName: "camera"), for: .normal)
        ProfileSetButton.tintColor = .black
                ProfileSetButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
                ProfileSetButton.translatesAutoresizingMaskIntoConstraints = false
               return ProfileSetButton
        
        
    }()
    
    
    lazy var NameLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        //textField.text = user.userName
        textField.textColor = .black
     
       
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.resignFirstResponder()
        return textField
    }()

    
    lazy var phnLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Phone no:"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var phnofld: UITextField = {
        
        let textField = UITextField()
        textField.text = "9500334222"
        
        textField.textColor = .black
        
         textField.borderStyle = .roundedRect
         textField.layer.borderColor = UIColor.white.cgColor
         textField.layer.borderWidth = 2.5
         textField.layer.cornerRadius = 10.0
         textField.backgroundColor = .white
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
         textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
         textField.resignFirstResponder()
         return textField

   
    }()
    
    
    lazy var EmailLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Email:"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
 

    
    lazy var mailfld : UITextField = {
        
        let textField = UITextField()
//        textField.text = "manoj@gmail.com"
 
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        textField.backgroundColor = .white
        textField.isUserInteractionEnabled = true
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.resignFirstResponder()
        return textField
    }()
    
    
   
    lazy var saveButton : UIButton = {
   
                let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
              saveButton.translatesAutoresizingMaskIntoConstraints = false
               return saveButton
        
        
    }()
    
    lazy var logoututton : UIButton = {
   
                let Button = UIButton()
       Button.setTitle("Logout", for: .normal)
       Button.setTitleColor(.black, for: .normal)
       Button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
           Button.translatesAutoresizingMaskIntoConstraints = false
               return Button
        
        
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        navigationItem.hidesBackButton = true
        
        let BackButton = UIButton(type: .custom)
        BackButton.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
      BackButton.addTarget(self, action: #selector(backProfile), for: .touchUpInside)

        
        let customBackButton = UIBarButtonItem(customView: BackButton)
        
        navigationItem.leftBarButtonItem = customBackButton
        
        
        view.addSubview(ProfileImageView)
        view.addSubview(profileSetButton)
        view.addSubview(NameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phnLabel)
        view.addSubview(phnofld)
        view.addSubview(EmailLabel)
        view.addSubview(mailfld)
        view.addSubview(saveButton)
        view.addSubview(logoututton)
        view.backgroundColor = GlobalColor().Background


        
        ProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileSetButton.translatesAutoresizingMaskIntoConstraints = false
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phnLabel.translatesAutoresizingMaskIntoConstraints = false
        phnofld.translatesAutoresizingMaskIntoConstraints = false
        EmailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailfld.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        logoututton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            ProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ProfileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            ProfileImageView.heightAnchor.constraint(equalToConstant: 100),
            ProfileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            profileSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileSetButton.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 5),
            
            NameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            NameLabel.topAnchor.constraint(equalTo: profileSetButton.bottomAnchor, constant: 50),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 20),
            
            phnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phnLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            
         
            phnofld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phnofld.topAnchor.constraint(equalTo: phnLabel.bottomAnchor, constant: 20),
            
            EmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            EmailLabel.topAnchor.constraint(equalTo: phnofld.bottomAnchor, constant: 30),
           
         
            mailfld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailfld.topAnchor.constraint(equalTo: EmailLabel.bottomAnchor, constant: 20),
            
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            logoututton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoututton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)

        
        ])
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        

        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        ProfileImageView.addGestureRecognizer(pinchGesture)
        ProfileImageView.isUserInteractionEnabled = true
        
        croplayer = CAShapeLayer()
        croplayer?.strokeColor = UIColor.white.cgColor
        croplayer?.lineWidth = 2.0
        croplayer?.fillColor = UIColor.clear.cgColor
        ProfileImageView.layer.addSublayer(croplayer!)
        updateCroprect()
        
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
                    
                    self.nameTextField.text = profile.username
                    self.mailfld.text = profile.email
                    
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
                                    self.ProfileImageView.image = image
                                }
                            } else {
                                print("Failed to create image")
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


    func updateCroprect() {
        
        let parh  = UIBezierPath(rect: cropRect)
        croplayer?.path = parh.cgPath
    }
  
     
    @objc func backProfile() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        
        guard let view = gesture.view else {return}
        
        if gesture.state == .changed {
            let pinchScale : CGFloat = gesture.scale
            view.transform = view.transform.scaledBy(x: pinchScale, y: pinchScale)
            gesture.scale = 1.0

        
                    let minimumSize: CGFloat = 50.0
                    if cropRect.width < minimumSize {
                        cropRect.size.width = minimumSize
                    }
                    if cropRect.height < minimumSize {
                        cropRect.size.height = minimumSize
                    }
                    if cropRect.maxX > view.frame.width {
                        cropRect.size.width = view.frame.width - cropRect.minX
                    }
                    if cropRect.maxY > view.frame.height {
                        cropRect.size.height = view.frame.height - cropRect.minY
                    }
                    
            

        }
    }
    
    
    func cropImage(image: UIImage, cropRect: CGRect) -> UIImage? {
            guard let cgImage = image.cgImage else { return nil }
            guard let croppedCGImage = cgImage.cropping(to: cropRect) else { return nil }
            return UIImage(cgImage: croppedCGImage)
        }

    
    @objc func profileImageTapped() {
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
        
            ProfileImageView.image = selectedImage

        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ProfileImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    @objc func saveButtonTapped() {
        guard let profilePic =  ProfileImageView.image else {
            print("Image was selected")
            return
        }
        

        guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else {
            
            print("Auth token not recived")
            return
        }
        guard let imageData = profilePic.jpegData(compressionQuality: 0.8)
                
          else {
            print("Failed to convert image to data")
            return
        }

        let url = URL(string: ApiUrl.host + ApiUrl.changeProfilePic)!
        let boundary = UUID().uuidString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
       request.setValue(authToken, forHTTPHeaderField: "Authorization")
     
        var data = Data()

        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"user_image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)

        let task = URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    if let responseData = responseData {
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            print("API Response: \(json)")
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                } else {
                    print("HTTP Response Status Code: \(httpResponse.statusCode)")
                }
            }
        }
        
        task.resume()
        
    }
   
    @objc func logOutButtonTapped() {
//        
        UserDefaults.standard.removeObject(forKey: "AuthToken")
//        let logiPage = UIStoryboard(name : "LoginView" , bundle: nil).instantiateInitialViewController()!
//        navigationController?.setViewControllers([logiPage], animated: true)
        if let appDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            
            appDelegate.login()
        }
    }

}


