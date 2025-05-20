//
//  RedFlagPendingVC.swift
//  CFGApp
//
//  Created by Sakshi on 13/02/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class RedFlagPendingVC: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var vw: UIView?
    @IBOutlet var selectClinicTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectDoctorTxtFld: MDCOutlinedTextField?
    @IBOutlet var submitBtn: UIButton?
    @IBOutlet var submitStackView: UIStackView?
    @IBOutlet var topHeadingLbl: UILabel?
    @IBOutlet var caseNumberLbl: UILabel?
    @IBOutlet var createdDateLbl: UILabel?
    @IBOutlet var createdTimeLbl: UILabel?
    @IBOutlet var patientNameLbl: UILabel?
    @IBOutlet var clinicNameLbl: UILabel?
    @IBOutlet var healthCardLbl: UILabel?
    @IBOutlet var financeBalLbl: UILabel?
    @IBOutlet var typeOfSubsidyLbl: UILabel?
    @IBOutlet var frequencyLbl: UILabel?
    @IBOutlet var patientDetailVw: UIView?
    @IBOutlet var selectedConcernLbl: UILabel?
    @IBOutlet var clinicImg: UIImageView?
    @IBOutlet var doctorImg: UIImageView?
    @IBOutlet var wholeStackView: UIStackView?
    
    @IBOutlet var supervisorVw: UIView?
    @IBOutlet var yesSupervisorBtn: UIButton?
    @IBOutlet var noSupervisorBtn: UIButton?
    @IBOutlet var supervisorRemarklbl: UILabel?
    @IBOutlet var supervisorStackView: UIStackView?
    @IBOutlet var supervisorHeadinglbl: UILabel?
    @IBOutlet var supervisorConcernYesNoView: UIView?
    @IBOutlet var supervisorTextViewHeadinglbl: UILabel?
    @IBOutlet var supervisorDatelbl: UILabel?
    @IBOutlet var supervisorTextView: UITextView?
    @IBOutlet var supervisorTotalTxtCount: UILabel?
    @IBOutlet var supervisorTxtCount: UILabel?
    @IBOutlet var supervisorTextViewHeight: NSLayoutConstraint?
    @IBOutlet var supervisorTextViewStackView: UIStackView?
    
    @IBOutlet var clinicDoctorVw: UIView?
    @IBOutlet var yesClinicDoctorBtn: UIButton?
    @IBOutlet var noClinicDoctorBtn: UIButton?
    @IBOutlet var clinicDoctorRemarklbl: UILabel?
    @IBOutlet var clinicDoctorStackView: UIStackView?
    @IBOutlet var clinicDoctorHeadinglbl: UILabel?
    @IBOutlet var clinicDoctorConcernYesNoView: UIView?
    @IBOutlet var clinicDoctorTextViewHeadinglbl: UILabel?
    @IBOutlet var clinicDoctorDatelbl: UILabel?
    @IBOutlet var clinicDoctorTextView: UITextView?
    @IBOutlet var clinicDoctorTotalTxtCount: UILabel?
    @IBOutlet var clinicDoctorTxtCount: UILabel?
    @IBOutlet var clinicDoctorTextViewHeight: NSLayoutConstraint?
    @IBOutlet var clinicDoctorTextViewStackView: UIStackView?
    
    @IBOutlet var areaManagerHeadinglbl: UILabel?
    @IBOutlet var areaManagerStackView: UIStackView?
    @IBOutlet var areaManagerHeadingStackView: UIStackView?
    @IBOutlet var ifYesSelectedStackView: UIStackView?
    @IBOutlet var ifNoSelectedStackView: UIStackView?
    @IBOutlet var areaManagerTextViewHeadinglbl: UILabel?
    @IBOutlet var areaManagerTextView: UITextView?
    @IBOutlet var areaManagerTotalTxtCount: UILabel?
    @IBOutlet var areaManagerTxtCount: UILabel?
    @IBOutlet var areaManagerTextViewHeight: NSLayoutConstraint?
    @IBOutlet var selectClinicStackView: UIStackView?
    @IBOutlet var selectDoctorStackView: UIStackView?
    @IBOutlet var remarksStackView: UIStackView?
    @IBOutlet var areaManagerWholetextViewStackView: UIStackView?
    
    @IBOutlet var yesTransferToOtherBtn: UIButton?
    @IBOutlet var yesRetentionBtn: UIButton?
    @IBOutlet var yesOfferDTBtn: UIButton?
    @IBOutlet var yesOfferSWTBtn: UIButton?
    @IBOutlet var yesConsultantSeniorBtn: UIButton?
    @IBOutlet var yesConsultantTCMBtn: UIButton?
    
    @IBOutlet var yesFinishUpSubsidyPlanBtn: UIButton?
    @IBOutlet var yesTransferBalanceToFamilyBtn: UIButton?
    @IBOutlet var yesExtendSubsidyPlanBtn: UIButton?
    @IBOutlet var yesRefundBtn: UIButton?
    @IBOutlet weak var textLabelBottomConstraint: NSLayoutConstraint?
    
    var pickerView = UIPickerView()
    var clinicId = ""
    var doctorId = ""
    var clinicPickerData = [String]()
    var currentClinicPickerData: [(name: String, id: String)] = []
    var currentDoctorPickerData: [(name: String, id: String)] = []
    var filteredClinicNames: [String] = []
    var currentPickerData: [String] = []
    
    let maxCharacterLimit = 131072
    var pendingData: PendingRedFlagModel?
    var customDateFormatter = CustomDateFormatter()
    var isSupervisorYes: Bool = false
    var isMClinicDoctorYes: Bool = false
    var isFinishUpSubsidyPlan: Bool = false
    var isTransferBalanceToFamily: Bool = false
    var isExtendSubsidyPlan: Bool = false
    var isRefund: Bool = false
    
    var isTransferToOther: Bool = false
    var isRetention: Bool = false
    var isOfferDT: Bool = false
    var isOfferSWT: Bool = false
    var isConsultantSenior: Bool = false
    var isConsultantTCM: Bool = false
    
    var isSupervisorNo: Bool = false
    var isClinicDoctorNo: Bool = false
    var selectedYesContent = ""
    var selectedNoContent = ""
    var redFlagService = RedFlagService()
    
    var isFixedBySupervisor: Bool = false {
        didSet {
            if isFixedBySupervisor {
                isSupervisorYes = true
                isSupervisorNo = false
                yesSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isSupervisorYes = false
                yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedBySupervisor: Bool = false {
        didSet {
            if isNOFixedBySupervisor {
                isSupervisorYes = false
                isSupervisorNo = true
                noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isSupervisorNo = false
                noSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isFixedByClinicDoctor: Bool = false {
        didSet {
            if isFixedByClinicDoctor {
                isMClinicDoctorYes = true
                isClinicDoctorNo = false
                yesClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isMClinicDoctorYes = false
                yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNOFixedByClinicDoctor: Bool = false {
        didSet {
            if isFixedByClinicDoctor {
                isClinicDoctorNo = true
                isMClinicDoctorYes = false
                noClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isClinicDoctorNo = false
                noClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
//        supervisorTextView?.isScrollEnabled = false
//        clinicDoctorTextView?.isScrollEnabled = false
//        areaManagerTextView?.isScrollEnabled = false
//        supervisorTextView?.delegate = self
//        clinicDoctorTextView?.delegate = self
//        areaManagerTextView?.delegate = self
        addTapGestureToDismissKeyboard()
        supervisorTextView?.delegate = self
        clinicDoctorTextView?.delegate = self
        areaManagerTextView?.delegate = self
        supervisorTextView?.isScrollEnabled = true
        clinicDoctorTextView?.isScrollEnabled = true
        areaManagerTextView?.isScrollEnabled = true
    }
    
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        return toolbar
    }

    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func initialUI() {
        Utility.getAllClinic(outerClosure: { success in
        })
        ifYesSelectedStackView?.isHidden = true
        ifNoSelectedStackView?.isHidden = true
        selectClinicStackView?.isHidden = true
        selectDoctorStackView?.isHidden = true
        clinicImg?.isHidden = true
        doctorImg?.isHidden = true
        selectClinicTxtFld?.label.text = "Select Clinic"
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal)
        selectClinicTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectDoctorTxtFld?.label.text = "Select Doctor"
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectDoctorTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        submitBtn?.layer.cornerRadius = 10.0
        submitBtn?.layer.masksToBounds = true
        patientDetailVw?.layer.masksToBounds = false
        patientDetailVw?.layer.cornerRadius = 8
        patientDetailVw?.dropShadowTableView()
        supervisorConcernYesNoView?.layer.masksToBounds = false
        supervisorConcernYesNoView?.layer.cornerRadius = 8
        supervisorConcernYesNoView?.borderWidth = 0.5
        supervisorConcernYesNoView?.borderColor = .gray
        clinicDoctorConcernYesNoView?.layer.masksToBounds = false
        clinicDoctorConcernYesNoView?.layer.cornerRadius = 8
        clinicDoctorConcernYesNoView?.borderWidth = 0.5
        clinicDoctorConcernYesNoView?.borderColor = .gray
        ifYesSelectedStackView?.layer.masksToBounds = false
        ifYesSelectedStackView?.layer.cornerRadius = 8
        ifYesSelectedStackView?.borderWidth = 0.5
        ifYesSelectedStackView?.borderColor = .gray
        ifNoSelectedStackView?.layer.masksToBounds = false
        ifNoSelectedStackView?.layer.cornerRadius = 8
        ifNoSelectedStackView?.borderWidth = 0.5
        ifNoSelectedStackView?.borderColor = .gray
        supervisorTextView?.layer.masksToBounds = false
        supervisorTextView?.layer.cornerRadius = 8
        supervisorTextView?.borderWidth = 0.5
        supervisorTextView?.borderColor = .gray
        clinicDoctorTextView?.layer.masksToBounds = false
        clinicDoctorTextView?.layer.cornerRadius = 8
        clinicDoctorTextView?.borderWidth = 0.5
        clinicDoctorTextView?.borderColor = .gray
        ifNoSelectedStackView?.layer.masksToBounds = false
        ifNoSelectedStackView?.layer.cornerRadius = 8
        ifNoSelectedStackView?.borderWidth = 0.5
        ifNoSelectedStackView?.borderColor = .gray
        ifYesSelectedStackView?.layer.masksToBounds = false
        ifYesSelectedStackView?.layer.cornerRadius = 8
        ifYesSelectedStackView?.borderWidth = 0.5
        ifYesSelectedStackView?.borderColor = .gray
        
        caseNumberLbl?.text = pendingData?.name
        createdDateLbl?.text =  customDateFormatter.getDateForCreatedAt(dateString: pendingData?.createdDate ?? "")
        createdTimeLbl?.text =  customDateFormatter.getDateForCreatedAtTime(dateString: pendingData?.createdDate ?? "")
        clinicNameLbl?.text = pendingData?.clinic?.name
        patientNameLbl?.text = pendingData?.patient?.name
        healthCardLbl?.text = pendingData?.patientHealthCard?.name
        financeBalLbl?.text = (pendingData?.financialBalance == "NA") ? "" : "$\(pendingData?.financialBalance ?? "$0.0")"
        typeOfSubsidyLbl?.text = pendingData?.typeOfSubsidyPlan
        frequencyLbl?.text = (pendingData?.frequency == "NA") ? "" : pendingData?.frequency
        selectedConcernLbl?.text = pendingData?.concern
        areaManagerTextView?.layer.masksToBounds = false
        areaManagerTextView?.layer.cornerRadius = 8
        areaManagerTextView?.borderWidth = 0.5
        areaManagerTextView?.borderColor = .gray
        var isAMLogin: Bool = false
        if Defaults.userRole == "AM" {
            if pendingData?.status == "Pending Review with AM" {
                isAMLogin = true
            }
        } else {
            isAMLogin = false
        }
        let statusText = pendingData?.status
        if let userRoleEnum = StatusItems(rawValue: Defaults.userRole ?? "") {
            let specificRoles: [StatusItems] = [.clinicFDSupervisorsRedFlag, .aMRedFlag, .doctor, .admin]
            if ((specificRoles.contains(userRoleEnum) && userRoleEnum.getStatusItemsText() == statusText) || userRoleEnum == .admin
                ||
                ((pendingData?.status == "Pending Review with Clinic Supervisor/Manager") && userRoleEnum == .clinicFDSupervisorsRedFlag)
                ||
                ((pendingData?.status == "Pending Review with Clinic Doctor") && userRoleEnum == .doctor)
                ||
                ((pendingData?.status == "Pending Review with AM") && userRoleEnum == .aMRedFlag)) {
                print(pendingData)
                if statusText == userRoleEnum.getStatusItemsText() || isAMLogin || userRoleEnum == .admin {
                    if statusText == "Pending Review with Clinic Supervisor/Manager" {
                        noSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        clinicDoctorStackView?.isHidden = true
                        topHeadingLbl?.text = "Clinic Supervisor/Manager Review"
                        ifNoSelectedStackView?.isHidden = true
                        ifYesSelectedStackView?.isHidden = true
                        areaManagerStackView?.isHidden = true
                        supervisorHeadinglbl?.text = "Supervisor/Manager"
                        clinicDoctorHeadinglbl?.text = ""
                        clinicDoctorTextViewHeadinglbl?.text = ""
                        clinicDoctorTxtCount?.text = ""
                        clinicDoctorTotalTxtCount?.text = ""
                        areaManagerHeadinglbl?.text = ""
                        areaManagerTextViewHeadinglbl?.text = ""
                        areaManagerTxtCount?.text = ""
                        areaManagerTotalTxtCount?.text = ""
                        supervisorRemarklbl?.text = ""
                        areaManagerWholetextViewStackView?.isHidden = true
                        return
                    }
                    
                    if "\(pendingData?.status ?? "")" == "Pending Review with Clinic Doctor" && "\(pendingData?.isConcernResolved ?? "No")" == "No" {
                        topHeadingLbl?.text = "Clinic Doctor Review"
                        supervisorHeadinglbl?.text = "Supervisor/Manager"
                        supervisorTextViewHeight?.constant = 0
                        supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
                        clinicDoctorStackView?.isHidden = false
                        noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        noSupervisorBtn?.isEnabled = false
                        yesSupervisorBtn?.isEnabled = false
                        supervisorTxtCount?.text = ""
                        supervisorTotalTxtCount?.text = ""
                        supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                        
                        clinicDoctorStackView?.isHidden = false
                        clinicDoctorHeadinglbl?.text = "Clinic Doctor"
                        clinicDoctorRemarklbl?.text = ""
                        clinicDoctorTxtCount?.text = "0"
                        clinicDoctorTotalTxtCount?.text = "/131072"
                        noClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        
                        areaManagerHeadinglbl?.text = ""
                        areaManagerStackView?.isHidden = true
                        areaManagerWholetextViewStackView?.isHidden = true
                        return
                    }
                    
                    if "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "No" {
                        topHeadingLbl?.text = "Area Manager Review"
                        supervisorHeadinglbl?.text = "Supervisor/Manager"
                        supervisorTextViewHeight?.constant = 0
                        supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
                        clinicDoctorStackView?.isHidden = false
                        noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        noSupervisorBtn?.isEnabled = false
                        yesSupervisorBtn?.isEnabled = false
                        supervisorTxtCount?.text = ""
                        supervisorTotalTxtCount?.text = ""
                        supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                        
                        clinicDoctorHeadinglbl?.text = "Clinic Doctor"
                        clinicDoctorTextViewHeight?.constant = 0
                        clinicDoctorRemarklbl?.text = pendingData?.clinicDoctorRemarks
                        clinicDoctorStackView?.isHidden = false
                        noClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        noClinicDoctorBtn?.isEnabled = false
                        yesClinicDoctorBtn?.isEnabled = false
                        ifNoSelectedStackView?.isHidden = false
                        clinicDoctorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                        clinicDoctorTxtCount?.text = ""
                        clinicDoctorTotalTxtCount?.text = ""
                        
                        areaManagerHeadinglbl?.text = "Area Manager"
                        areaManagerStackView?.isHidden = false
                        areaManagerWholetextViewStackView?.isHidden = false
                    }
                    
                    if "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "Yes" {
                        topHeadingLbl?.text = "Area Manager Review"
                        supervisorHeadinglbl?.text = "Supervisor/Manager"
                        supervisorTextViewHeight?.constant = 0
                        supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
                        clinicDoctorStackView?.isHidden = false
                        noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        noSupervisorBtn?.isEnabled = false
                        yesSupervisorBtn?.isEnabled = false
                        supervisorTxtCount?.text = ""
                        supervisorTotalTxtCount?.text = ""
                        supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                        clinicDoctorHeadinglbl?.text = "Clinic Doctor"
                        clinicDoctorTextViewHeight?.constant = 0
                        clinicDoctorRemarklbl?.text = pendingData?.clinicDoctorRemarks
                        clinicDoctorStackView?.isHidden = false
                        noClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        yesClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        noClinicDoctorBtn?.isEnabled = false
                        yesClinicDoctorBtn?.isEnabled = false
                        ifYesSelectedStackView?.isHidden = false
                        clinicDoctorTxtCount?.text = ""
                        clinicDoctorTotalTxtCount?.text = ""
                        clinicDoctorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                        areaManagerHeadinglbl?.text = "Area Manager"
                        areaManagerStackView?.isHidden = false
                        areaManagerWholetextViewStackView?.isHidden = false
                    }
                }
            }
            else if (statusText == "Pending Review with Clinic Supervisor/Manager") {
                wholeStackView?.isHidden = true
                supervisorStackView?.isHidden = true
                clinicDoctorStackView?.isHidden = true
                ifNoSelectedStackView?.isHidden = true
                ifYesSelectedStackView?.isHidden = true
                areaManagerStackView?.isHidden = true
                let checkInalert = UIAlertController(
                    title: "Info",
                    message: "You do not have permission to edit this ticket.",
                    preferredStyle: .alert
                )
                self.present(checkInalert, animated: true, completion: nil)
                checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    print("Cancel tapped")
                }))
            }
            else if (statusText == "Pending Review with Clinic Doctor") {
                topHeadingLbl?.text = "Clinic Doctor Review"
                supervisorHeadinglbl?.text = "Supervisor/Manager"
                supervisorTextViewHeight?.constant = 0
                supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
                noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noSupervisorBtn?.isEnabled = false
                yesSupervisorBtn?.isEnabled = false
                supervisorTxtCount?.text = ""
                supervisorTotalTxtCount?.text = ""
                supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                
                clinicDoctorStackView?.isHidden = true
                ifNoSelectedStackView?.isHidden = true
                ifYesSelectedStackView?.isHidden = true
                areaManagerStackView?.isHidden = true
                submitStackView?.isHidden = true
                areaManagerWholetextViewStackView?.isHidden = true
                return
            } else if (statusText == "Pending Review with AM") {
                topHeadingLbl?.text = "Area Manager Review"
                supervisorHeadinglbl?.text = "Supervisor/Manager"
                supervisorTextViewHeight?.constant = 0
                supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
                noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noSupervisorBtn?.isEnabled = false
                yesSupervisorBtn?.isEnabled = false
                supervisorTxtCount?.text = ""
                supervisorTotalTxtCount?.text = ""
                supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                
                clinicDoctorTextViewHeight?.constant = 0
                clinicDoctorRemarklbl?.text = pendingData?.clinicDoctorRemarks
                clinicDoctorStackView?.isHidden = false
                yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noClinicDoctorBtn?.isEnabled = false
                yesClinicDoctorBtn?.isEnabled = false
                ifYesSelectedStackView?.isHidden = false
                clinicDoctorTxtCount?.text = ""
                clinicDoctorTotalTxtCount?.text = ""
                clinicDoctorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
                
                ifNoSelectedStackView?.isHidden = true
                ifYesSelectedStackView?.isHidden = true
                areaManagerStackView?.isHidden = true
                areaManagerWholetextViewStackView?.isHidden = true
                submitStackView?.isHidden = true
                return
            }
        }
        
        
        
        
        
        
        //        else if (statusText == "Pending Review with Clinic Doctor") || (statusText == "Pending Review with AM") && userRoleEnum?.getStatusItemsText() == "Pending Review with Clinic Supervisor/Manager" {
        //            topHeadingLbl?.text = "Clinic Doctor Review"
        //            supervisorHeadinglbl?.text = "Supervisor/Manager"
        //            supervisorTextViewHeight?.constant = 0
        //            supervisorRemarklbl?.text = pendingData?.supervisorManagerRemarks
        //            noSupervisorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //            yesSupervisorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //            noSupervisorBtn?.isEnabled = false
        //            yesSupervisorBtn?.isEnabled = false
        //            supervisorTxtCount?.text = ""
        //            supervisorTotalTxtCount?.text = ""
        //            supervisorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
        //
        //            clinicDoctorStackView?.isHidden = true
        //
        //            areaManagerStackView?.isHidden = true
        //            areaManagerHeadinglbl?.text = ""
        //            areaManagerStackView?.isHidden = true
        //            areaManagerWholetextViewStackView?.isHidden = true
        //
        //            submitStackView?.isHidden = true
        //        } else if statusText == "Pending Review with AM" && userRoleEnum?.getStatusItemsText() == "Pending Review with Clinic Doctor" {
        //            topHeadingLbl?.text = "Area Manager Review"
        //            clinicDoctorHeadinglbl?.text = "Clinic Doctor"
        //            clinicDoctorTextViewHeight?.constant = 0
        //            clinicDoctorRemarklbl?.text = pendingData?.clinicDoctorRemarks
        //            supervisorStackView?.isHidden = true
        //            noClinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
        //            yesClinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        //            noClinicDoctorBtn?.isEnabled = false
        //            yesClinicDoctorBtn?.isEnabled = false
        //            ifNoSelectedStackView?.isHidden = false
        //            clinicDoctorDatelbl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingData?.clinicSupervisorSubmittedAt ?? "")
        //            clinicDoctorTxtCount?.text = ""
        //            clinicDoctorTotalTxtCount?.text = ""
        //
        //            ifNoSelectedStackView?.isHidden = true
        //            ifYesSelectedStackView?.isHidden = true
        //            areaManagerStackView?.isHidden = true
        //            areaManagerWholetextViewStackView?.isHidden = true
        //
        //            submitStackView?.isHidden = true
        //        }
        
        
        else {
            wholeStackView?.isHidden = true
            supervisorStackView?.isHidden = true
            clinicDoctorStackView?.isHidden = true
            ifNoSelectedStackView?.isHidden = true
            ifYesSelectedStackView?.isHidden = true
            areaManagerStackView?.isHidden = true
            let checkInalert = UIAlertController(
                title: "Info",
                message: "You do not have permission to edit this ticket.",
                preferredStyle: .alert
            )
            self.present(checkInalert, animated: true, completion: nil)
            checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                print("Cancel tapped")
            }))
        }
        selectDoctorTxtFld?.inputView = pickerView
        selectClinicTxtFld?.inputView = pickerView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        selectDoctorTxtFld?.inputAccessoryView = toolbar
        selectClinicTxtFld?.inputAccessoryView = toolbar
        setupPickerView()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentTextCount = textView.text.count
        if textView == supervisorTextView {
            supervisorTxtCount?.text = "\(currentTextCount)"
        } else if textView == clinicDoctorTextView {
            clinicDoctorTxtCount?.text = "\(currentTextCount)"
        } else if textView == areaManagerTextView {
            areaManagerTxtCount?.text = "\(currentTextCount)"
        }
        adjustTextViewHeight(textView)
    }

    func adjustTextViewHeight(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentPickerData[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.getAllDoctor(clinicID: clinicId, outerClosure: { success in
        })
        if textField == selectDoctorTxtFld {
            if !GlobalData.allDoctorModel.isEmpty {
                currentDoctorPickerData = GlobalData.allDoctorModel.compactMap { doctor in
                    if let name = doctor.Name, let id = doctor.Id {
                        return (name, id)
                    }
                    return nil
                }
                currentPickerData = currentDoctorPickerData.map { $0.name }
                print("Picker Data: \(currentPickerData)")
                pickerView.reloadAllComponents()
            }
        } else if textField == selectClinicTxtFld {
            if !GlobalData.allClinicModel.isEmpty {
                currentClinicPickerData = GlobalData.allClinicModel.compactMap { clinic in
                    if let name = clinic.Name, let id = clinic.Id {
                        return (name, id)
                    }
                    return nil
                }
                currentPickerData = currentClinicPickerData.map { $0.name }
                print("Picker Data: \(currentPickerData)")
                pickerView.reloadAllComponents()
            } else {
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectDoctorTxtFld?.isFirstResponder == true {
            let selectedDoctor = currentDoctorPickerData[row]
            selectDoctorTxtFld?.text = selectedDoctor.name
            doctorId = selectedDoctor.id
            print("Selected doctorId ID: \(doctorId)")
        } else if selectClinicTxtFld?.isFirstResponder == true {
            let selectedClinic = currentClinicPickerData[row]
            selectClinicTxtFld?.text = selectedClinic.name
            clinicId = selectedClinic.id
            
            print("Selected Clinic ID: \(clinicId)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = currentPickerData[row]
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    @IBAction func fixedActionBySupervisor(_ sender: UIButton) {
        if sender.tag == 1 {
            isFixedBySupervisor = !isFixedBySupervisor
        } else {
            isNOFixedBySupervisor = !isNOFixedBySupervisor
        }
    }
    
    @IBAction func fixedActionByClinicDoctor(_ sender: UIButton) {
        if sender.tag == 3 {
            isFixedByClinicDoctor = !isFixedByClinicDoctor
        } else {
            isNOFixedByClinicDoctor = !isNOFixedByClinicDoctor
        }
    }
    
    @IBAction func YESSectionAction(_ sender: UIButton) {
        isTransferToOther = false
        isRetention = false
        isOfferDT = false
        isOfferSWT = false
        isConsultantSenior = false
        isConsultantTCM = false
        yesTransferToOtherBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesRetentionBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesOfferDTBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesOfferSWTBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesConsultantSeniorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesConsultantTCMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        selectClinicStackView?.isHidden = true
        selectDoctorStackView?.isHidden = true
        clinicImg?.isHidden = true
        doctorImg?.isHidden = true
        selectedYesContent = ""
        switch sender.tag {
        case 201:
            selectedYesContent = "Transfer to other Dr in other Clinic."
            yesTransferToOtherBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isTransferToOther = true
            clinicImg?.isHidden = false
            doctorImg?.isHidden = false
            selectClinicStackView?.isHidden = false
            selectDoctorStackView?.isHidden = false
        case 202:
            selectedYesContent = "Retention at current Clinic"
            yesRetentionBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isRetention = true
            
        case 203:
            selectedYesContent = "Offer DT Services"
            yesOfferDTBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isOfferDT = true
            
        case 204:
            selectedYesContent = "Offer SWT / SIT Services"
            yesOfferSWTBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isOfferSWT = true
           
        case 205:
            selectedYesContent = "Consult Senior Consultant"
            yesConsultantSeniorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isConsultantSenior = true
            clinicImg?.isHidden = false
            doctorImg?.isHidden = false
            selectClinicStackView?.isHidden = false
            selectDoctorStackView?.isHidden = false
        case 206:
            selectedYesContent = "Consult TCM services"
            yesConsultantTCMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isConsultantTCM = true
            clinicImg?.isHidden = false
            doctorImg?.isHidden = false
            selectClinicStackView?.isHidden = false
            selectDoctorStackView?.isHidden = false
        default:
            return
        }
    }
    
    @IBAction func NoSectionAction(_ sender: UIButton) {
        yesFinishUpSubsidyPlanBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesTransferBalanceToFamilyBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesExtendSubsidyPlanBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        yesRefundBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        isFinishUpSubsidyPlan = false
        isTransferBalanceToFamily = false
        isExtendSubsidyPlan = false
        isRefund = false
        selectedNoContent = ""
        switch sender.tag {
        case 101:
            selectedNoContent = "Finish up Subsidy  Plan"
            yesFinishUpSubsidyPlanBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isFinishUpSubsidyPlan = true
        case 102:
            selectedNoContent = "Transfer balance to family / friends"
            yesTransferBalanceToFamilyBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isTransferBalanceToFamily = true
        case 103:
            selectedNoContent = "Extend Subsidy Plan validity period"
            yesExtendSubsidyPlanBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isExtendSubsidyPlan = true
        case 104:
            selectedNoContent = "Refund"
            yesRefundBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            isRefund = true
        default:
            return
        }
    }
    
    func payloadForSupervisor () {
        var concernResolve: Bool?
        if isFixedBySupervisor {
            concernResolve = true
        } else if isNOFixedBySupervisor {
            concernResolve = false
        } else {
            showAlert(message: "Please select is the concern resolved option.")
            return
        }
        
        if (supervisorTextView?.text.isEmpty ?? false) {
            showAlert(message: "Please enter supervisor comment")
            return
        }
        
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Are you sure you want to submit this case?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            let payload: [String: Any] = [
                "redflagid": self.pendingData?.id ?? "",
                "concern_resolve": concernResolve ?? false,
                "supervisor_remark": self.supervisorTextView?.text ?? "",
                "main_status": self.isSupervisorYes ? "Closed" : "Pending Review with Clinic Doctor",
            ]
            self.redFlagService.updateForRedFlag(redFlagId: self.pendingData?.id ?? "", payload: payload, outerClosure: { error, response, statusCode in
                if error == nil {
                    SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
                    return
                }
            })
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    func payloadForClinicDoctor () {
        var concernResolve: Bool?
        if isMClinicDoctorYes {
            concernResolve = true
        } else if isClinicDoctorNo {
            concernResolve = false
        } else {
            showAlert(message: "Please select Patient Retention option.")
            return
        }
        
        if (clinicDoctorTextView?.text.isEmpty ?? false) {
            showAlert(message: "Please enter Clinic Doctor comment")
            return
        }
        
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Are you sure you want to submit this case?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            let payload: [String: Any] = [
                "redflagid": self.pendingData?.id ?? "",
                "cd_patient_retention": concernResolve ?? false,
                "cd_remark": self.clinicDoctorTextView?.text ?? "",
                "main_status": "Pending Review with AM",
            ]
            print(payload)
            self.redFlagService.updateForRedFlag(redFlagId: self.pendingData?.id ?? "", payload: payload, outerClosure: { error, response, statusCode in
                if error == nil {
                    SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
                    return
                }
            })
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func payloadForAreaManager () {
        if "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "No" {
            if !(isFinishUpSubsidyPlan || isTransferBalanceToFamily || isExtendSubsidyPlan || isRefund) {
                showAlert(message: "Please select at least one solution")
                return
            }
        }
        if "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "Yes" {
            if !(isTransferToOther || isRetention || isOfferDT || isOfferSWT || isConsultantSenior || isConsultantTCM) {
                showAlert(message: "Please select at least one solution")
                return
            } else if isTransferToOther {
                if (clinicId.isEmpty) {
                    showAlert(message: "Please select clinic name")
                    return
                } else if (doctorId.isEmpty) {
                    showAlert(message: "Please select doctor name")
                    return
                }
            } else if isConsultantSenior {
                if (clinicId.isEmpty) {
                    showAlert(message: "Please select clinic name")
                    return
                } else if (doctorId.isEmpty) {
                    showAlert(message: "Please select doctor name")
                    return
                }
            } else if isConsultantTCM {
                if (clinicId.isEmpty) {
                    showAlert(message: "Please select clinic name")
                    return
                } else if (doctorId.isEmpty) {
                    showAlert(message: "Please select doctor name")
                    return
                }
            }
        }
        
        if (areaManagerTextView?.text.isEmpty ?? false) {
            showAlert(message: "Please enter Area manager comment")
            return
        }
        
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Are you sure you want to submit this case?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            let payload: [String: Any] = [
                "redflagid": self.pendingData?.id ?? "",
                "am_patient_retention": self.isMClinicDoctorYes ? true : false,
                "trans_to_other_dr_in_other_clinic": self.isTransferToOther,
                "offre_dt_services": self.isOfferDT,
                "offer_swt_sit_services": self.isOfferSWT,
                "consultant_sr_consiltant": self.isConsultantSenior,
                "consultant_tcm_services": self.isConsultantTCM,
                "retain_in_current_clinic": false,
                "finish_up_subsidy_plan": self.isFinishUpSubsidyPlan,
                "trans_bal_to_family_friends": self.isTransferBalanceToFamily,
                "ext_subsidy_plan_val_period": self.isExtendSubsidyPlan,
                "refund": self.isRefund,
                "clinic_id": self.clinicId,
                "doctor_id": self.doctorId,
                "am_remark": self.areaManagerTextView?.text ?? "",
                "main_status": "Closed"
            ]
            self.redFlagService.updateForRedFlag(redFlagId: self.pendingData?.id ?? "", payload: payload, outerClosure: { error, response, statusCode in
                if error == nil {
                    SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
                    return
                }
            })
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func submitFunc() {
        if "\(pendingData?.status ?? "")" == "Pending Review with Clinic Supervisor/Manager" {
            payloadForSupervisor()
        } else if "\(pendingData?.status ?? "")" == "Pending Review with Clinic Doctor" && "\(pendingData?.isConcernResolved ?? "No")" == "No" {
            payloadForClinicDoctor()
        } else if "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "Yes" || "\(pendingData?.status ?? "")" == "Pending Review with AM" && "\(pendingData?.patientRetention ?? "No")" == "No" {
            payloadForAreaManager()
        }
        
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction() {
        submitFunc()
    }
}
