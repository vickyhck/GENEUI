//
//  AppDelegate.swift
//  Gene
//
//  Created by manoj on 15/12/23.
//


import UIKit

//@available(iOS 13.0, *)
//@available(iOS 17.0, *)
@main

class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        if UserDefaults.standard.string(forKey: "AuthToken") != nil {
            navigateToAuthorizedPage()
        } else {
            navigateToLogin()
        }
        return true
    }

    func navigateToAuthorizedPage() {
        
//        let homePage = UINavigationController(rootViewController: homePageViewController())
        let storyBoard = UIStoryboard(name: "HomeView", bundle: nil)
        let homeView = storyBoard.instantiateInitialViewController()
      
//        let homePage = UINavigationController(rootViewController: homeView!)
        window?.rootViewController = homeView
        window?.makeKeyAndVisible()
    }
    
    func navigateToLogin() {
        

//        let login = UINavigationController(rootViewController: LoginViewController())
        let storyBoard = UIStoryboard(name: "LoginView", bundle: nil)
//        let login = stryBoard.instantiateInitialViewController()
        let login = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        window?.rootViewController = login
        window?.makeKeyAndVisible()
    }
    
        

    //MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

}
