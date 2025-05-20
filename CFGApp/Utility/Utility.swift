//
//  Utility.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import AssetsLibrary
import AVFoundation
import UIKit

class Utility {
//    static var tabbarView: TabbarView?
    static var isMenuOpen : Bool = false
    static var isFromHome : Bool = false
    static var fromOtherScreen : Bool = false
    static var button = UIButton()
    static var containerController : UIViewController?
    static var presentController : UIViewController?
    
    func getActualValue(key : String, dict : [String : Any]) -> String {
        if dict[key] is String {
            return dict[key] as! String
        } else if dict[key] is Int {
            return String(dict[key] as! Int)
        } else if dict[key] is Float {
            return String(format: "%.2f", dict[key] as! Float)
        } else if dict[key] is Double {
            return String(format: "%.2f", dict[key] as! Double)
        } else if dict[key] is Bool {
            return String(dict[key] as! Bool)
        } else {
            return EMPTY
        }
    }
    
    static func getConvertedPoint(_ targetView: UIView, baseView: UIView?) -> CGPoint {
        var pnt = targetView.frame.origin
        if nil == targetView.superview {
            return pnt
        }
        var superView = targetView.superview
        while superView != baseView {
            pnt = superView!.convert(pnt, to: superView!.superview)
            if nil == superView!.superview {
                break
            } else {
                superView = superView!.superview
            }
        }
        return superView!.convert(pnt, to: baseView)
    }
    
    static func gotoHomeView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: homeView ?? HomeVC())
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    static func gotoLoginView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: viewController)
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    static func gotoRefundVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Refunds", bundle:nil)
        let refundVC = storyBoard.instantiateViewController(withIdentifier: "RefundVC") as? RefundVC
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: refundVC ?? RefundVC())
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    static func gotoPendingCaseVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "PendingCases", bundle:nil)
        let pendingCasesVC = storyBoard.instantiateViewController(withIdentifier: "PendingCasesVC") as? PendingCasesVC
        SceneDelegate.getSceneDelegate().navigationController = UINavigationController(rootViewController: pendingCasesVC ?? PendingCasesVC())
        SceneDelegate.getSceneDelegate().navigationController?.isNavigationBarHidden = true
        SceneDelegate.getSceneDelegate().window!.rootViewController = SceneDelegate.getSceneDelegate().navigationController
    }
    
    static func tokenExpiredAction() {
        SceneDelegate.getSceneDelegate().window?.makeToast(SESSION_EXPIRED)
        self.logoutAction()
    }
    
    static func logoutAction(isRedirectedToLogin: Bool = true) {
        Defaults.isUserLoggedIn = false
        Defaults.userMobileNumber = EMPTY
        Defaults.accessToken = EMPTY
        Defaults.userId = EMPTY
        Defaults.userName = EMPTY
        Defaults.userEmail = EMPTY
        Defaults.removeUserImage()
        Defaults.userId = EMPTY
        if isRedirectedToLogin {
            self.gotoLoginView()
        }
    }
    
    static func getAllPatient(outerClosure: @escaping ((Bool) -> ())) -> () {
        let patientOperation = PatientOperation()
        patientOperation.getPatientNamesList {error, response, status in
            if status == .success {
                GlobalData.allPatientData.removeAll()
                let dict = response ?? [:]
                let patientDictArray = dict["records"] as? [[String : Any]] ?? []
                for patientDict in patientDictArray {
                    GlobalData.allPatientData.append(PatientModel(dict: patientDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getAllDoctor(clinicID: String, outerClosure: @escaping ((Bool) -> ())) -> () {
        let doctorOperation = DoctorOperation()
        doctorOperation.getDoctorsNamesList(clinicId: clinicID) {error, response, status in
            if status == .success {
                GlobalData.allDoctorModel.removeAll()
                let dict = response ?? [:]
                let doctorDictArray = dict["records"] as? [[String : Any]] ?? []
                for doctorDict in doctorDictArray {
                    GlobalData.allDoctorModel.append(DoctorModel(dict: doctorDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getAllClinic(outerClosure: @escaping ((Bool) -> ())) -> () {
        let clinicOperation = ClinicOperation()
        clinicOperation.getClinicNamesList {error, response, status in
            if status == .success {
                GlobalData.allClinicModel.removeAll()
                let dict = response ?? [:]
                let clinicDictArray = dict["records"] as? [[String : Any]] ?? []
                for clinicDict in clinicDictArray {
                    GlobalData.allClinicModel.append(ClinicModel(dict: clinicDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getPendingMaintenanceData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let maintenanceOperation = MaintenanceOperation()
        maintenanceOperation.getMaintenancePendingList {error, response, status in
            if status == .success {
                GlobalData.allpendingMaintenanceModel.removeAll()
                let dict = response ?? []
//                let maintenanceDictArray = dict["records"] as? [[String : Any]] ?? []
                for maintenanceDict in dict {
                    GlobalData.allpendingMaintenanceModel.append(PendingMaintenanceModel(dict: maintenanceDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getClosedMaintenanceData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let maintenanceOperation = MaintenanceOperation()
        maintenanceOperation.getMaintenanceClosedList {error, response, status in
            if status == .success {
                GlobalData.allClosedMaintenanceModel.removeAll()
                let dict = response ?? []
//                let maintenanceDictArray = dict["records"] as? [[String : Any]] ?? []
                for maintenanceDict in dict {
                    GlobalData.allClosedMaintenanceModel.append(ClosedMaintenanceModel(dict: maintenanceDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getPendingRedFlagData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let redFlagService = RedFlagService()
        redFlagService.getRedFlagPendingList {error, response, status in
            if status == .success {
                GlobalData.allPendingRedFlagModel.removeAll()
                let redFlagDictArray = response ?? []
                for redFlagDict in redFlagDictArray {
                    GlobalData.allPendingRedFlagModel.append(PendingRedFlagModel(dict: redFlagDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getClosedRedFlagData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let redFlagService = RedFlagService()
            redFlagService.getRedFlagClosedList {error, response, status in
            if status == .success {
                GlobalData.allClosingRedFlagModel.removeAll()
                let redFlagDictArray = response ?? []
                for redFlagDict in redFlagDictArray {
                    GlobalData.allClosingRedFlagModel.append(ClosingRedFlagModel(dict: redFlagDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getPendingRefundData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let refundWebService = RefundWebService()
        refundWebService.getPendingRefund(outerClosure: {error, response, status in
            if status == .success {
                GlobalData.allPendingRefundModel.removeAll()
                let refundDictArray = response ?? []
                for refundDict in refundDictArray {
                    GlobalData.allPendingRefundModel.append(PendingRefundModel(dict: refundDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        })
    }
    
    static func getClosedRefundData(outerClosure: @escaping ((Bool) -> ())) -> () {
        let refundWebService = RefundWebService()
        refundWebService.getClosedRefund {error, response, status in
            if status == .success {
                GlobalData.allClosingRefundModel.removeAll()
                let refundDictArray = response ?? []
                for refundDict in refundDictArray {
                    GlobalData.allClosingRefundModel.append(ClosingRefundModel(dict: refundDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        }
    }
    
    static func getDataBasedOnMaintenanceId(id: String, outerClosure: @escaping ((Bool) -> ())) -> () {
        let maintenanceOperation = MaintenanceOperation()
        maintenanceOperation.getMaintenanceDataOnTheBasisOfID(maintenanceId: id, outerClosure: { error, response, status in
            if status == .success {
                GlobalData.allpendingMaintenanceModel.removeAll()
                let maintenanceDictArray = response ?? []
                for maintenanceDict in maintenanceDictArray {
                    GlobalData.allpendingMaintenanceModel.append(PendingMaintenanceModel(dict: maintenanceDict))
                }
                outerClosure(true)
            } else {
                outerClosure(false)
            }
        })
    }
    
    static func getDataBasedOnPatientId(id: String, outerClosure: @escaping ((Bool) -> ())) {
        let patientOperation = PatientOperation()
        patientOperation.getPatienDetails(patientId: id, outerClosure: { error, response, status in
            guard status == .success, let dict = response else {
                print("Error: Failed to fetch patient details or invalid response format.")
                outerClosure(false)
                return
            }

            // Clear previous data
            GlobalData.patientDetailData.removeAll()

            // Directly parse the dictionary (no array expected)
            let patientModel = PatientDetailModel(dict: dict)
            GlobalData.patientDetailData.append(patientModel)

            outerClosure(true)
        })
    }
    
    static func getUniqueName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmssSSSS"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
    static func getStatus(responseCode: Int) -> ResponseStatus {
        switch responseCode {
        case 200, 201, 203, 204:
            return ResponseStatus.success
        case 409:
            return ResponseStatus.alreadyRegister
        case 500:
            return ResponseStatus.error
        case 401:
            return ResponseStatus.tokenExpired
        case 400:
            return ResponseStatus.badRequest
        default:
            return ResponseStatus.error
        }
    }
    
    static func setRightViewController(containerController: UIViewController, childViewController : UIViewController, isAnimated : Bool, fromOtherSCreen : Bool = false ) {
        self.fromOtherScreen = fromOtherSCreen
        presentController = childViewController
        removeAllChildController(containerController: containerController)
        let navigationController = UINavigationController(rootViewController: childViewController)
        navigationController.isNavigationBarHidden = true
        containerController.addChild(navigationController)
        containerController.view.addSubview(navigationController.view)
        navigationController.view.dropShadow(color: UIColor.black, opacity: 1.0, offSet: CGSize(width: -1, height: 1), radius:0.0, scale: true)
        navigationController.didMove(toParent: containerController)
        isMenuOpen = false
        if isAnimated {
            navigationController.view.frame.origin.x = getSideMenuWidth()
            UIView.animate(withDuration: 0.2, animations: {
                navigationController.view.frame.origin.x = 0
            })
        }
    }
    
    static func removeAllChildController(containerController: UIViewController) {
        for(_, controller) in containerController.children.enumerated() {
            controller.removeFromParent()
            controller.view.removeFromSuperview()
        }
    }
    
    static var overlayView: UIView?
    static func getSideMenuWidth() -> CGFloat {
        return 250.0
    }

    
}


