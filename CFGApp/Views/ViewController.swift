//
//  ViewController.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loginBtn: UIButton?
    @IBOutlet var secureBtn: UIButton?
    @IBOutlet var userNameTxtFld: UITextField?
    @IBOutlet var passwordTxtFld: UITextField?
    @IBOutlet var forgetPwdBtn: UIButton?
    var validation = Validation()
    var isSecure: Bool = false {
        didSet {
            if isSecure {
                secureBtn?.setImage(UIImage(named: "eye-on"), for: .normal)
            } else {
                secureBtn?.setImage(UIImage(named: "eye-off"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        addTapGestureToDismissKeyboard()
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setInitialUI() {
        loginBtn?.titleLabel?.font = UIFont(name: "Genos-Medium", size: 24)
        forgetPwdBtn?.titleLabel?.font = UIFont(name: "Genos-Medium", size: 24)
        userNameTxtFld?.font = UIFont(name: "Genos-Regular", size: 16)
        passwordTxtFld?.font = UIFont(name: "Genos-Regular", size: 16)
        userNameTxtFld?.setLeftPaddingPoints(8.0)
        userNameTxtFld?.setRightPaddingPoints(8.0)
        passwordTxtFld?.setLeftPaddingPoints(8.0)
        passwordTxtFld?.setRightPaddingPoints(8.0)
        loginBtn?.layer.masksToBounds = false
        loginBtn?.layer.cornerRadius = 8
        //        userNameTxtFld?.text = "shivam@app.com"
        //        passwordTxtFld?.text = "Test@1234"
        //
        //        userNameTxtFld?.text = "cf.MO.Mega@cfg.sg"
        //        passwordTxtFld?.text = "test@152"
        //
        //        userNameTxtFld?.text = "cf.manager@cfg.sg"
        //        passwordTxtFld?.text = "test@171"
        
                userNameTxtFld?.text = "cf.AM.baco@cfg.sg"
                passwordTxtFld?.text = "test@170"
        
        //        userNameTxtFld?.text = "cf.MO.baco@cfg.sg"
        //        passwordTxtFld?.text = "test@166"
        
        //        userNameTxtFld?.text = "cf.OV.baco@cfg.sg"
        //        passwordTxtFld?.text = "test@157"
        
        //        userNameTxtFld?.text = "cf.OV.Mega@cfg.sg"
        //        passwordTxtFld?.text = "test@223"
        //
        //        userNameTxtFld?.text = "cf.manager.baco@cfg.sg"
        //        passwordTxtFld?.text = "test@187"
        
        //        userNameTxtFld?.text = "cf.Finance.Mega@cfg.sg"
        //        passwordTxtFld?.text = "test@191"
        //
        //        userNameTxtFld?.text = "cf.Doctor.baco@cfg.sg"
        //        passwordTxtFld?.text = "test@136"
        
        //        userNameTxtFld?.text = "cf.AM.Mega@cfg.sg"
        //        passwordTxtFld?.text = "test@147"
        
        //        userNameTxtFld?.text = "cf.Doctor.Mega@cfg.sg"
        //        passwordTxtFld?.text = "test@183"
        
        
//        Production Credential
        
//        userNameTxtFld?.text = "cf.AM.VlifeMKG@cfg.sg"
//        passwordTxtFld?.text = "test@1231"
        
//        userNameTxtFld?.text = "cf.Doctor.VlifeMKG@cfg.sg"
//        passwordTxtFld?.text = "test@221"
                
      //  userNameTxtFld?.text = "cf.manager.VlifeMKG@cfg.sg"
//        passwordTxtFld?.text = "test@164"
        
    }
    
    func validateFields() -> Bool {
        guard let email = userNameTxtFld?.text, !email.isEmpty else {
            self.view.makeToast("Please enter your email.")
            return false
        }
        
        if !validation.isValidEmail(email) {
            self.view.makeToast("Please enter a valid email.")
            return false
        }
        
        guard let password = passwordTxtFld?.text, !password.isEmpty else {
            self.view.makeToast("Please enter your password.")
            return false
        }
        return true
    }
    
    @IBAction func secureAction() {
        isSecure = !isSecure
        if isSecure {
            passwordTxtFld?.isSecureTextEntry = false
        } else {
            passwordTxtFld?.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginAction() {
        if validateFields() {
            loginAPI()
        }
        //        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //        if let checkInScreen = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
        //            navigationController?.pushViewController(checkInScreen, animated: true)
        //        }
        //        let storyboard = UIStoryboard(name: "Closed", bundle: nil)
        //        if let checkInScreen = storyboard.instantiateViewController(withIdentifier: "ClosedCasesListVC") as? ClosedCasesListVC {
        //            navigationController?.pushViewController(checkInScreen, animated: true)
        //        }
    }
    
    func loginAPI() {
        self.view.endEditing(true)
        let authOperation = AuthOperation()
        let userData = [
            "grant_type": grant_type,
            "client_id": client_id,
            "client_secret": client_secret,
            "username": "integrationUser@Cfg.com",
            "password": IntegrationPassword
        ] as [String : Any]
        authOperation.executLogin(userDetail: userData) { error, response, status in
                print(response)
            if status == .success {
                let dict = response ?? [:]
                Defaults.accessToken = dict["access_token"] as? String
                Defaults.instanceUrl = dict["instance_url"] as? String
                Defaults.userName = self.userNameTxtFld?.text
                Defaults.signature = dict["signature"] as? String
                Defaults.tokenType = dict["token_type"] as? String
                if isProduction {
                    let tokens = self.validation.extractTokensForProduction(from: dict["id"] as? String ?? EMPTY)
                    print(tokens.uID ?? "")
                    print(tokens.orgToken ?? "")
                    Defaults.userId = tokens.uID
                    Defaults.organizationToken = tokens.orgToken
                } else {
                    let tokens = self.validation.extractTokens(from: dict["id"] as? String ?? EMPTY)
                    Defaults.userId = tokens.uID
                    Defaults.organizationToken = tokens.orgToken
                }
                self.authenticationApprovalApi()
            } else if status == .badRequest {
                let dict = response ?? [:]
                let errorDescription = dict["error_description"] as? String
                self.view.makeToast(errorDescription ?? ERROR_OCCURRED)
            } else {
                self.view.makeToast(error ?? SOMETHING_WENT_WRONG_STR)
                return
            }
        }
    }
    
    func authenticationApprovalApi() {
        self.view.endEditing(true)
        let authOperation = AuthOperation()
        let userParam = [
            "Username": userNameTxtFld?.text ?? EMPTY,
            "Password": passwordTxtFld?.text ?? EMPTY,
            "DeviceToken": DeviceToken,
        ] as [String : Any]
        authOperation.executeCFGMAppLogin(param: userParam) { error, response, status in
            let dict = response ?? [:]
            let responseDict = dict["ResponseMessage"] as? [String: Any]
            let checkDict = responseDict?.isEmpty
            if (checkDict == nil) {
                let usersData = dict["User"] as? [String: Any]
                Defaults.Access_Level__c = usersData?["Access_Level__c"] as? String
                Defaults.Id = usersData?["Id"] as? String
                Defaults.isUserLoggedIn = true
                Defaults.userRole = usersData?["Roles__c"] as? String
                Utility.gotoHomeView()
            } else if !(checkDict ?? true) {
                let messageDict = response?["ResponseMessage"] as? [String: Any]
                let errorDescription = messageDict?["error_description"] as? String
                self.view.makeToast(errorDescription ?? ERROR_OCCURRED)
            } else {
                self.view.makeToast(error ?? SOMETHING_WENT_WRONG_STR)
                return
            }
        }
    }
}

