//
//  SceneDelegate.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if Defaults.isUserLoggedIn ?? false {
            gotoHomeView()
        } else {
            gotoLoginView()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        if animated {
            let options: UIView.AnimationOptions = .transitionFlipFromRight
            UIView.transition(with: window, duration: 0.5, options: options, animations: nil, completion: nil)
        }
    }
    
    func gotoHomeView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: homeVC ?? HomeVC())
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    
    
    func gotoLoginView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: viewController)
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    static func getSceneDelegate() -> SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

