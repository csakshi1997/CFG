//
//  SideBarViewController.swift
//  CFGApp
//
//  Created by Sakshi on 06/01/25.
//

import UIKit

class SideBarViewController: UIViewController {
    @IBOutlet var userNameLbl: UILabel?
    var completionHandler : (String) -> Void = {_ in }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLbl?.text = Defaults.userName
    }
    
    func checkInternetConnection(storyBoardName : UIViewController) {
        if InternetConnectionManager.isConnectedToNetwork(){
            navigationController?.pushViewController(storyBoardName, animated: true)
        }else{
            self.completionHandler("fd")
            self.dismiss(animated: true)
        }
    }
    
    func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: 20, y: 40, width: 100, height: 50))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeAction() {
        dismissViewController()
    }
    
    @IBAction func settingAction() {
        
    }
    
    @IBAction func logoutAction() {
        
    }
    
    @IBAction func languageAction() {
        
    }
}
