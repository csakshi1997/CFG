//
//  RedFlagClosedDetailsVC.swift
//  CFGApp
//
//  Created by Sakshi on 12/02/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class RedFlagClosedDetailsVC: UIViewController {
    @IBOutlet var vw: UIView?
    @IBOutlet var selectClinicTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectDoctorTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectClinicStackView: UIStackView?
    @IBOutlet var selectDoctorStackView: UIStackView?
    @IBOutlet var caseNumberLbl: UILabel?
    @IBOutlet var createdDateLbl: UILabel?
    @IBOutlet var createdTimeLbl: UILabel?
    @IBOutlet var patientNameLbl: UILabel?
    @IBOutlet var clinicNameLbl: UILabel?
    @IBOutlet var healthCardLbl: UILabel?
    @IBOutlet var financeBalLbl: UILabel?
    @IBOutlet var typeOfSubsidyLbl: UILabel?
    @IBOutlet var frequencyLbl: UILabel?
    @IBOutlet var statusLbl: UILabel?
    @IBOutlet var closedDateLbl: UILabel?
    @IBOutlet var patientDetailVw: UIView?
    @IBOutlet var selectedConcernLbl: UILabel?
    
    @IBOutlet var clinicSupervisorVw: UIView?
    @IBOutlet var clinicSupervisorDateLbl: UILabel?
    @IBOutlet var clinicSupervisorIsConcernResolvedLbl: UILabel?
    @IBOutlet var clinicSupervisorRemarkLbl: UILabel?
    
    @IBOutlet var clinicDoctorVw: UIView?
    @IBOutlet var clinicDoctorDateLbl: UILabel?
    @IBOutlet var clinicDoctorRetentionLbl: UILabel?
    @IBOutlet var clinicDoctorrRemarkLbl: UILabel?
    
    @IBOutlet var areaManagerVw: UIView?
    @IBOutlet var areaManagerDateLbl: UILabel?
    @IBOutlet var areaManagersolutionBtn: UIButton?
    @IBOutlet var areaManagerRemarkLbl: UILabel?
    
//    @IBOutlet var clinicSupervisorVwHeight: NSLayoutConstraint?
//    @IBOutlet var clinicDoctorVwHeight: NSLayoutConstraint?
//    @IBOutlet var areaManagerVwHeight: NSLayoutConstraint?
    @IBOutlet var clinicDoctorStackViewt: UIStackView?
    @IBOutlet var areaManagerStackViewt: UIStackView?
    var closingData: ClosingRedFlagModel?
    var customDateFormatter = CustomDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupClosedRedFlagUI()
    }
    
    func setupClosedRedFlagUI() {
        selectClinicStackView?.isHidden =  true
        selectDoctorStackView?.isHidden =  true
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
        patientDetailVw?.layer.masksToBounds = false
        patientDetailVw?.layer.cornerRadius = 8
        patientDetailVw?.dropShadowTableView()
        if "\(closingData?.isConcernResolved ?? "No")" == "Yes" {
            clinicDoctorStackViewt?.isHidden = true
            areaManagerStackViewt?.isHidden = true
        } 
        caseNumberLbl?.text = closingData?.name
        createdDateLbl?.text =  customDateFormatter.getDateForCreatedAt(dateString: closingData?.createdDate ?? "")
        createdTimeLbl?.text =  customDateFormatter.getDateForCreatedAtTime(dateString: closingData?.createdDate ?? "")
        clinicNameLbl?.text = closingData?.clinic?.name
        patientNameLbl?.text = closingData?.patient?.name
        healthCardLbl?.text = closingData?.patientHealthCard?.name
        financeBalLbl?.text = (closingData?.financialBalance == "NA") ? "" : "$\(closingData?.financialBalance ?? "$0.0")"
        typeOfSubsidyLbl?.text = closingData?.typeOfSubsidyPlan
        frequencyLbl?.text = (closingData?.frequency == "NA") ? "" : closingData?.frequency
        statusLbl?.text = closingData?.status
        closedDateLbl?.text = customDateFormatter.getDateForCreatedAt(dateString: closingData?.closedDate  ?? "")
        selectedConcernLbl?.text = closingData?.concern
        clinicSupervisorDateLbl?.text = customDateFormatter.getDateForCreatedAt(dateString: closingData?.clinicSupervisorSubmittedAt ?? "")
        clinicSupervisorIsConcernResolvedLbl?.text = closingData?.isConcernResolved
        clinicSupervisorRemarkLbl?.text = closingData?.supervisorManagerRemarks
        clinicDoctorDateLbl?.text = customDateFormatter.getDateForCreatedAt(dateString: closingData?.clinicDoctorSubmittedAt ?? "")
        clinicDoctorRetentionLbl?.text = closingData?.patientRetention
        clinicDoctorrRemarkLbl?.text = closingData?.clinicDoctorRemarks
        areaManagerDateLbl?.text = customDateFormatter.getDateForCreatedAt(dateString: closingData?.closedDate  ?? "")
        selectClinicTxtFld?.text = closingData?.clinic?.name
        selectDoctorTxtFld?.text = closingData?.doctor?.name
        selectClinicTxtFld?.isEnabled = false
        selectDoctorTxtFld?.isEnabled = false
        if closingData?.finishUpSubsidyPlan == "Yes" {
            areaManagersolutionBtn?.setTitle("  Finish up Subsidy  Plan", for: .normal)
        } else if closingData?.transferBalanceToFamily == "Yes" {
            areaManagersolutionBtn?.setTitle("  Transfer balance to family / friends", for: .normal)
        } else if closingData?.extendSubsidyPlanValidity == "Yes" {
            areaManagersolutionBtn?.setTitle("  Extend Subsidy Plan validity period", for: .normal)
        } else if closingData?.refund == "Yes" {
            areaManagersolutionBtn?.setTitle("Refund", for: .normal)
        } else if closingData?.transferToOtherDoctor == "Yes" {
            areaManagersolutionBtn?.setTitle("  Transfer to other Dr in other Clinic.", for: .normal)
            selectClinicStackView?.isHidden =  false
            selectDoctorStackView?.isHidden =  false
        } else if closingData?.retainInCurrentClinic == "Yes" {
            areaManagersolutionBtn?.setTitle("  Retain at current Clinic", for: .normal)
        } else if closingData?.offerDTService == "Yes" {
            areaManagersolutionBtn?.setTitle("  Offer DT Services", for: .normal)
        } else if closingData?.offerSWTService == "Yes" {
            areaManagersolutionBtn?.setTitle("  Offer SWT / SIT Services", for: .normal)
        } else if closingData?.consultSeniorConsultant == "Yes" {
            areaManagersolutionBtn?.setTitle("  Consult Senior Consultant", for: .normal)
            selectClinicStackView?.isHidden =  false
            selectDoctorStackView?.isHidden =  false
        } else if closingData?.consultTCMService == "Yes" {
            areaManagersolutionBtn?.setTitle("  Consult TCM services", for: .normal)
            selectClinicStackView?.isHidden =  false
            selectDoctorStackView?.isHidden =  false
        } else if closingData?.patientRetention == "Yes" {
            areaManagersolutionBtn?.setTitle("  Patient Rentention", for: .normal)
            selectClinicStackView?.isHidden =  false
            selectDoctorStackView?.isHidden =  false
        }
        areaManagersolutionBtn?.isEnabled = false
        areaManagerRemarkLbl?.text = closingData?.areaManagerRemarks
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    


}
