//
//  MaintenancePendingVC.swift
//  CFGApp
//
//  Created by Sakshi on 04/02/25.
//

import UIKit
import AVFoundation
import WebKit

class MaintenancePendingVC: UIViewController, UITextViewDelegate {
    @IBOutlet var ticketNo: UILabel?
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var classHeadingLbl: UILabel?
    @IBOutlet var issueLbl: UILabel?
    @IBOutlet var submitBtn: UIButton?
    @IBOutlet var vw: UIView?
    @IBOutlet var collectionVw: UICollectionView?
    @IBOutlet var collectionVwHeight: NSLayoutConstraint?
    @IBOutlet var bottomStack: UIStackView?
    
    @IBOutlet var stack1: UIStackView?
    @IBOutlet var stack12: UIStackView?
    @IBOutlet var AMDate: UILabel?
    @IBOutlet var AMView: UIView?
    @IBOutlet var AMComingRemarks: UILabel?
    @IBOutlet var AMTextView: UITextView?
    @IBOutlet var AMTextViewStack: UIStackView?
    @IBOutlet var yesAMBtn: UIButton?
    @IBOutlet var noAMBtn: UIButton?
    @IBOutlet var AMTotalTxtCount: UILabel?
    @IBOutlet var AMTxtCount: UILabel?
    @IBOutlet var AMTextViewHeight: NSLayoutConstraint?
    
    @IBOutlet var stack2: UIStackView?
    @IBOutlet var stack22: UIStackView?
    @IBOutlet var MODate: UILabel?
    @IBOutlet var MOView: UIView?
    @IBOutlet var MOComingRemarks: UILabel?
    @IBOutlet var MOTextView: UITextView?
    @IBOutlet var MOTextViewStack: UIStackView?
    @IBOutlet var yesMOBtn: UIButton?
    @IBOutlet var noMOBtn: UIButton?
    @IBOutlet var MOTotalTxtCount: UILabel?
    @IBOutlet var MOTxtCount: UILabel?
    @IBOutlet var MOTextViewHeight: NSLayoutConstraint?
    
    @IBOutlet var stack3: UIStackView?
    @IBOutlet var stack33: UIStackView?
    @IBOutlet var OVDate: UILabel?
    @IBOutlet var OVView: UIView?
    @IBOutlet var OVComingRemarks: UILabel?
    @IBOutlet var OVTextView: UITextView?
    @IBOutlet var OVTextViewStack: UIStackView?
    @IBOutlet var yesOVBtn: UIButton?
    @IBOutlet var noOVBtn: UIButton?
    @IBOutlet var OVTotalTxtCount: UILabel?
    @IBOutlet var OVTxtCount: UILabel?
    @IBOutlet var OVTextViewHeight: NSLayoutConstraint?
    
    @IBOutlet var stack4: UIStackView?
    @IBOutlet var stack44: UIStackView?
    @IBOutlet var finalDate: UILabel?
    @IBOutlet var finalView: UIView?
    @IBOutlet var finalComingRemarks: UILabel?
    @IBOutlet var finalTextView: UITextView?
    @IBOutlet var finalTextViewStack: UIStackView?
    @IBOutlet var yesFinalBtn: UIButton?
    @IBOutlet var noFinalBtn: UIButton?
    @IBOutlet var finalTotalTxtCount: UILabel?
    @IBOutlet var finalTxtCount: UILabel?
    
    var pendingMaintenanceData: PendingMaintenanceModel?
    var getPopulateData = [PendingMaintenanceModel]()
    var selectedMaintenance: PendingMaintenanceModel?
    var maintenanceOperation = MaintenanceOperation()
    let maxCharacterLimit = 131072
    var completionHandler: (String) -> Void = {_ in }
    
    var isAMYes: Bool = false
    var isMOYes: Bool = false
    var isOVYes: Bool = false
    var isFinalYes: Bool = false
    
    var isAMNo: Bool = false
    var isMONo: Bool = false
    var isOVNo: Bool = false
    var isFinalNo: Bool = false
    
    var isFixedByAM: Bool = false {
        didSet {
            if isFixedByAM {
                isAMYes = true
                yesAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isAMYes = false
                yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedByAM: Bool = false {
        didSet {
            if isNOFixedByAM {
                isAMNo = true
                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isAMNo = false
                noAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isFixedByMO: Bool = false {
        didSet {
            if isFixedByMO {
                isMOYes = true
                yesMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isMOYes = false
                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedByMO: Bool = false {
        didSet {
            if isNOFixedByMO {
                isMONo = true
                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isMONo = false
                noMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isFixedByOV: Bool = false {
        didSet {
            if isFixedByOV {
                isOVYes = true
                yesOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isOVYes = false
                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedByOV: Bool = false {
        didSet {
            if isNOFixedByOV {
                isOVNo = true
                noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isOVNo = false
                noOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isFixedByClsedCaseBtn: Bool = false {
        didSet {
            if isFixedByClsedCaseBtn {
                isFinalYes = true
                yesFinalBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isFinalYes = false
                yesFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedByClosedCase: Bool = false {
        didSet {
            if isNOFixedByClosedCase {
                isFinalNo = true
                noFinalBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isFinalNo = false
                noFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialUI()
        Utility.getDataBasedOnMaintenanceId(id: pendingMaintenanceData?.id ?? "") { success in
            if success {
                if let firstItem = GlobalData.allpendingMaintenanceModel.first {
                    self.selectedMaintenance = firstItem
                    DispatchQueue.main.async {
                        if (self.selectedMaintenance?.attachments?.isEmpty ?? true) {
                            self.collectionVwHeight?.constant = 0
                        } else {
                            self.collectionVwHeight?.constant = 60
                            self.collectionVw?.reloadData()
                        }
                      
                        
                    }
                }
            }
        }
        AMTextView?.delegate = self
        MOTextView?.delegate = self
        OVTextView?.delegate = self
        finalTextView?.delegate = self
        AMTextView?.isScrollEnabled = true
        MOTextView?.isScrollEnabled = true
        OVTextView?.isScrollEnabled = true
        finalTextView?.isScrollEnabled = true
    }
    
    func setUpInitialUI() {
        print(selectedMaintenance)
        addTapGestureToDismissKeyboard()
        submitBtn?.layer.cornerRadius = 10.0
        submitBtn?.layer.masksToBounds = true
        AMTextView?.layer.cornerRadius = 10.0
        AMTextView?.layer.masksToBounds = true
        MOTextView?.layer.cornerRadius = 10.0
        MOTextView?.layer.masksToBounds = true
        OVTextView?.layer.cornerRadius = 10.0
        OVTextView?.layer.masksToBounds = true
        finalTextView?.layer.cornerRadius = 10.0
        finalTextView?.layer.masksToBounds = true
        vw?.layer.cornerRadius = 10.0
        vw?.layer.masksToBounds = true
        AMView?.layer.cornerRadius = 10.0
        AMView?.layer.masksToBounds = true
        MOView?.layer.cornerRadius = 10.0
        MOView?.layer.masksToBounds = true
        vw?.layer.cornerRadius = 10.0
        vw?.layer.masksToBounds = true
        vw?.layer.cornerRadius = 10.0
        vw?.layer.masksToBounds = true
        vw?.borderWidth = 0.5
        vw?.borderColor = .lightGray
        ticketNo?.text = pendingMaintenanceData?.name
        issueLbl?.text = pendingMaintenanceData?.issue
        var headingText = ""
        let statusText = pendingMaintenanceData?.status
//        let userRoleEnum = StatusItems(rawValue: Defaults.userRole ?? "")
//        let specificRoles: [StatusItems] = [.clinicFDSupervisorsRedFlag, .aMRedFlag, .mo, .ov]
//        if userRoleEnum?.getStatusItemsText() == pendingMaintenanceData?.status || userRoleEnum?.getStatusItemsText() ==  "Pending by MO" || StatusItems.clinicFDSupervisorsRedFlag.getStatusItemsText(isForAM: true) == pendingMaintenanceData?.status{
        if let userRoleEnum = StatusItems(rawValue: Defaults.userRole ?? "") {
            let specificRoles: [StatusItems] = [.clinicFDSupervisorsRedFlag, .aMRedFlag, .mo, .ov, .admin]
            
            if (((specificRoles.contains(userRoleEnum) && userRoleEnum.getStatusItemsText() == pendingMaintenanceData?.status || userRoleEnum == .admin) ||
                ((pendingMaintenanceData?.status == "Pending by OV" || pendingMaintenanceData?.status == "Pending by MO") && userRoleEnum == .mo))
                &&
                (userRoleEnum.getStatusItemsText() == "Pending by MO" ||
                 StatusItems.clinicFDSupervisorsRedFlag.getStatusItemsText(isForAM: true) == pendingMaintenanceData?.status || userRoleEnum == .admin)) {
                if pendingMaintenanceData?.status == "Pending by AM" && pendingMaintenanceData?.isIssueFixedByAM == "NA" {
                    stack1?.isHidden = false
                    stack2?.isHidden = true
                    stack3?.isHidden = true
                    stack4?.isHidden = true
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                    classHeadingLbl?.text = "Maintenance | AM"
                    AMDate?.text = ""
                    AMView?.borderWidth = 0.5
                    AMView?.borderColor = .lightGray
                    AMComingRemarks?.text = ""
                    AMTextViewStack?.borderWidth = 0.5
                    AMTextViewStack?.borderColor = .lightGray
                    AMTotalTxtCount?.text = "/131072"
                    AMTxtCount?.text = "0"
                    yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    return
                }
                if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByAM == "No" && pendingMaintenanceData?.isIssueFixedByMO == "NA" {
                    stack1?.isHidden = false
                    stack2?.isHidden = false
                    stack3?.isHidden = true
                    stack4?.isHidden = true
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                    classHeadingLbl?.text = "Maintenance | MO"
                    isAMNo = false
                    isAMYes = false
                    yesAMBtn?.isEnabled = false
                    noAMBtn?.isEnabled = false
                    yesAMBtn?.alpha = 0.5
                    noAMBtn?.alpha = 0.5
                    yesAMBtn?.isUserInteractionEnabled = false
                    noAMBtn?.isUserInteractionEnabled = false
                    yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
                    noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    AMDate?.text = pendingMaintenanceData?.amRemarksDate
                    AMView?.borderWidth = 0.5
                    AMView?.borderColor = .lightGray
                    AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                    AMTextViewStack?.isHidden = true
                    AMTotalTxtCount?.text = ""
                    AMTxtCount?.text = ""
                    AMTextViewHeight?.constant = 0
                    
                    yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    MODate?.text = ""
                    MOView?.borderWidth = 0.5
                    MOView?.borderColor = .lightGray
                    MOComingRemarks?.text = ""
                    MOTextViewStack?.borderWidth = 0.5
                    MOTextViewStack?.borderColor = .lightGray
                    MOTotalTxtCount?.text = "/131072"
                    MOTxtCount?.text = "0"
                    return
                }
                //            if pendingMaintenanceData?.isIssueFixedByMO == "NA" {
                //                stack1?.isHidden = false
                //                stack2?.isHidden = false
                //                stack3?.isHidden = true
                //                stack4?.isHidden = true
                //                UIView.animate(withDuration: 0.3) {
                //                    self.view.layoutIfNeeded()
                //                }
                //
                //                yesAMBtn?.isEnabled = false
                //                noAMBtn?.isEnabled = false
                //                yesAMBtn?.alpha = 0.5
                //                noAMBtn?.alpha = 0.5
                //                yesAMBtn?.isUserInteractionEnabled = false
                //                noAMBtn?.isUserInteractionEnabled = false
                //                AMDate?.textColor = .gray
                //                AMComingRemarks?.textColor = .gray
                //                yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                //                AMDate?.text = pendingMaintenanceData?.amRemarksDate
                //                AMView?.borderWidth = 0.5
                //                yesAMBtn?.tintColor = .gray
                //                noAMBtn?.tintColor = .gray
                //                AMView?.borderColor = .lightGray
                //                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks
                //                AMTextViewStack?.isHidden = true
                //                AMTotalTxtCount?.text = ""
                //                AMTxtCount?.text = ""
                //
                //                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                noMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                MODate?.text = ""
                //                MOView?.borderWidth = 0.5
                //                MOView?.borderColor = .lightGray
                //                MOComingRemarks?.text = ""
                //                MOTextViewStack?.borderWidth = 0.5
                //                MOTextViewStack?.borderColor = .lightGray
                //                MOTotalTxtCount?.text = "/131072"
                //                MOTxtCount?.text = "0"
                //                return
                //            }
                if pendingMaintenanceData?.status == "Pending by OV" && pendingMaintenanceData?.isIssueFixedByMO == "No" {
                    stack1?.isHidden = false
                    stack2?.isHidden = false
                    stack3?.isHidden = false
                    stack4?.isHidden = true
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                    classHeadingLbl?.text = "Maintenance | OV"
                    isAMNo = false
                    isAMYes = false
                    yesAMBtn?.isEnabled = false
                    noAMBtn?.isEnabled = false
                    yesAMBtn?.alpha = 0.5
                    noAMBtn?.alpha = 0.5
                    AMTextViewHeight?.constant = 0
                    yesAMBtn?.isUserInteractionEnabled = false
                    noAMBtn?.isUserInteractionEnabled = false
                    yesAMBtn?.tintColor = .gray
                    noAMBtn?.tintColor = .gray
                    AMDate?.textColor = .gray
                    AMComingRemarks?.textColor = .gray
                    yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    AMDate?.text = pendingMaintenanceData?.amRemarksDate
                    AMView?.borderWidth = 0.5
                    AMView?.borderColor = .lightGray
                    AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                    AMTextViewStack?.isHidden = true
                    AMTotalTxtCount?.text = ""
                    AMTxtCount?.text = ""
                    
                    isMONo = false
                    isMOYes = false
                    yesMOBtn?.isEnabled = false
                    noMOBtn?.isEnabled = false
                    yesMOBtn?.alpha = 0.5
                    noMOBtn?.alpha = 0.5
                    MOTextViewHeight?.constant = 0
                    yesMOBtn?.isUserInteractionEnabled = false
                    noMOBtn?.isUserInteractionEnabled = false
                    yesMOBtn?.tintColor = .gray
                    noMOBtn?.tintColor = .gray
                    MODate?.textColor = .gray
                    MOComingRemarks?.textColor = .gray
                    yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    MODate?.text = pendingMaintenanceData?.moRemarksDate == "NA" ? "" :  pendingMaintenanceData?.moRemarksDate
                    MOView?.borderWidth = 0.5
                    MOView?.borderColor = .lightGray
                    MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks
                    MOTextViewStack?.isHidden = true
                    MOTotalTxtCount?.text = ""
                    MOTxtCount?.text = ""
                    
                    yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    OVDate?.text = ""
                    OVView?.layer.cornerRadius = 10.0
                    OVView?.layer.masksToBounds = true
                    OVView?.borderWidth = 0.5
                    OVView?.borderColor = .lightGray
                    OVComingRemarks?.text = ""
                    OVTextViewStack?.borderWidth = 0.5
                    OVTextViewStack?.borderColor = .lightGray
                    OVTotalTxtCount?.text = "/131072"
                    OVTxtCount?.text = "0"
                    return
                }
                //            if pendingMaintenanceData?.isIssueFixedByOV == "NA" {
                //                stack1?.isHidden = false
                //                stack2?.isHidden = false
                //                stack3?.isHidden = false
                //                stack4?.isHidden = true
                //                UIView.animate(withDuration: 0.3) {
                //                    self.view.layoutIfNeeded()
                //                }
                //
                //                AMTextViewHeight?.constant = 0
                //                yesAMBtn?.isEnabled = false
                //                noAMBtn?.isEnabled = false
                //                yesAMBtn?.alpha = 0.5
                //                noAMBtn?.alpha = 0.5
                //                AMTextViewHeight?.constant = 0
                //                yesAMBtn?.isUserInteractionEnabled = false
                //                noAMBtn?.isUserInteractionEnabled = false
                //                yesAMBtn?.tintColor = .gray
                //                noAMBtn?.tintColor = .gray
                //                AMDate?.textColor = .gray
                //                AMComingRemarks?.textColor = .gray
                //                yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                //                AMDate?.text = pendingMaintenanceData?.amRemarksDate
                //                AMView?.borderWidth = 0.5
                //                AMView?.borderColor = .lightGray
                //                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks
                //                AMTextViewStack?.isHidden = true
                //                AMTotalTxtCount?.text = ""
                //                AMTxtCount?.text = ""
                //
                //                yesMOBtn?.isEnabled = false
                //                noMOBtn?.isEnabled = false
                //                yesMOBtn?.alpha = 0.5
                //                noMOBtn?.alpha = 0.5
                //                MOTextViewHeight?.constant = 0
                //                yesMOBtn?.isUserInteractionEnabled = false
                //                noMOBtn?.isUserInteractionEnabled = false
                //                yesMOBtn?.tintColor = .gray
                //                noMOBtn?.tintColor = .gray
                //                MODate?.textColor = .gray
                //                MOComingRemarks?.textColor = .gray
                //                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                //                MODate?.text = pendingMaintenanceData?.moRemarksDate
                //                MOView?.borderWidth = 0.5
                //                MOView?.borderColor = .lightGray
                //                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks
                //                MOTextViewStack?.isHidden = true
                //                MOTotalTxtCount?.text = ""
                //                MOTxtCount?.text = ""
                //
                //                OVView?.layer.cornerRadius = 10.0
                //                OVView?.layer.masksToBounds = true
                //                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                noOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                //                OVDate?.text = ""
                //                OVView?.borderWidth = 0.5
                //                OVView?.borderColor = .lightGray
                //                OVComingRemarks?.text = ""
                //                OVTextViewStack?.borderWidth = 0.5
                //                OVTextViewStack?.borderColor = .lightGray
                //                OVTotalTxtCount?.text = "/131072"
                //                OVTxtCount?.text = "0"
                //                return
                //            }
                if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV == "No" && pendingMaintenanceData?.isIssueFixedByMO == "No" {
                    stack1?.isHidden = false
                    stack2?.isHidden = false
                    stack3?.isHidden = false
                    stack4?.isHidden = false
                    classHeadingLbl?.text = "Maintenance | Final Closing"
                    
                    isAMNo = false
                    isAMYes = false
                    yesAMBtn?.isEnabled = false
                    noAMBtn?.isEnabled = false
                    yesAMBtn?.alpha = 0.5
                    noAMBtn?.alpha = 0.5
                    AMTextViewHeight?.constant = 0
                    yesAMBtn?.isUserInteractionEnabled = false
                    noAMBtn?.isUserInteractionEnabled = false
                    yesAMBtn?.tintColor = .gray
                    noAMBtn?.tintColor = .gray
                    AMDate?.textColor = .gray
                    AMComingRemarks?.textColor = .gray
                    yesAMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    AMDate?.text = pendingMaintenanceData?.amRemarksDate
                    AMView?.borderWidth = 0.5
                    AMView?.borderColor = .lightGray
                    AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                    AMTextViewStack?.isHidden = true
                    AMTotalTxtCount?.text = ""
                    AMTxtCount?.text = ""
                    
                    isMONo = false
                    isMOYes = false
                    yesMOBtn?.isEnabled = false
                    noMOBtn?.isEnabled = false
                    yesMOBtn?.alpha = 0.5
                    noMOBtn?.alpha = 0.5
                    MOTextViewHeight?.constant = 0
                    yesMOBtn?.isUserInteractionEnabled = false
                    noMOBtn?.isUserInteractionEnabled = false
                    yesMOBtn?.tintColor = .gray
                    noMOBtn?.tintColor = .gray
                    MODate?.textColor = .gray
                    MOComingRemarks?.textColor = .gray
                    yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    MODate?.text = pendingMaintenanceData?.moRemarksDate
                    MOView?.borderWidth = 0.5
                    MOView?.borderColor = .lightGray
                    MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
                    MOTextViewStack?.isHidden = true
                    MOTotalTxtCount?.text = ""
                    MOTxtCount?.text = ""
                    
                    isOVNo = false
                    isOVYes = false
                    OVView?.layer.cornerRadius = 10.0
                    OVView?.layer.masksToBounds = true
                    yesOVBtn?.isEnabled = false
                    noOVBtn?.isEnabled = false
                    yesOVBtn?.alpha = 0.5
                    noOVBtn?.alpha = 0.5
                    OVTextViewHeight?.constant = 0
                    yesOVBtn?.isUserInteractionEnabled = false
                    noOVBtn?.isUserInteractionEnabled = false
                    yesOVBtn?.tintColor = .gray
                    noOVBtn?.tintColor = .gray
                    OVDate?.textColor = .gray
                    OVComingRemarks?.textColor = .gray
                    yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    OVDate?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c
                    OVView?.borderWidth = 0.5
                    OVView?.borderColor = .lightGray
                    OVComingRemarks?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks__c == "NA" ? "" :  pendingMaintenanceData?.Outsource_Vendor_Remarks__c
                    OVTextViewStack?.isHidden = true
                    OVTotalTxtCount?.text = ""
                    OVTxtCount?.text = ""
                    
                    finalView?.layer.cornerRadius = 10.0
                    finalView?.layer.masksToBounds = true
                    yesFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    noFinalBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    finalDate?.text = ""
                    finalView?.borderWidth = 0.5
                    finalView?.borderColor = .lightGray
                    finalComingRemarks?.text = ""
                    finalTextViewStack?.borderWidth = 0.5
                    finalTextViewStack?.borderColor = .lightGray
                    finalTotalTxtCount?.text = "/131072"
                    finalTxtCount?.text = "0"
                    return
                } else {
                    stack1?.isHidden = true
                    stack2?.isHidden = true
                    stack3?.isHidden = true
                    stack4?.isHidden = true
                    bottomStack?.isHidden = true
                    return
                }
            }
            else if pendingMaintenanceData?.status == "Pending by AM" {
                classHeadingLbl?.text = "Maintenance | AM"
                stack1?.isHidden = true
                stack2?.isHidden = true
                stack3?.isHidden = true
                stack4?.isHidden = true
                bottomStack?.isHidden = true
                return
            } else if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByAM == "No" {
                stack1?.isHidden = false
                stack2?.isHidden = true
                stack3?.isHidden = true
                stack4?.isHidden = true
                bottomStack?.isHidden = true
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                isAMNo = false
                isAMYes = false
                classHeadingLbl?.text = "Maintenance | MO"
                yesAMBtn?.isEnabled = false
                noAMBtn?.isEnabled = false
                yesAMBtn?.alpha = 0.5
                noAMBtn?.alpha = 0.5
                yesAMBtn?.isUserInteractionEnabled = false
                noAMBtn?.isUserInteractionEnabled = false
                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                AMDate?.text = pendingMaintenanceData?.amRemarksDate == "NA" ? "" :  pendingMaintenanceData?.amRemarksDate
                AMView?.borderWidth = 0.5
                AMView?.borderColor = .lightGray
                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                AMTextViewStack?.isHidden = true
                AMTotalTxtCount?.text = ""
                AMTxtCount?.text = ""
                AMTextViewHeight?.constant = 0
                return
                
            } else if pendingMaintenanceData?.status == "Pending by OV" {
                stack1?.isHidden = false
                stack2?.isHidden = false
                stack3?.isHidden = true
                stack4?.isHidden = true
                bottomStack?.isHidden = true
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                
                classHeadingLbl?.text = "Maintenance | MO"
                isAMNo = false
                isAMYes = false
                yesAMBtn?.isEnabled = false
                noAMBtn?.isEnabled = false
                yesAMBtn?.alpha = 0.5
                noAMBtn?.alpha = 0.5
                yesAMBtn?.isUserInteractionEnabled = false
                noAMBtn?.isUserInteractionEnabled = false
                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                AMDate?.text = pendingMaintenanceData?.amRemarksDate == "NA" ? "" :  pendingMaintenanceData?.amRemarksDate
                AMView?.borderWidth = 0.5
                AMView?.borderColor = .lightGray
                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                AMTextViewStack?.isHidden = true
                AMTotalTxtCount?.text = ""
                AMTxtCount?.text = ""
                AMTextViewHeight?.constant = 0
                
                isMONo = false
                isMOYes = false
                yesMOBtn?.isEnabled = false
                noMOBtn?.isEnabled = false
                yesMOBtn?.alpha = 0.5
                noMOBtn?.alpha = 0.5
                MOTextViewHeight?.constant = 0
                yesMOBtn?.isUserInteractionEnabled = false
                noMOBtn?.isUserInteractionEnabled = false
                yesMOBtn?.tintColor = .gray
                noMOBtn?.tintColor = .gray
                MODate?.textColor = .gray
                MOComingRemarks?.textColor = .gray
                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                MODate?.text = pendingMaintenanceData?.moRemarksDate == "NA" ? "" : pendingMaintenanceData?.moRemarksDate
                MOView?.borderWidth = 0.5
                MOView?.borderColor = .lightGray
                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
                MOTextViewStack?.isHidden = true
                MOTotalTxtCount?.text = ""
                MOTxtCount?.text = ""
                return
                
            } else if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV == "No" {
                stack1?.isHidden = false
                stack2?.isHidden = false
                stack3?.isHidden = false
                stack4?.isHidden = true
                bottomStack?.isHidden = true
                
                classHeadingLbl?.text = "Maintenance | MO"
                isAMNo = false
                isAMYes = false
                yesAMBtn?.isEnabled = false
                noAMBtn?.isEnabled = false
                yesAMBtn?.alpha = 0.5
                noAMBtn?.alpha = 0.5
                yesAMBtn?.isUserInteractionEnabled = false
                noAMBtn?.isUserInteractionEnabled = false
                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                AMDate?.text = pendingMaintenanceData?.amRemarksDate == "NA" ? "" :  pendingMaintenanceData?.amRemarksDate
                AMView?.borderWidth = 0.5
                AMView?.borderColor = .lightGray
                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
                AMTextViewStack?.isHidden = true
                AMTotalTxtCount?.text = ""
                AMTxtCount?.text = ""
                AMTextViewHeight?.constant = 0
                
                isMONo = false
                isMOYes = false
                yesMOBtn?.isEnabled = false
                noMOBtn?.isEnabled = false
                yesMOBtn?.alpha = 0.5
                noMOBtn?.alpha = 0.5
                MOTextViewHeight?.constant = 0
                yesMOBtn?.isUserInteractionEnabled = false
                noMOBtn?.isUserInteractionEnabled = false
                yesMOBtn?.tintColor = .gray
                noMOBtn?.tintColor = .gray
                MODate?.textColor = .gray
                MOComingRemarks?.textColor = .gray
                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                MODate?.text = pendingMaintenanceData?.moRemarksDate == "NA" ? "" : pendingMaintenanceData?.moRemarksDate
                MOView?.borderWidth = 0.5
                MOView?.borderColor = .lightGray
                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
                MOTextViewStack?.isHidden = true
                MOTotalTxtCount?.text = ""
                MOTxtCount?.text = ""
                
                isOVNo = false
                isOVYes = false
                OVView?.layer.cornerRadius = 10.0
                OVView?.layer.masksToBounds = true
                yesOVBtn?.isEnabled = false
                noOVBtn?.isEnabled = false
                yesOVBtn?.alpha = 0.5
                noOVBtn?.alpha = 0.5
                OVTextViewHeight?.constant = 0
                yesOVBtn?.isUserInteractionEnabled = false
                noOVBtn?.isUserInteractionEnabled = false
                yesOVBtn?.tintColor = .gray
                noOVBtn?.tintColor = .gray
                OVDate?.textColor = .gray
                OVComingRemarks?.textColor = .gray
                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                OVDate?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c == "NA" ? "" : pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c
                OVView?.borderWidth = 0.5
                OVView?.borderColor = .lightGray
                OVComingRemarks?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks__c == "NA" ? "" :  pendingMaintenanceData?.Outsource_Vendor_Remarks__c
                OVTextViewStack?.isHidden = true
                OVTotalTxtCount?.text = ""
                OVTxtCount?.text = ""
                return
            }
        }
        
        
        
        
        //        else if (pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByAM == "No" && pendingMaintenanceData?.isIssueFixedByMO == "NA") && userRoleEnum?.getStatusItemsText() == StatusItems.clinicFDSupervisorsRedFlag.getStatusItemsText(isForAM: false) {
        //            stack1?.isHidden = false
        //            UIView.animate(withDuration: 0.3) {
        //                self.view.layoutIfNeeded()
        //            }
        //            classHeadingLbl?.text = "Maintenance | MO"
        //            yesAMBtn?.isEnabled = false
        //            noAMBtn?.isEnabled = false
        //            yesAMBtn?.alpha = 0.5
        //            noAMBtn?.alpha = 0.5
        //            yesAMBtn?.isUserInteractionEnabled = false
        //            noAMBtn?.isUserInteractionEnabled = false
        //            yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
        //            noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //            AMDate?.text = pendingMaintenanceData?.amRemarksDate
        //            AMView?.borderWidth = 0.5
        //            AMView?.borderColor = .lightGray
        //            AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
        //            AMTextViewStack?.isHidden = true
        //            AMTotalTxtCount?.text = ""
        //            AMTxtCount?.text = ""
        //            AMTextViewHeight?.constant = 0
        //
        //            stack2?.isHidden = true
        //            stack3?.isHidden = true
        //            stack4?.isHidden = true
        //            bottomStack?.isHidden = true
        //            return
        //        } else if (pendingMaintenanceData?.status == "Pending by OV" && pendingMaintenanceData?.isIssueFixedByMO == "No") && userRoleEnum?.getStatusItemsText() == "Pending by MO" {
        //            stack2?.isHidden = false
        //            stack3?.isHidden = true
        //            stack4?.isHidden = true
        //            stack1?.isHidden = true
        //
        //            yesMOBtn?.isEnabled = false
        //            noMOBtn?.isEnabled = false
        //            yesMOBtn?.alpha = 0.5
        //            noMOBtn?.alpha = 0.5
        //            MOTextViewHeight?.constant = 0
        //            yesMOBtn?.isUserInteractionEnabled = false
        //            noMOBtn?.isUserInteractionEnabled = false
        //            yesMOBtn?.tintColor = .gray
        //            noMOBtn?.tintColor = .gray
        //            MODate?.textColor = .gray
        //            MOComingRemarks?.textColor = .gray
        //            yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //            noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //            MODate?.text = pendingMaintenanceData?.moRemarksDate
        //            MOView?.borderWidth = 0.5
        //            MOView?.borderColor = .lightGray
        //            MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
        //            MOTextViewStack?.isHidden = true
        //            MOTotalTxtCount?.text = ""
        //            MOTxtCount?.text = ""
        //
        //            bottomStack?.isHidden = true
        //            return
        //        } else if (pendingMaintenanceData?.status == "Pending by OV" && pendingMaintenanceData?.isIssueFixedByMO == "No") && userRoleEnum?.getStatusItemsText() == "Pending by OV" {
        //            stack2?.isHidden = true
        //            stack3?.isHidden = false
        //            stack4?.isHidden = true
        //            stack1?.isHidden = true
        //
        //            OVView?.layer.cornerRadius = 10.0
        //            OVView?.layer.masksToBounds = true
        //            yesOVBtn?.isEnabled = false
        //            noOVBtn?.isEnabled = false
        //            yesOVBtn?.alpha = 0.5
        //            noOVBtn?.alpha = 0.5
        //            OVTextViewHeight?.constant = 0
        //            yesOVBtn?.isUserInteractionEnabled = false
        //            noOVBtn?.isUserInteractionEnabled = false
        //            yesOVBtn?.tintColor = .gray
        //            noOVBtn?.tintColor = .gray
        //            OVDate?.textColor = .gray
        //            OVComingRemarks?.textColor = .gray
        //            yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //            noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //            OVDate?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c
        //            OVView?.borderWidth = 0.5
        //            OVView?.borderColor = .lightGray
        //            OVComingRemarks?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks__c == "NA" ? "" :  pendingMaintenanceData?.Outsource_Vendor_Remarks__c
        //            OVTextViewStack?.isHidden = true
        //            OVTotalTxtCount?.text = ""
        //            OVTxtCount?.text = ""
        //
        //            bottomStack?.isHidden = true
        //            return
        //        } else {
        //            if pendingMaintenanceData?.status == "Pending by AM" {
        //                headingText = "Maintenance | AM"
        //                stack1?.isHidden = false
        //                UIView.animate(withDuration: 0.3) {
        //                    self.view.layoutIfNeeded()
        //                }
        ////                yesAMBtn?.isEnabled = false
        ////                noAMBtn?.isEnabled = false
        //                yesAMBtn?.alpha = 0.5
        //                noAMBtn?.alpha = 0.5
        //                yesAMBtn?.isUserInteractionEnabled = false
        //                noAMBtn?.isUserInteractionEnabled = false
        //                yesAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        ////                AMDate?.text = pendingMaintenanceData?.amRemarksDate
        //                AMView?.borderWidth = 0.5
        //                AMView?.borderColor = .lightGray
        //                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
        //                AMTextViewStack?.isHidden = true
        //                AMTotalTxtCount?.text = ""
        //                AMTxtCount?.text = ""
        //                AMTextViewHeight?.constant = 0
        //
        //                stack2?.isHidden = true
        //                stack3?.isHidden = true
        //                stack4?.isHidden = true
        //                bottomStack?.isHidden = true
        //                return
        //            } else if pendingMaintenanceData?.status == "Pending by MO" {
        //                headingText = "Maintenance | MO"
        //
        //                yesAMBtn?.isEnabled = false
        //                noAMBtn?.isEnabled = false
        //                yesAMBtn?.alpha = 0.5
        //                noAMBtn?.alpha = 0.5
        //                yesAMBtn?.isUserInteractionEnabled = false
        //                noAMBtn?.isUserInteractionEnabled = false
        //                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
        //                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                AMDate?.text = pendingMaintenanceData?.amRemarksDate
        //                AMView?.borderWidth = 0.5
        //                AMView?.borderColor = .lightGray
        //                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
        //                AMTextViewStack?.isHidden = true
        //                AMTotalTxtCount?.text = ""
        //                AMTxtCount?.text = ""
        //                AMTextViewHeight?.constant = 0
        //
        //                yesMOBtn?.isEnabled = false
        //                noMOBtn?.isEnabled = false
        //                yesMOBtn?.alpha = 0.5
        //                noMOBtn?.alpha = 0.5
        //                MOTextViewHeight?.constant = 0
        //                yesMOBtn?.isUserInteractionEnabled = false
        //                noMOBtn?.isUserInteractionEnabled = false
        //                yesMOBtn?.tintColor = .gray
        //                noMOBtn?.tintColor = .gray
        //                MODate?.textColor = .gray
        //                MOComingRemarks?.textColor = .gray
        //                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                MODate?.text = pendingMaintenanceData?.moRemarksDate
        //                MOView?.borderWidth = 0.5
        //                MOView?.borderColor = .lightGray
        //                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
        //                MOTextViewStack?.isHidden = true
        //                MOTotalTxtCount?.text = ""
        //                MOTxtCount?.text = ""
        //
        //                stack1?.isHidden = false
        //                stack2?.isHidden = false
        //                stack3?.isHidden = true
        //                stack4?.isHidden = true
        //                bottomStack?.isHidden = true
        //                return
        //
        //            } else if pendingMaintenanceData?.status == "Pending by OV"  {
        //                headingText = "Maintenance | OV"
        //
        //                yesAMBtn?.isEnabled = false
        //                noAMBtn?.isEnabled = false
        //                yesAMBtn?.alpha = 0.5
        //                noAMBtn?.alpha = 0.5
        //                yesAMBtn?.isUserInteractionEnabled = false
        //                noAMBtn?.isUserInteractionEnabled = false
        //                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
        //                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                AMDate?.text = pendingMaintenanceData?.amRemarksDate
        //                AMView?.borderWidth = 0.5
        //                AMView?.borderColor = .lightGray
        //                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks == "NA" ? "" :  pendingMaintenanceData?.amRemarks
        //                AMTextViewStack?.isHidden = true
        //                AMTotalTxtCount?.text = ""
        //                AMTxtCount?.text = ""
        //                AMTextViewHeight?.constant = 0
        //
        //                yesMOBtn?.isEnabled = false
        //                noMOBtn?.isEnabled = false
        //                yesMOBtn?.alpha = 0.5
        //                noMOBtn?.alpha = 0.5
        //                MOTextViewHeight?.constant = 0
        //                yesMOBtn?.isUserInteractionEnabled = false
        //                noMOBtn?.isUserInteractionEnabled = false
        //                yesMOBtn?.tintColor = .gray
        //                noMOBtn?.tintColor = .gray
        //                MODate?.textColor = .gray
        //                MOComingRemarks?.textColor = .gray
        //                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                MODate?.text = pendingMaintenanceData?.moRemarksDate
        //                MOView?.borderWidth = 0.5
        //                MOView?.borderColor = .lightGray
        //                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks == "NA" ? "" :  pendingMaintenanceData?.maintenanceOfficerRemarks
        //                MOTextViewStack?.isHidden = true
        //                MOTotalTxtCount?.text = ""
        //                MOTxtCount?.text = ""
        //
        //                OVView?.layer.cornerRadius = 10.0
        //                OVView?.layer.masksToBounds = true
        //                yesOVBtn?.isEnabled = false
        //                noOVBtn?.isEnabled = false
        //                yesOVBtn?.alpha = 0.5
        //                noOVBtn?.alpha = 0.5
        //                OVTextViewHeight?.constant = 0
        //                yesOVBtn?.isUserInteractionEnabled = false
        //                noOVBtn?.isUserInteractionEnabled = false
        //                yesOVBtn?.tintColor = .gray
        //                noOVBtn?.tintColor = .gray
        //                OVDate?.textColor = .gray
        //                OVComingRemarks?.textColor = .gray
        //                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //                noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //                OVDate?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c
        //                OVView?.borderWidth = 0.5
        //                OVView?.borderColor = .lightGray
        //                OVComingRemarks?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks__c == "NA" ? "" :  pendingMaintenanceData?.Outsource_Vendor_Remarks__c
        //                OVTextViewStack?.isHidden = true
        //                OVTotalTxtCount?.text = ""
        //                OVTxtCount?.text = ""
        //
        //                stack1?.isHidden = false
        //                stack2?.isHidden = false
        //                stack3?.isHidden = false
        //                stack4?.isHidden = true
        //                bottomStack?.isHidden = true
        //                return
        //            } else if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV == "No" && pendingMaintenanceData?.isIssueFixedByMO == "No" {
        //                headingText = "Maintenance | Final Closing"
        //
        ////                yesAMBtn?.isEnabled = false
        ////                noAMBtn?.isEnabled = false
        ////                yesAMBtn?.alpha = 0.5
        ////                noAMBtn?.alpha = 0.5
        ////                yesAMBtn?.isUserInteractionEnabled = false
        ////                noAMBtn?.isUserInteractionEnabled = false
        ////                yesAMBtn?.setImage(UIImage(named: "check"), for: UIControl.State.normal)
        ////                noAMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        ////                AMDate?.text = pendingMaintenanceData?.amRemarksDate
        ////                AMView?.borderWidth = 0.5
        ////                AMView?.borderColor = .lightGray
        ////                AMComingRemarks?.text = pendingMaintenanceData?.amRemarks
        ////                AMTextViewStack?.isHidden = true
        ////                AMTotalTxtCount?.text = ""
        ////                AMTxtCount?.text = ""
        ////                AMTextViewHeight?.constant = 0
        ////
        ////                yesMOBtn?.isEnabled = false
        ////                noMOBtn?.isEnabled = false
        ////                yesMOBtn?.alpha = 0.5
        ////                noMOBtn?.alpha = 0.5
        ////                MOTextViewHeight?.constant = 0
        ////                yesMOBtn?.isUserInteractionEnabled = false
        ////                noMOBtn?.isUserInteractionEnabled = false
        ////                yesMOBtn?.tintColor = .gray
        ////                noMOBtn?.tintColor = .gray
        ////                MODate?.textColor = .gray
        ////                MOComingRemarks?.textColor = .gray
        ////                yesMOBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        ////                noMOBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        ////                MODate?.text = pendingMaintenanceData?.moRemarksDate
        ////                MOView?.borderWidth = 0.5
        ////                MOView?.borderColor = .lightGray
        ////                MOComingRemarks?.text = pendingMaintenanceData?.maintenanceOfficerRemarks
        ////                MOTextViewStack?.isHidden = true
        ////                MOTotalTxtCount?.text = ""
        ////                MOTxtCount?.text = ""
        ////
        ////                OVView?.layer.cornerRadius = 10.0
        ////                OVView?.layer.masksToBounds = true
        ////                yesOVBtn?.isEnabled = false
        ////                noOVBtn?.isEnabled = false
        ////                yesOVBtn?.alpha = 0.5
        ////                noOVBtn?.alpha = 0.5
        ////                OVTextViewHeight?.constant = 0
        ////                yesOVBtn?.isUserInteractionEnabled = false
        ////                noOVBtn?.isUserInteractionEnabled = false
        ////                yesOVBtn?.tintColor = .gray
        ////                noOVBtn?.tintColor = .gray
        ////                OVDate?.textColor = .gray
        ////                OVComingRemarks?.textColor = .gray
        ////                yesOVBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        ////                noOVBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        ////                OVDate?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks_Date__c
        ////                OVView?.borderWidth = 0.5
        ////                OVView?.borderColor = .lightGray
        ////                OVComingRemarks?.text = pendingMaintenanceData?.Outsource_Vendor_Remarks__c
        ////                OVTextViewStack?.isHidden = true
        ////                OVTotalTxtCount?.text = ""
        ////                OVTxtCount?.text = ""
        //
        //                stack1?.isHidden = true
        //                stack2?.isHidden = true
        //                stack3?.isHidden = true
        //                stack4?.isHidden = true
        //                bottomStack?.isHidden = true
        //                return
        //            }
//    else {
//                bottomStack?.isHidden = true
//                stack1?.isHidden = true
//                stack2?.isHidden = true
//                stack3?.isHidden = true
//                stack4?.isHidden = true
//                let checkInalert = UIAlertController(
//                    title: "Info",
//                    message: "You do not have permission to edit this ticket.",
//                    preferredStyle: .alert
//                )
//                self.present(checkInalert, animated: true, completion: nil)
//                checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
//                    print("Cancel tapped")
//                }))
//            }
            
            
            
            
            
            
            
            
//            classHeadingLbl?.text = headingText
////
//        }
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentTextCount = textView.text.count
        
        if textView == AMTextView {
            AMTxtCount?.text = "\(currentTextCount)"
        } else if textView == MOTextView {
            MOTxtCount?.text = "\(currentTextCount)"
        } else if textView == OVTextView {
            OVTxtCount?.text = "\(currentTextCount)"
        } else if textView == finalTextView {
            finalTxtCount?.text = "\(currentTextCount)"
        }

        adjustTextViewHeight(textView)
    }
    
    func adjustTextViewHeight(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        // Update height constraint dynamically
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = newSize.height
            }
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newLength = currentText.count + text.count - range.length
        return newLength <= maxCharacterLimit
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction() {
        submitFunc()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    func submitFunc() {
        var status = ""
        if pendingMaintenanceData?.status == "Pending by AM" {
            if !(isAMYes || isAMNo) {
                showAlert(message: "Please select issue Fixed or not")
                return
            } else if (AMTextView?.text.isEmpty ?? false) {
                showAlert(message: "Please enter AM comment")
                return
            }
        }
        if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV != "No" {
            if !(isMOYes || isMONo) {
                showAlert(message: "Please select issue Fixed or not")
                return
            } else if (MOTextView?.text.isEmpty ?? false) {
                showAlert(message: "Please enter MO comment")
                return
            }
        }
        
        if pendingMaintenanceData?.status == "Pending by OV" {
            if !(isOVYes || isOVNo) {
                showAlert(message: "Please select issue Fixed or not")
                return
            } else if (OVTextView?.text.isEmpty ?? false) {
                showAlert(message: "Please enter OV comment")
                return
            }
        }
        
        if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV == "No" && pendingMaintenanceData?.isIssueFixedByMO == "No" {
            if !(isFinalYes || isFinalNo) {
                showAlert(message: "Please select issue Fixed or not")
                return
            }
            if finalTextView?.text.isEmpty ?? false {
                showAlert(message: "Please enter final comment")
                return
            }
        }
        if pendingMaintenanceData?.status == "Pending by AM" && isAMNo {
            status = "Pending by MO"
        } else if pendingMaintenanceData?.status == "Pending by AM" && isAMYes {
            status = "Closed Resolved"
        } else if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByAM == "No" && pendingMaintenanceData?.isIssueFixedByMO == "NA" && isMONo {
            status = "Pending by OV"
        } else if pendingMaintenanceData?.status == "Pending by MO" && isMOYes {
            status = "Closed Resolved"
        } else if pendingMaintenanceData?.status == "Pending by OV" && pendingMaintenanceData?.isIssueFixedByMO == "No" && isOVNo {
            status = "Pending by MO"
        } else if pendingMaintenanceData?.status == "Pending by OV" && isOVYes {
            status = "Closed Resolved"
        } else if pendingMaintenanceData?.status == "Pending by MO" && pendingMaintenanceData?.isIssueFixedByOV == "No" && pendingMaintenanceData?.isIssueFixedByMO == "No" {
            status = "Closed Resolved"
        }
        
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Are you sure you want to submit this case?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            let payload: [String: Any] = [
                "maintenance_id": self.pendingMaintenanceData?.id ?? "",
                "am_issue_fixed_yes": self.isAMYes,
                "am_issue_fixed_no": self.isAMNo,
                "am_remarks": self.AMTextView?.text ?? "",
                "mo_issue_fixed_yes": self.isMOYes,
                "mo_issue_fixed_no": self.isMONo,
                "mo_remarks": self.MOTextView?.text ?? "",
                "ov_issue_fixed_yes": self.isOVYes,
                "ov_issue_fixed_no": self.isOVNo,
                "ov_remarks": self.OVTextView?.text ?? "",
                "mcc_issue_fixed_yes": self.isFinalYes,
                "mcc_issue_fixed_no": self.isFinalNo,
                "mcc_remarks": self.finalTextView?.text ?? "",
                "m_status": status
            ]
            print(payload)
            self.maintenanceOperation.updateTicketFormaintenance(param: payload) { error, response, statusCode in
                if response != nil {
                    self.completionHandler(EMPTY)
                    SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
                    return
                }
            }
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func fixedActionByAm(_ sender: UIButton) {
        if sender.tag == 101 {
            isFixedByAM = !isFixedByAM
        } else {
            isNOFixedByAM = !isNOFixedByAM
        }
    }
    
    @IBAction func fixedActionByMO(_ sender: UIButton) {
        if sender.tag == 201 {
            isFixedByMO = !isFixedByMO
        } else {
            isNOFixedByMO = !isNOFixedByMO
        }
    }
    
    @IBAction func fixedActionByOV(_ sender: UIButton) {
        if sender.tag == 301 {
            isFixedByOV = !isFixedByOV
        } else {
            isNOFixedByOV = !isNOFixedByOV
        }
    }
    
    @IBAction func fixedActionByClosedCase(_ sender: UIButton) {
        if sender.tag == 401 {
            isFixedByClsedCaseBtn = !isFixedByClsedCaseBtn
        } else {
            isNOFixedByClosedCase = !isNOFixedByClosedCase
        }
    }
}

extension MaintenancePendingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMaintenance?.attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PendingCollectionCell", for: indexPath) as! PendingCollectionCell
        
        if let attachments = selectedMaintenance?.attachments, indexPath.item < attachments.count {
            let attachment = attachments[indexPath.item]
            
            // Get MIME Type from Base64 String
            if let base64String = attachment.base64Body, let mimeType = getMimeType(from: base64String) {
                
                if mimeType.hasPrefix("image/") {
                    decodeBase64ToImage(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else if mimeType == "video/mp4" {
                    decodeBase64ToVideoThumbnail(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else if mimeType == "application/pdf" {
                    decodeBase64ToPDFThumbnail(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else {
                    print("❌ Unsupported file type: \(mimeType)")
                }
                
            } else {
                print("❌ Could not determine file type for Base64 string.")
            }
        }
        
        return cell
    }
    
    func getMimeType(from base64String: String) -> String? {
        // Check for MIME type in prefix
        if let range = base64String.range(of: ";base64,") {
            let prefix = base64String[..<range.lowerBound]
            if let mimeType = prefix.split(separator: ":").last {
                return String(mimeType) // Extracted MIME type (if available)
            }
        }

        // Decode Base64 to Data
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        // Identify file type based on magic numbers
        let byteArray = [UInt8](data.prefix(4))
        
        if byteArray.starts(with: [0xFF, 0xD8, 0xFF]) {
            return "image/jpeg"
        } else if byteArray.starts(with: [0x89, 0x50, 0x4E, 0x47]) {
            return "image/png"
        } else if byteArray.starts(with: [0x25, 0x50, 0x44, 0x46]) {
            return "application/pdf"
        } else if byteArray.starts(with: [0x00, 0x00, 0x00, 0x18]) || byteArray.starts(with: [0x66, 0x74, 0x79, 0x70]) {
            return "video/mp4"
        }
        
        return nil // Unknown MIME type
    }
    
    func decodeBase64ToImage(base64String: String, imageView: UIImageView) {
        if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("❌ Error: Could not convert data to UIImage")
            }
        } else {
            print("❌ Error: Invalid Base64 string for image")
        }
    }
    
    func decodeBase64ToVideoThumbnail(base64String: String, imageView: UIImageView) {
        if let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".mp4")
            do {
                try videoData.write(to: tempURL)

                // Generate Thumbnail
                let asset = AVAsset(url: tempURL)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                let time = CMTime(seconds: 1, preferredTimescale: 60)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
                        let thumbnail = UIImage(cgImage: cgImage)
                        
                        DispatchQueue.main.async {
                            imageView.image = thumbnail
                            print("✅ Video thumbnail successfully set")
                        }
                    } catch {
                        print("❌ Error generating thumbnail: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("❌ Error: Failed to write video data - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for video")
        }
    }
    
    func decodeBase64ToPDFThumbnail(base64String: String, imageView: UIImageView) {
        if let pdfData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempDocument.pdf")
            do {
                try pdfData.write(to: tempURL)
                
                // Generate PDF Thumbnail
                if let document = CGPDFDocument(tempURL as CFURL),
                   let page = document.page(at: 1) {
                    let pdfSize = page.getBoxRect(.mediaBox).size
                    let renderer = UIGraphicsImageRenderer(size: pdfSize)
                    
                    let image = renderer.image { ctx in
                        ctx.cgContext.drawPDFPage(page)
                    }
                    
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    print("❌ Error: Failed to generate PDF thumbnail")
                }
            } catch {
                print("❌ Error: Failed to write PDF data - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for PDF")
        }
    }
    
    func decodeBase64ToVideo(base64String: String, videoView: UIView) {
        if let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempVideo.mp4")
            do {
                try videoData.write(to: tempURL)
                DispatchQueue.main.async {
                    let player = AVPlayer(url: tempURL)
                    let playerLayer = AVPlayerLayer(player: player)
                    playerLayer.frame = videoView.bounds
                    videoView.layer.addSublayer(playerLayer)
                    player.play()
                }
            } catch {
                print("❌ Error: Failed to write video data to file - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for video")
        }
    }
    
    func decodeBase64ToPDF(base64String: String, webView: WKWebView) {
        if let pdfData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            DispatchQueue.main.async {
                webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
            }
        } else {
            print("❌ Error: Invalid Base64 string for PDF")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attachments = selectedMaintenance?.attachments, indexPath.item < attachments.count else { return }
        let attachment = attachments[indexPath.item]
        
        guard let base64String = attachment.base64Body else {
            print("❌ Error: Missing base64 string")
            return
        }
        
        let fileName = attachment.name.lowercased()
        
        let storyboard = UIStoryboard(name: "Maintenance", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ImagePopUpVc") as? ImagePopUpVc {
            vc.base64String = base64String
            vc.fileType = fileName
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.present(vc, animated: false)
        }
    }
}

class PendingCollectionCell: UICollectionViewCell {
    @IBOutlet var imageVw: UIImageView?
}
