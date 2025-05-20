//
//  SubsidyTerminationForm.swift
//  CFGApp
//
//  Created by Sakshi on 07/01/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SubsidyTerminationForm: UIViewController {
    @IBOutlet var patientNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var bankNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var bankAccNumberTxtFld: MDCOutlinedTextField?
    @IBOutlet var contactNoTxtFld: MDCOutlinedTextField?
    @IBOutlet var dateAccTxtFld: MDCOutlinedTextField?
    @IBOutlet var AccNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var dateTxtFld: MDCOutlinedTextField?
    @IBOutlet var passportNoTxtFld: MDCOutlinedTextField?
    @IBOutlet var contactNumberTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectClinicTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectDoctorTxtFld: MDCOutlinedTextField?
    @IBOutlet var mentionReasonTxtFld: MDCOutlinedTextField?
    @IBOutlet var otherReasonTxtFld: MDCOutlinedTextField?
    @IBOutlet var advisedTxtFld: MDCOutlinedTextField?
    @IBOutlet var relocateAdress: UIStackView?
    @IBOutlet var relocateAddressTxtFld: UITextField?
    @IBOutlet var isAdvisedBtn: UIButton?
    @IBOutlet var reasonForTeminationLbl: UILabel?
    @IBOutlet var reloactingBtn: UIButton?
    @IBOutlet var clinicLocationBtn: UIButton?
    @IBOutlet var clinicOperatingBtn: UIButton?
    @IBOutlet var subsidyPlanBtn: UIButton?
    @IBOutlet var problemResolvedBtn: UIButton?
    @IBOutlet var problemNotResolvedBtn: UIButton?
    @IBOutlet var issueInQualityBtn: UIButton?
    @IBOutlet var issueWithDoctorBtn: UIButton?
    @IBOutlet var issueWithStaffBtn: UIButton?
    @IBOutlet var otherBtn: UIButton?
    @IBOutlet var advisedTotalTxtCount: UILabel?
    @IBOutlet var advisedTxtCount: UILabel?
    @IBOutlet var otherTotalTxtCount: UILabel?
    @IBOutlet var otherTxtCount: UILabel?
    @IBOutlet var mainTotalTxtCount: UILabel?
    @IBOutlet var mainTxtCount: UILabel?
    @IBOutlet var submitBtn: UIButton?
    var refundWebService = RefundWebService()
    var datePicker = UIDatePicker()
    var patientId = ""
    var clientId = ""
    var doctorId = ""
    var validityType = ""
    var selectedSubsidyPlans: [PatientDetailModel.SubsidyPlan] = []
    let maxCharacterLimit = 255
    var isAdvised: Bool = false {
        didSet {
            if isAdvised {
                isAdvisedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                advisedHeightConstraint?.constant = 56
                advisedTxtFld?.isHidden = false
                advisedTotalTxtCount?.isHidden = false
                advisedTxtCount?.isHidden = false
            } else {
                isAdvisedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                advisedHeightConstraint?.constant = 0
                advisedTxtFld?.isHidden = true
                advisedTotalTxtCount?.isHidden = true
                advisedTxtCount?.isHidden = true
            }
        }
    }
    var isReloacting: Bool = false {
        didSet {
            if isReloacting {
                reloactingBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                relocateAdress?.isHidden = false
                reloacteAdressHeightConstraint?.constant = 40
            } else {
                reloactingBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                relocateAdress?.isHidden = true
                reloacteAdressHeightConstraint?.constant = 0
            }
        }
    }
    var isClinicLocation: Bool = false {
        didSet {
            if isClinicLocation {
                clinicLocationBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                clinicLocationBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isClinicOperating: Bool = false {
        didSet {
            if isClinicOperating {
                clinicOperatingBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                clinicOperatingBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isSubsidyPlan: Bool = false {
        didSet {
            if isSubsidyPlan {
                subsidyPlanBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                subsidyPlanBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isProblemResolved: Bool = false {
        didSet {
            if isProblemResolved {
                problemResolvedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                problemResolvedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isProblemNotResolved: Bool = false {
        didSet {
            if isProblemNotResolved {
                problemNotResolvedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                problemNotResolvedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isIssueInQuality: Bool = false {
        didSet {
            if isIssueInQuality {
                issueInQualityBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                issueInQualityBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isIssueWithDoctor: Bool = false {
        didSet {
            if isIssueWithDoctor {
                issueWithDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                issueWithDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isIssueWithStaff: Bool = false {
        didSet {
            if isIssueWithStaff {
                issueWithStaffBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                issueWithStaffBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isOther: Bool = false {
        didSet {
            if isOther {
                otherBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                textFieldHeightConstraint?.constant = 56
                otherReasonTxtFld?.isHidden = false
                otherTotalTxtCount?.isHidden = false
                otherTxtCount?.isHidden = false
            } else {
                otherBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                textFieldHeightConstraint?.constant = 0
                otherReasonTxtFld?.isHidden = true
                otherTotalTxtCount?.isHidden = true
                otherTxtCount?.isHidden = true
            }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBOutlet var textFieldHeightConstraint: NSLayoutConstraint?
    @IBOutlet var advisedHeightConstraint: NSLayoutConstraint?
    @IBOutlet var reloacteAdressHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn?.layer.masksToBounds = false
        submitBtn?.layer.cornerRadius = 8
        advisedTotalTxtCount?.isHidden = true
        advisedTxtCount?.isHidden = true
        otherTotalTxtCount?.isHidden = true
        otherTxtCount?.isHidden = true
        mentionReasonTxtFld?.delegate = self
        otherReasonTxtFld?.delegate = self
        advisedTxtFld?.delegate = self
        reloacteAdressHeightConstraint?.constant = 0
        advisedHeightConstraint?.constant = 0
        advisedTxtFld?.isHidden = true
        setUpInitialUI()
        textFieldHeightConstraint = otherReasonTxtFld?.heightAnchor.constraint(equalToConstant: 0)
        textFieldHeightConstraint?.isActive = true
        otherReasonTxtFld?.isHidden = true
        self.view.layoutIfNeeded()
        addTapGestureToDismissKeyboard()
    }
    
    func validateFields() -> Bool {
        var isValid = true
        if let text = patientNameTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            patientNameTxtFld?.leadingAssistiveLabel.text = "Patient name is required."
            patientNameTxtFld?.leadingAssistiveLabel.textColor = .red
            patientNameTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            patientNameTxtFld?.leadingAssistiveLabel.text = ""
            patientNameTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = dateTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            dateTxtFld?.leadingAssistiveLabel.text = "Date is required."
            dateTxtFld?.leadingAssistiveLabel.textColor = .red
            dateTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            dateTxtFld?.leadingAssistiveLabel.text = ""
            dateTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = passportNoTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            passportNoTxtFld?.leadingAssistiveLabel.text = "Passport is required."
            passportNoTxtFld?.leadingAssistiveLabel.textColor = .red
            passportNoTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            passportNoTxtFld?.leadingAssistiveLabel.text = ""
            passportNoTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = contactNoTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            contactNoTxtFld?.leadingAssistiveLabel.text = "Patient contact number is required."
            contactNoTxtFld?.leadingAssistiveLabel.textColor = .red
            contactNoTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            contactNoTxtFld?.leadingAssistiveLabel.text = ""
            contactNoTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = selectClinicTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            selectClinicTxtFld?.leadingAssistiveLabel.text = "Clinic name is required."
            selectClinicTxtFld?.leadingAssistiveLabel.textColor = .red
            selectClinicTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            selectClinicTxtFld?.leadingAssistiveLabel.text = ""
            selectClinicTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = selectDoctorTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            selectDoctorTxtFld?.leadingAssistiveLabel.text = "Doctor name is required."
            selectDoctorTxtFld?.leadingAssistiveLabel.textColor = .red
            selectDoctorTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            selectDoctorTxtFld?.leadingAssistiveLabel.text = ""
            selectDoctorTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = AccNameTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            AccNameTxtFld?.leadingAssistiveLabel.text = "Please enter account name"
            AccNameTxtFld?.leadingAssistiveLabel.textColor = .red
            AccNameTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            AccNameTxtFld?.leadingAssistiveLabel.text = ""
            AccNameTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = bankNameTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            bankNameTxtFld?.leadingAssistiveLabel.text = "Bank name is required."
            bankNameTxtFld?.leadingAssistiveLabel.textColor = .red
            bankNameTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            bankNameTxtFld?.leadingAssistiveLabel.text = ""
            bankNameTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = bankAccNumberTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty || !text.isNumeric {
            bankAccNumberTxtFld?.leadingAssistiveLabel.text = "Enter a valid bank account number."
            bankAccNumberTxtFld?.leadingAssistiveLabel.textColor = .red
            bankAccNumberTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            bankAccNumberTxtFld?.leadingAssistiveLabel.text = ""
            bankAccNumberTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = contactNumberTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty || !text.isNumeric || text.count < 10 {
            contactNumberTxtFld?.leadingAssistiveLabel.text = "Enter a valid contact number."
            contactNumberTxtFld?.leadingAssistiveLabel.textColor = .red
            contactNumberTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            contactNumberTxtFld?.leadingAssistiveLabel.text = ""
            contactNumberTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if let text = dateAccTxtFld?.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
            dateAccTxtFld?.leadingAssistiveLabel.text = "Date is required."
            dateAccTxtFld?.leadingAssistiveLabel.textColor = .red
            dateAccTxtFld?.setOutlineColor(.red, for: .normal)
            isValid = false
        } else {
            dateAccTxtFld?.leadingAssistiveLabel.text = ""
            dateAccTxtFld?.setOutlineColor(.red, for: .normal)
        }
        
        if !isReloacting && !isClinicOperating && !isClinicLocation && !isSubsidyPlan &&
           !isProblemResolved && !isProblemNotResolved && !isIssueInQuality &&
           !isIssueWithDoctor && !isIssueWithStaff && !isOther {
            view.makeToast("Please select atleast one termination reason")
            isValid = false
        } else {
            
        }
        return isValid
    }
    
    func setUpInitialUI() {
        mentionReasonTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otherReasonTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        advisedTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if !patientId.isEmpty {
            Utility.getDataBasedOnPatientId(id: patientId) { success in
                if success, let patientDetail = GlobalData.patientDetailData.first {
                    self.patientNameTxtFld?.text = patientDetail.name
                    self.patientNameTxtFld?.isEnabled = false
                    if patientDetail.passport != "" {
                        self.passportNoTxtFld?.text = patientDetail.passport
                        self.passportNoTxtFld?.isEnabled = false
                    }
                    if patientDetail.contactNumber != "" {
                        self.contactNoTxtFld?.text = patientDetail.contactNumber
                        self.contactNoTxtFld?.isEnabled = false
                    }
                    if patientDetail.clinicName != "" {
                        self.selectClinicTxtFld?.text = patientDetail.clinicName
                        self.selectClinicTxtFld?.isEnabled = false
                    }
                    
                    if patientDetail.doctorName != "" {
                        self.selectDoctorTxtFld?.text = patientDetail.doctorName
                        self.selectDoctorTxtFld?.isEnabled = false
                    }
                    if patientDetail.contactNumber != "" {
                        self.contactNoTxtFld?.text = patientDetail.contactNumber
                        self.contactNoTxtFld?.isEnabled = false
                    }
                }
            }
        }
        patientNameTxtFld?.label.text = "Select Patient Name *"
        patientNameTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        patientNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        patientNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal)
        patientNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        patientNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        dateTxtFld?.label.text = "Date *"
        dateTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        dateTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        dateTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        passportNoTxtFld?.label.text = "NRIC/Passport Number *"
        passportNoTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        passportNoTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        passportNoTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        passportNoTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        passportNoTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        contactNoTxtFld?.label.text = "Contact Number *"
        contactNoTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        contactNoTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactNoTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        contactNoTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactNoTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectClinicTxtFld?.label.text = "Select Clinic *"
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectClinicTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectDoctorTxtFld?.label.text = "Select Doctor *"
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectDoctorTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        AccNameTxtFld?.label.text = "Name (as reflected in back account) *"
        AccNameTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        AccNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        AccNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        AccNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        AccNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        bankNameTxtFld?.label.text = "Bank Name *"
        bankNameTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        bankNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        bankNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        bankAccNumberTxtFld?.label.text = "Bank A/c no *"
        bankAccNumberTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        bankAccNumberTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankAccNumberTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        bankAccNumberTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankAccNumberTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        contactNumberTxtFld?.label.text = "Contact No *"
        contactNumberTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        contactNumberTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactNumberTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        contactNumberTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactNumberTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        dateAccTxtFld?.label.text = "Date *"
        dateAccTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        dateAccTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateAccTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        dateAccTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateAccTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        otherReasonTxtFld?.label.text = "Other reason"
        otherReasonTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        otherReasonTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        otherReasonTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        otherReasonTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        otherReasonTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        mentionReasonTxtFld?.label.text = "Mention reason(s) here"
        mentionReasonTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        mentionReasonTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        mentionReasonTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        mentionReasonTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        mentionReasonTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        advisedTxtFld?.label.text = ""
        advisedTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        advisedTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        advisedTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        advisedTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        advisedTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        let toolbar = createToolbar()
        dateTxtFld?.inputAccessoryView = toolbar
        dateAccTxtFld?.inputAccessoryView = toolbar
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([donebtn], animated: true)
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        dateTxtFld?.inputAccessoryView = toolbar
        dateTxtFld?.inputView = datePicker
        dateAccTxtFld?.inputAccessoryView = toolbar
        dateAccTxtFld?.inputView = datePicker
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        if !(dateTxtFld?.isFirstResponder ?? true) {
            dateAccTxtFld?.text = selectedDate
        } else if !(dateAccTxtFld?.isFirstResponder ?? true) {
            dateTxtFld?.text = selectedDate
        }
        self.view.endEditing(true)
    }
    
    @IBAction func reasontTerminationAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            isReloacting = !isReloacting
        case 1:
            isClinicLocation = !isClinicLocation
        case 2:
            isClinicOperating = !isClinicOperating
        case 3:
            isSubsidyPlan = !isSubsidyPlan
        case 4:
            isProblemResolved = !isProblemResolved
        case 5:
            isProblemNotResolved = !isProblemNotResolved
        case 6:
            isIssueInQuality = !isIssueInQuality
        case 7:
            isIssueWithDoctor = !isIssueWithDoctor
        case 8:
            isIssueWithStaff = !isIssueWithStaff
        case 9:
            isOther = !isOther
        default:
            return
        }
    }
    
    @IBAction func advisedAction() {
        isAdvised = !isAdvised
    }
    
    func submit() {
        var payload: [String: Any] = [:]
        if let patientDetail = GlobalData.patientDetailData.first {
            let selectedHealthClass = patientDetail.healthClassList?.first
            let selectedSubsidyPlan = selectedHealthClass?.subsidyPlanList.first
            payload = [
                "patient_id": patientId,
                "Inputdate": dateTxtFld?.text ?? EMPTY,
                "passport_no": passportNoTxtFld?.text ?? EMPTY,
                "patient_contact": contactNoTxtFld?.text ?? EMPTY,
                "clinic_id": (patientDetail.clinicId?.isEmpty ?? false) ? clientId : patientDetail.clinicId ?? EMPTY,
                "doctor_id": (patientDetail.doctorId?.isEmpty ?? false) ? doctorId : patientDetail.doctorId ?? EMPTY,
                "health_card_id": selectedHealthClass?.healthCardId ?? EMPTY,
                "validity_type": validityType,
                "subsidy_plan": selectedSubsidyPlan?.subsidyPlanName ?? EMPTY,
                "advised_to_discontinue_treatment": isAdvised,
                "advised_by_practitioner_name": advisedTxtFld?.text ?? EMPTY,
                "reason_for_termination": [
                    "i_am_relocating": isReloacting,
                    "relocating_country_city": relocateAddressTxtFld?.text ?? EMPTY,
                    "other_reason": otherReasonTxtFld?.text ?? EMPTY,
                    "main_reason": mentionReasonTxtFld?.text ?? EMPTY,
                    "clinic_location": isClinicLocation,
                    "clinic_operation": isClinicOperating,
                    "subsidy_plan": isSubsidyPlan,
                    "my_problem_resolved": isProblemResolved,
                    "my_problem_not_resolved": isProblemNotResolved,
                    "issue_with_quality": isIssueInQuality,
                    "issue_with_doctor": isIssueWithDoctor,
                    "issue_with_staff": isIssueWithStaff
                ],
                "bank_details": [
                    "acc_holder_name": AccNameTxtFld?.text ?? EMPTY,
                    "bank_name": bankNameTxtFld?.text ?? EMPTY,
                    "bank_acc_no": bankAccNumberTxtFld?.text ?? EMPTY,
                    "acc_holder_no": contactNumberTxtFld?.text ?? EMPTY,
                    "bank_date": dateAccTxtFld?.text ?? EMPTY
                ]
            ]
        }
        refundWebService.submitNewTicketForRefund(param: payload) { error, response, statusCode in
            if error == nil {
                SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                Utility.gotoRefundVC()
            } else {
                SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
            }
        }
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction() {
        if validateFields() {
            submit()
            } else {
                print("Validation failed. Please correct the errors.")
            }
        
       
    }
}

extension SubsidyTerminationForm: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTxtFld {
            self.createDatePicker()
        } else if textField == dateAccTxtFld {
            self.createDatePicker()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let currentTextCount = textField.text?.count ?? 0
        if textField == mentionReasonTxtFld {
            mainTxtCount?.text = "\(currentTextCount)"
        } else if textField == otherReasonTxtFld {
            otherTxtCount?.text = "\(currentTextCount)"
        } else if textField == advisedTxtFld {
            advisedTxtCount?.text = "\(currentTextCount)"
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length
        return newLength <= maxCharacterLimit
    }
}

extension String {
    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}


