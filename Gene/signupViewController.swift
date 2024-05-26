//
//  signupViewController.swift
//  Gene
//
//  Created by manoj on 09/01/24.
//

import UIKit


//@available(iOS 17.0, *)

class signupViewController: UIViewController, UINavigationControllerDelegate & UIImagePickerControllerDelegate {
    
    
    
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var confirmTextField: UITextField!
    
    @IBOutlet var mobNumberTextField: UITextField!
    
    
    @IBOutlet var maleButton: UIButton!
    
    
    @IBOutlet var femaleButton: UIButton!
    
    
////
//         var scrollView : UIScrollView = {
//
//        let scrollView = UIScrollView()
//         scrollView.showsHorizontalScrollIndicator = false
//         scrollView.showsVerticalScrollIndicator = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//    
//
//   
//    lazy var ProfileImageView : UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .white
//        imageView.layer.cornerRadius = 50
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = GlobalColor().Background.cgColor
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "Default profile")?.resize(targetSize: CGSize(width: 100, height: 100))
//        
//        imageView.tintColor = .black
//        return imageView
//        
//    }()
//    
//    
//    lazy var profileSetButton : UIButton = {
//   
//        let ProfileSetButton = UIButton()
//        ProfileSetButton.setTitle("Set Profile Picture", for: .normal)
//        ProfileSetButton.setTitleColor(GlobalColor().Button, for: .normal)
//        ProfileSetButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
//        ProfileSetButton.translatesAutoresizingMaskIntoConstraints = false
//        return ProfileSetButton
//        
//        
//    }()
//    
////    button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
//
//    let userNameLabel : UILabel = {
//        let label = UILabel()
//        label.text = "N A M E :"
//        label.font = .systemFont(ofSize: 15)
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textColor = GlobalColor().label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//  
//    let userNameTextField : UITextField = {
//        
//        let textField = UITextField(frame: .zero)
//        
//        textField.placeholder = "Username"
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        textField.keyboardType = .emailAddress
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return textField
//    }()
//    let emailLabel : UILabel = {
//        
//        let label = UILabel()
//        label.text = "E M A I L :"
//        label.font = .systemFont(ofSize: 15)
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textColor = GlobalColor().label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    let emailTextField : UITextField = {
//        
//        let textField = UITextField()
//        textField.placeholder = "Enetr your email"
//        textField.keyboardType = .emailAddress
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        return textField
//    }()
//    
//    let passwordLabel : UILabel = {
//        
//        let label = UILabel()
//        label.text = "P A S S W O R D:"
//        label.font = .systemFont(ofSize: 15)
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textColor = GlobalColor().label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    let passwordTextField : UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return textField
//    }()
//    
//    let confirmpasswordTextField : UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Confirm Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//      
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return textField
//    }()
//    
//    let phnnoLabel : UILabel = {
//        
//        let label = UILabel()
//        label.text = "P H O N E  N O:"
//        label.font = .systemFont(ofSize: 15)
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textColor = GlobalColor().label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    let phnNoTextField : UITextField = {
//        
//        let textField = UITextField(frame: .zero)
//        textField.keyboardAppearance  = .default
//        textField.keyboardType = .numberPad
//        textField.placeholder = "+91"
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        return textField
//    }()
//  
//    let signupButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Signup", for: .normal)
//        button.backgroundColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 15
//        button.layer.masksToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(signupButtonPressed(_:)), for: .touchUpInside)
//        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        return button
//    }()
//    
//    let facebooksignupButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "fb")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
//    
//        
//        button.setTitle("Sign up with facebook", for: .normal)
//        button.setTitleColor(GlobalColor().Button,for: .normal)
//        button.backgroundColor = .black
//       button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1.0
//       // button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        var buttonConfig = UIButton.Configuration.plain()
//        buttonConfig.titlePadding = 150
//        button.configuration = buttonConfig
//        return button
//    }()
//
//    let googlesignupButton: UIButton = {
//        
//        let button = UIButton(type: .custom)
//        
//        button.setImage(UIImage(named: "google-logo")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
//        button.setTitle("Sign up with google",  for: .normal)
//        button.setTitleColor(GlobalColor().Button, for: .normal)
//        button.backgroundColor = .black
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1.0
//      //  button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 60)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        var buttonConfig = UIButton.Configuration.plain()
//        buttonConfig.titlePadding = 150
//        button.configuration = buttonConfig
//        return button
//    }()
//    
//    
//    let backToLogin : UIButton = {
//        
//        let button = UIButton(type: .system)
//        button.setTitle("Already have account", for: .normal)
//        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(backtoLogin), for: .touchUpInside)
//        return button
//    }()
//
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let customButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customButton
        
        
        maleButton.setImage(UIImage.init(named: "off"), for: .normal)
        maleButton.setImage(UIImage.init(named: "on"), for: .selected)
        
        
        femaleButton.setImage(UIImage.init(named: "off"), for: .normal)
        femaleButton.setImage(UIImage.init(named: "on"), for: .selected)
        
        
        let tab:UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(dismisKeyboard))
        self.view.addGestureRecognizer(tab)
        
//        navigationItem.title = "G E N E"
//        view.backgroundColor = .black
//        
//        view.addSubview(scrollView)
//
//        scrollView.addSubview(ProfileImageView)
//        scrollView.addSubview(profileSetButton)
//              scrollView.addSubview(userNameLabel)
//              scrollView.addSubview(userNameTextField)
//              scrollView.addSubview(emailLabel)
//              scrollView.addSubview(emailTextField)
//              scrollView.addSubview(passwordLabel)
//              scrollView.addSubview(passwordTextField)
//              scrollView.addSubview(confirmpasswordTextField)
//              scrollView.addSubview(phnnoLabel)
//              scrollView.addSubview(phnNoTextField)
//              scrollView.addSubview(signupButton)
//          
//             scrollView.addSubview(facebooksignupButton)
//             scrollView.addSubview(googlesignupButton)
//        
//             scrollView.addSubview(backToLogin)
//
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
     

        NSLayoutConstraint.activate([
       
            
//                     scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//                      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//                     ProfileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
//                     ProfileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                     ProfileImageView.widthAnchor.constraint(equalToConstant: 100),
//                     ProfileImageView.heightAnchor.constraint(equalToConstant: 100),
//                     
//                     profileSetButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                     profileSetButton.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 5),
//                   
//                     userNameLabel.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 80),
//                     userNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     userNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Username Text Field Constraints
//                     userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
//                     userNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     userNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Email Label Constraints
//                     emailLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
//                     emailLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     emailLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Email Text Field Constraints
//                     emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
//                     emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Password Label Constraints
//                     passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
//                     passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     passwordLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Password Text Field Constraints
//                     passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
//                     passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Confirm Password Text Field Constraints
//                     confirmpasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
//                     confirmpasswordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     confirmpasswordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Phone Number Label Constraints
//                     phnnoLabel.topAnchor.constraint(equalTo: confirmpasswordTextField.bottomAnchor, constant: 20),
//                     phnnoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     phnnoLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Phone Number Text Field Constraints
//                     phnNoTextField.topAnchor.constraint(equalTo: phnnoLabel.bottomAnchor, constant: 10),
//                     phnNoTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                     phnNoTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                     // Signup Button Constraints
//                     signupButton.topAnchor.constraint(equalTo: phnNoTextField.bottomAnchor, constant: 60),
//                     signupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                     
//                     facebooksignupButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
//                     facebooksignupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                     
//                     googlesignupButton.topAnchor.constraint(equalTo: facebooksignupButton.bottomAnchor, constant: 20),
//                     googlesignupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//
//                     backToLogin.topAnchor.constraint(equalTo: googlesignupButton.bottomAnchor, constant: 20),
//                     backToLogin.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                     backToLogin.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -18)


                    


        ])
    

  
    }
    
    @objc func backAction() {
        
        navigationController?.popViewController(animated: true)
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
        
            
//            ProfileImageView.image = selectedImage
            
         
         
        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            ProfileImageView.image = selectedImage
            
          
        
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }



    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)

    }
    
    func isValidPhnno(_ phoneNumber: String) -> Bool {
        
        let phnregex = "[0-9]{10}"
        let phonepredicate = NSPredicate(format: "SELF MATCHES %@", phnregex)
        return phonepredicate.evaluate(with: phoneNumber)
    }
    
    
    @IBAction func signupButtonPressed(_ sender: Any) {
  
        guard let username = nameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password =  passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmTextField.text, !confirmPassword.isEmpty,
              let phoneNumber = mobNumberTextField.text, !phoneNumber.isEmpty
//              let profileImage = ProfileImageView.image // Assuming ProfileImageView is your UIImageView
        else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }

        guard password == confirmPassword else {
            showAlert(title: "Error", message: "Passwords do not match.")
            return
        }
        
        guard isValidEmail(email) else {
            
            showAlert(title: "Error", message: "Invalid Email")
            return
        }
        
        guard isValidPhnno(phoneNumber) else {
            
            showAlert(title: "Error", message: "Invalid PhoneNumber")
            return
        }

//        guard let imageData = profileImage.jpegData(compressionQuality: 0.8) else {
//            showAlert(title: "Error", message: "Failed to convert image to data.")
//            return
//        }


        let parameters: [String: Any] = [
            "username": username,
            "passwd": password,
            "confirm_passwd": confirmPassword,
            "phnno": phoneNumber,
            "email": email
        ]
        
        let url = URL(string: ApiUrl.host + ApiUrl.signup)
        
        APIClient.shared.signup(apiUrl: ApiUrl.host + ApiUrl.signup, /*imag: profileImage,*/ parameters: parameters){ data, response, error in
            if let error = error {
                print("Post Request error: \(error.localizedDescription)")
                return
            }
                        guard let httpResponse  = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                            if let httpResponse = response as? HTTPURLResponse {
                                print("Invalid response from the server. Status code: \(httpResponse.statusCode)")
                                if let data = data, let errorResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    if let errorMessage = errorResponse["message"] as? String {
                                        print("Error message from server: \(errorMessage)")
                                    }
                                }
                            }
                            return
                        }
                        if let data = data , let tokenJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                           let token =  tokenJson["Token"] as? String {
                            print("Token received: \(token)")
                            UserDefaults.standard.setValue(token, forKey: "AuthToken")
            
                            var authReq = URLRequest(url: url!)
                            authReq.httpMethod = "GET"
                            authReq.setValue(token, forHTTPHeaderField: "Authorization")
            
                            DispatchQueue.main.async {
//                                let storyBoard = UIStoryboard(name: "HomeView", bundle: nil)
//                                let homeView = storyBoard.instantiateInitialViewController()
//                                self.navigationController?.pushViewController(homeView!, animated: true)
                                
                                
                                if let appDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                                    
                                    appDelegate.homePage()
                                }
                            }
                        } else {
                            print("Unable to parse the token")
                        }
            
                    }
                }
                                
                                
            
        

    @objc func backtoLogin() {
        
        navigationController?.popViewController(animated: true)
    }


    @IBAction func selectGender(_ sender: UIButton) {
        
        
        if sender == maleButton {
            
            maleButton.isSelected = true
           femaleButton.isSelected = false
            
        } else {
            
            maleButton.isSelected = false
            femaleButton.isSelected = true
        }
        
    }
    
    @objc func dismisKeyboard() {
        self.view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    }

