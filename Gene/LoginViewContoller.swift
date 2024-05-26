
 

import UIKit

//@available(iOS 17.0, *)
class LoginViewController : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var glab: UIView!
    
    @IBOutlet var flab: UIView!
    
    
    @IBOutlet var moblab: UIView!
    
    
    
    var authToken : String?
    
//    var scrollView : UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//        
//    }()
//    
//    let headTitle : UILabel = {
//        let label = UILabel()
//        label.text = "G e n e"
//        label.textAlignment = .center
//        label.textColor = GlobalColor().label
////        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//     
//        
//    }()
//    
//    let usernameLabel: UILabel = {
//        let label = UILabel()
////        label.text = "U S E R  N A M E :"
//        label.text =  "E  M A I L:"
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 15)
//        label.textColor = GlobalColor().label
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let usernameTextField: UITextField = {
//        let textField = UITextField()
////        textField.placeholder = "Enter your username or Email"
//        textField.placeholder = "Enter Your Email"
//        //textField.textColor = .white
//        textField.borderStyle = .roundedRect
//        textField.keyboardAppearance = .light
//        textField.keyboardType = .emailAddress
//        textField.returnKeyType = .default
//        textField.autocorrectionType = .no
//      
//        textField.clearButtonMode = .whileEditing
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true // Adjust width as needed
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true // Adjust height as needed
//        
//        textField.resignFirstResponder()
//        return textField
//    
//    }()
//
//    let passwordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "P A S S W O R D :"
//        label.textColor = GlobalColor().label
//        label.textAlignment = .center
//        
//        label.font = .systemFont(ofSize: 15)
//        label.font = .preferredFont(forTextStyle: .headline)
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Enter your password"
//        //textField.textColor = .white
//     
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 2.5
//        textField.layer.cornerRadius = 10.0
//        textField.backgroundColor = .systemGray5
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        textField.resignFirstResponder()
//        return textField
//    }()
//
//    let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.backgroundColor = GlobalColor().Button
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 15
//        button.layer.masksToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        return button
//    }()
//
//    
//    let facebookLoginButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "fb")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
//    
//        
//        button.setTitle("Sign in with facebook", for: .normal)
//        button.setTitleColor(GlobalColor().Button, for: .normal)
//        button.backgroundColor = .black
//        button.layer.cornerRadius = 5
//    button.layer.borderWidth = 1.0
//      
//        button.layer.borderColor = UIColor.white.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        var buttonConfig = UIButton.Configuration.plain()
//        buttonConfig.titlePadding = 100
//        button.configuration = buttonConfig
//        return button
//    }()
//
//    let googleLoginButton: UIButton = {
//        
//        let button = UIButton(type: .custom)
//                
//                button.setImage(UIImage(named: "google-logo")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
//                button.setTitle("Sign in with google",  for: .normal)
//                button.setTitleColor(GlobalColor().Button, for: .normal)
//                button.backgroundColor = .black
//                button.layer.cornerRadius = 5
//                button.layer.borderWidth = 1.0
//                button.layer.borderColor = UIColor.white.cgColor
//                button.translatesAutoresizingMaskIntoConstraints = false
//        
//        var buttonConfig = UIButton.Configuration.plain()
//        buttonConfig.titlePadding = 150
//        button.configuration = buttonConfig
//                return button
//    }()
//    
//    let signupButton : UIButton = {
//        
//        let button = UIButton(type: .system)
//        button.setTitle("New User? Create Account.", for: .normal)
//        button.setTitleColor(GlobalColor().Button, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
////        button.addTarget(self, action: #selector(signupButtonpressed), for: .touchUpInside)
//        return button
//    }()
////    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab:UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(dismisKeyboard))
        self.view.addGestureRecognizer(tab)

//        navigationController?.navigationBar.isHidden = true
//        
//        usernameTextField.delegate = self
//        passwordTextField.delegate = self
      
//        glab.layer.masksToBounds = false
        glab.layer.cornerRadius = 5
        glab.layer.shadowOpacity = 0.4
        glab.layer.shadowOffset = .zero
        
//        flab.layer.masksToBounds = false
        flab.layer.cornerRadius = 5
        flab.layer.shadowOpacity = 0.4
        flab.layer.shadowOffset = .zero
//        glab.layer.shadowRadius = 1

//        
       
        moblab.layer.cornerRadius = 10
        moblab.layer.borderWidth = 1
        moblab.layer.borderColor = UIColor.init(red: 0.1, green: 0.3, blue: 0.6, alpha: 1).cgColor
 
//        view.addSubview(scrollView)
//        scrollView.addSubview(headTitle)
//        scrollView.addSubview(usernameLabel)
//        scrollView.addSubview(usernameTextField)
//        scrollView.addSubview(passwordLabel)
//        scrollView.addSubview(passwordTextField)
//        scrollView.addSubview(loginButton)
//        scrollView.addSubview(signupButton)
//        scrollView.addSubview(facebookLoginButton)
//        scrollView.addSubview(googleLoginButton)
//
//       
//        NSLayoutConstraint.activate([
//            
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            headTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//            headTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            
//            usernameLabel.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 20),
//            usernameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            
//            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
//            usernameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            usernameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//         
//
//            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
//            passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//
//            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
//            passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
//            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            
//            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
//            signupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            
//            facebookLoginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
//            facebookLoginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            
//            googleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 20),
//            googleLoginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            googleLoginButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
//        ])
//        
        
   
        

        
    }
    
    
    @objc func dismisKeyboard() {
        self.view.endEditing(true)
    }

//    
//    @IBAction func loginButton(_ sender: Any) {
//        
//        guard let username = usernameTextField.text, !username.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else {
//            showAlert(message: "Please enter username and password")
//            return
//        }
//        
//        let parameters: [String: Any] = [
//            "email": username,
//            "passwd": password
//        ]
//        
//        APIClient.shared.Log(apiUrl: ApiUrl.host + ApiUrl.login, parameters: parameters) { data, response, error in
//            if let error = error {
//                print("Post Request error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response received from the server")
//                return
//            }
//            
//            if (200...299).contains(httpResponse.statusCode), let data = data {
//                print(data)
//                print(String(data: data, encoding: .utf8) ?? "No Data")
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let dataDictionary = json["data"] as? [String: Any],
//                       let token = dataDictionary["Token"] as? String {
//                           print("Token Received: \(token)")
//                           UserDefaults.standard.setValue(token, forKey: "AuthToken")
//                           DispatchQueue.main.async {
//                              
//                               let storyBoard = UIStoryboard(name: "HomeView", bundle: nil)
//                               let homeView = storyBoard.instantiateInitialViewController() as! UINavigationController
////                               self.navigationController?.pushViewController(homeView, animated: true)
//                               if let rootViewController = homeView.viewControllers.first as? HomePage {
//                                       self.navigationController?.pushViewController(rootViewController, animated: true)
//                                   }
//                               
//                             
//                           }
//                    } else {
//                        print("Invalid data received from the server")
//                    }
//
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                }
//            } else {
//                print("Nil data received from the server or HTTP error")
//            }
//        }
//    }
    
//    
//    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        print("Button tabbed")
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter username and password")
            return
        }
        
        let parameters: [String: Any] = [
            "email": username,
            "passwd": password
        ]
        
        APIClient.shared.Log(apiUrl: ApiUrl.host + ApiUrl.login, parameters: parameters) { data, response, error in
            if let error = error {
                print("Post Request error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received from the server")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode), let data = data {
                print(data)
                print(String(data: data, encoding: .utf8) ?? "No Data")
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let dataDictionary = json["data"] as? [String: Any],
                       let token = dataDictionary["Token"] as? String {
                           print("Token Received: \(token)")
                           UserDefaults.standard.setValue(token, forKey: "AuthToken")
                           DispatchQueue.main.async {
                              
//                               let stroyBoard : UIStoryboard = UIStoryboard(name: "HomeView", bundle: nil)
//                               
//                               let nextVCiewController = stroyBoard.instantiateViewController(withIdentifier: "HomePageView") /*as! HomePage*/
//                               nextVCiewController.modalPresentationStyle = .fullScreen
//                               self.present(nextVCiewController, animated: true)
                               
                               if let appDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                                   
                                   appDelegate.homePage()
                               }
                               

                           }
                    } else {
                        print("Invalid data received from the server")
                    }

                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            } else {
                print("Nil data received from the server or HTTP error")
            }
        }
    }


    
    
    
//    
//    @objc func loginButtonTapped(_ sender: UIButton) {
//        guard let username = usernameTextField.text, !username.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else {
//            showAlert(message: "Please enter username and password")
//            return
//        }
//        
//        let parameters: [String: Any] = [
//            "email": username,
//            "passwd": password
//        ]
//        
//        APIClient.shared.Log(apiUrl: ApiUrl.host + ApiUrl.login, parameters: parameters) { data, response, error in
//            if let error = error {
//                print("Post Request error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response received from the server")
//                return
//            }
//            
//            if (200...299).contains(httpResponse.statusCode), let data = data {
//                print(data)
//                print(String(data: data, encoding: .utf8) ?? "No Data")
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let dataDictionary = json["data"] as? [String: Any],
//                       let token = dataDictionary["Token"] as? String {
//                           print("Token Received: \(token)")
//                           UserDefaults.standard.setValue(token, forKey: "AuthToken")
//                           DispatchQueue.main.async {
//                              
//                               let storyBoard = UIStoryboard(name: "HomeView", bundle: nil)
//                               let homeView = storyBoard.instantiateInitialViewController() as! UINavigationController
//                               self.navigationController?.pushViewController(homeView, animated: true)
////                               if let rootViewController = homeView.viewControllers.first as? HomePage {
////                                       self.navigationController?.pushViewController(rootViewController, animated: true)
////                                   }
//                               
//                             
//                           }
//                    } else {
//                        print("Invalid data received from the server")
//                    }
//
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                }
//            } else {
//                print("Nil data received from the server or HTTP error")
//            }
//        }
//    }

//
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        
        
        let storyBoard = UIStoryboard(name: "SignupView", bundle: nil)
        let signupView = storyBoard.instantiateViewController(withIdentifier: "signupViewPage") /*as! signupViewController*/
        navigationController?.pushViewController(signupView, animated: true)
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    

}
