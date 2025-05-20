//
//  PendingCaseDetailVC.swift
//  CFGApp
//
//  Created by Sakshi on 15/01/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class PendingCaseDetailVC: UIViewController {
    @IBOutlet var bankNameLbl: UILabel?
    @IBOutlet var bankAccNumberLbl: UILabel?
    @IBOutlet var nameLbl: UILabel?
    @IBOutlet var contactNoLbl: UILabel?
    @IBOutlet var caseNoLbl: UILabel?
    @IBOutlet var cretedDateLbl: UILabel?
    @IBOutlet var cretedTimeLbl: UILabel?
    @IBOutlet var bankDetailsVw: UIView?
    @IBOutlet var healthCardNoLbl: UILabel?
    @IBOutlet var financialBalanceLbl: UILabel?
    @IBOutlet var planStartLbl: UILabel?
    @IBOutlet var serviceTypeLbl: UILabel?
    @IBOutlet var patientNameLbl: UILabel?
    @IBOutlet var dateTxtFld: MDCOutlinedTextField?
    @IBOutlet var passportNoTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectClinicTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectDoctorTxtFld: MDCOutlinedTextField?
    @IBOutlet var otherReasonTxtFld: MDCOutlinedTextField?
    @IBOutlet var striveReasonTxtFld: MDCOutlinedTextField?
    @IBOutlet var isAdvisedBtn: UIButton?
    @IBOutlet var advisedTextView: UITextView?
    @IBOutlet var advisedTextViewHeight: NSLayoutConstraint?
    @IBOutlet var advisedTextViewTotaltextCount: UILabel?
    @IBOutlet var davisedTextViewtextCount: UILabel?
    
    @IBOutlet var clinicManagerStackVw: UIStackView?
    @IBOutlet var spokenWithPatient: UIButton?
    @IBOutlet var commentLbl: UILabel?
    @IBOutlet var whyLbl: UILabel?
    @IBOutlet var spokenWithPatientTextView: UITextView?
    @IBOutlet var spokenWithCommentHeight: NSLayoutConstraint?
    @IBOutlet var spokenWithCommentLbl: UILabel?
    @IBOutlet var spokenWithTextView: UIButton?
    @IBOutlet var spokenWithPatientTotalTxtCount: UILabel?
    @IBOutlet var spokenWithPatientTxtCount: UILabel?
    @IBOutlet var spokenWithPatientYesButton: UIButton?
    @IBOutlet var spokenWithPatientYesTextFld: UITextField?
    @IBOutlet var spokenWithPatientYesDateStackView: UIStackView?
    @IBOutlet var spokenWithPatientYesDateStackViewHeight: NSLayoutConstraint?
    @IBOutlet var scheduleAppointmentLbl: UILabel?
    @IBOutlet var scheduleAppointmentDateLbl: UILabel?
    @IBOutlet var boundaryLbl: UILabel?
    @IBOutlet var scheduleAppointmentTimeLbl: UILabel?
    @IBOutlet var spokenWithPatientNoButton: UIButton?
    @IBOutlet var spokenWithPatientNoHeading: UILabel?
    @IBOutlet var spokenWithPatientNoLbl: UILabel?
    @IBOutlet var spokenWithPatientNoTextView: UITextView?
    @IBOutlet var spokenWithCommenNOtHeight: NSLayoutConstraint?
    @IBOutlet var spokenWithPatientNoTotalTxtCount: UILabel?
    @IBOutlet var spokenWithPatientNoTxtCount: UILabel?
    
    @IBOutlet var clinicDoctorStackVw: UIStackView?
    @IBOutlet var difficultPatientBtn: UIButton?
    @IBOutlet var nonComplianceBtn: UIButton?
    @IBOutlet var spokenCounselledBtn: UIButton?
    @IBOutlet var othersBtn: UIButton?
    @IBOutlet var othersBtnTextView: UITextView?
    @IBOutlet var othersBtnTextViewHeight: NSLayoutConstraint?
    @IBOutlet var othersBtnTotalTxtCount: UILabel?
    @IBOutlet var othersBtnTxtCount: UILabel?
    
    @IBOutlet var doctorReviewCommentsLbl: UILabel?
    @IBOutlet var doctorReviewCommentsStackVw: UIStackView?
    @IBOutlet var doctorReviewTextView: UITextView?
    @IBOutlet var clinicDoctorReasonLbl: UILabel?
    @IBOutlet var clinicDoctorReasonTextLbl: UILabel?
    @IBOutlet var doctorReviewTextViewHeight: NSLayoutConstraint?
    @IBOutlet var doctorReviewTotalTxtCount: UILabel?
    @IBOutlet var doctorReviewTxtCount: UILabel?
    
    @IBOutlet var AMCheckListStackVw: UIStackView?
    @IBOutlet var reviewClinicManagerBtn: UIButton?
    @IBOutlet var callPatientBtn: UIButton?
    @IBOutlet var callPatientCommentLbl: UILabel?
    @IBOutlet var callPatientCommentTextLbl: UILabel?
    @IBOutlet var callPatientTextView: UITextView?
    @IBOutlet var callPatientBtnTextViewHeight: NSLayoutConstraint?
    @IBOutlet var callPatientBtnTotalTxtCount: UILabel?
    @IBOutlet var callPatientBtnTxtCount: UILabel?
    @IBOutlet var offerToTransferBtn: UIButton?
    @IBOutlet var offerToTransferSubOptionsStackVw: UIStackView?
    @IBOutlet var offerToTransferYesStackVw: UIStackView?
    @IBOutlet var offerToTransferNoStackVw: UIStackView?
    @IBOutlet var offerToTransferSubOptionsStackVwHeight: NSLayoutConstraint?
    @IBOutlet var offerToTransferYesBtn: UIButton?
    @IBOutlet var offerToTransferNoBtn: UIButton?
    @IBOutlet var profileAcceptedtextFld: UITextField?
    @IBOutlet var profileAcceptedtextFldStackVw: UIStackView?
    @IBOutlet var profileAcceptedtextFldStackVwHeight: NSLayoutConstraint?
    @IBOutlet var extendValidityBtn: UIButton?
    @IBOutlet var updateSystemStackVw: UIStackView?
    @IBOutlet var updateSystemStackVwHeight: NSLayoutConstraint?
    @IBOutlet var updateSystemBtn: UIButton?
    @IBOutlet var transferToFamilyBtn: UIButton?
    @IBOutlet var transferToFamilySubOptionsStackVw: UIStackView?
    @IBOutlet var acceptanceDateStackVw: UIStackView?
    @IBOutlet var yesArrangeTransferToFileStackVw: UIStackView?
    @IBOutlet var scheduleAppointmentStackVw: UIStackView?
    @IBOutlet var offerToSeeSeniorNoStackVw: UIStackView?
    @IBOutlet var acceptanceDateStackVwHeight: NSLayoutConstraint?
    @IBOutlet var acceptanceDatetextFldBtn: UITextField?
    @IBOutlet var AMCheckListCommentTextVwHeight: NSLayoutConstraint?
    @IBOutlet var AMCheckListCommentLbl: UILabel?
    
    @IBOutlet var offerToSeeSeniorConsultantBtn: UIButton?
    @IBOutlet var scheduleAppointmnetBtn: UIButton?
    @IBOutlet var offerToSeeSeniorConsultantStackVw: UIStackView?
    @IBOutlet var offerToSeeSeniorConsultantSubOptionsheight: NSLayoutConstraint?
    @IBOutlet var offerToSeeSeniorConsultantStackVwHeight: NSLayoutConstraint?
    @IBOutlet var offerToSeeSeniorConsultantYesBtn: UIButton?
    @IBOutlet var offerToSeeSeniorConsultantNoBtn: UIButton?
    @IBOutlet var scheduleAppointmentTextFld: UITextField?
    @IBOutlet var scheduleAppointmentTextFldwHeight: NSLayoutConstraint?
    @IBOutlet var refundWihAmountBalanceBtn: UIButton?
    @IBOutlet var noRefundValueBtn: UIButton?
    @IBOutlet var noRefundValueStackViewHeight: NSLayoutConstraint?
    @IBOutlet var noRefundValueStackVw: UIStackView?
    @IBOutlet var noRefundValueCloseCaseBtn: UIButton?
    @IBOutlet var noRefundValuePursueWithOMBtn: UIButton?
    @IBOutlet var speakToHigherAuthorityBtn: UIButton?
    @IBOutlet var AMTextView: UITextView?
    @IBOutlet var AMTotalTxtCount: UILabel?
    @IBOutlet var AMTxtCount: UILabel?
    
    @IBOutlet var SeniorConsultantCommentsStackVw: UIStackView?
    @IBOutlet var patientToContinueWithSeniorConsultantBtn: UIButton?
    @IBOutlet var patientToContinueWithClinicDoctoreBtn: UIButton?
    @IBOutlet var patientToTransferBtn: UIButton?
    @IBOutlet var refundWithAmountBtn: UIButton?
    @IBOutlet var OtherBtn: UIButton?
    @IBOutlet var seniorConsultantCommentLbl: UILabel?
    @IBOutlet var seniorConsultantOtherTextView: UITextView?
    @IBOutlet var OtherTextViewHeight: NSLayoutConstraint?
    @IBOutlet var OtherTotalTxtCount: UILabel?
    @IBOutlet var OtherTxtCount: UILabel?
    @IBOutlet var seniorConsulatantOtherCommentsHeadingLbl: UILabel?
    
    @IBOutlet var AMFollowUpStackVw: UIStackView?
    @IBOutlet var PatientToContinueCareBtn: UIButton?
    @IBOutlet var TransferFileBackToFormerClinicBtn: UIButton?
    @IBOutlet var TransferFileBackStackVw: UIStackView?
    @IBOutlet var TransferFileBackAcceptanceTextFieldStackVw: UIStackView?
    @IBOutlet var TransferFileBackAcceptanceTextField: UITextField?
    @IBOutlet var PatientToTransferToOtherDoctorBtn: UIButton?
    @IBOutlet var transferFileBtn: UIButton?
    @IBOutlet var PatientToTransferToOtherDoctorStackVw: UIStackView?
    @IBOutlet var PatientToTransferAcceptanceDateStackVw: UIStackView?
    @IBOutlet var PatientToTransferAcceptanceDateTextField: UITextField?
    @IBOutlet var refundWithAmountBalanceBtn: UIButton?
    @IBOutlet var AMRemarksTextView: UITextView?
    @IBOutlet var AMRemarksTextViewHeight: NSLayoutConstraint?
    @IBOutlet var AMRemarksTotalTxtCount: UILabel?
    @IBOutlet var AMRemarksTxtCount: UILabel?
    @IBOutlet var AMFollowUpCommentsHeadingLbl: UILabel?
    @IBOutlet var AMFollowUpCommentsLbl: UILabel?
    
    @IBOutlet var OMCommentStackVw: UIStackView?
    @IBOutlet var reviewApprovedRefundBtn: UIButton?
    @IBOutlet var caseClosedBtn: UIButton?
    @IBOutlet var OMCommentssHeadingLbl: UILabel?
    @IBOutlet var OMCommentsCommentsLbl: UILabel?
    @IBOutlet var OMCommentsTextView: UITextView?
    @IBOutlet var OMCommentsTextViewHeight: NSLayoutConstraint?
    @IBOutlet var OMCommentsTotalTxtCount: UILabel?
    @IBOutlet var OMCommentsTxtCount: UILabel?
    
    @IBOutlet var SystemAdminStackVw: UIStackView?
    @IBOutlet var reviewedBtn: UIButton?
    @IBOutlet var approvedBtn: UIButton?
    @IBOutlet var systemAdminTextView: UITextView?
    @IBOutlet var systemAdminTextViewHeight: NSLayoutConstraint?
    @IBOutlet var systemAdminTotalTxtCount: UILabel?
    @IBOutlet var systemAdminTxtCount: UILabel?
    @IBOutlet var systemAdminHeadingLbl: UILabel?
    @IBOutlet var systemAdminCommentsLbl: UILabel?
    
    @IBOutlet var financeRemarkStackVw: UIStackView?
    @IBOutlet var processPaymentBtn: UIButton?
    @IBOutlet var bankdetailsBtn: UIButton?
    @IBOutlet var nameWhereAccountIsTxtFld: MDCOutlinedTextField?
    @IBOutlet var bankNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var bankAccountTxtFld: MDCOutlinedTextField?
    @IBOutlet var contactTxtFld: MDCOutlinedTextField?
    
    @IBOutlet var nextBtn: UIButton?
    @IBOutlet var headerVw: UIView?
    @IBOutlet var reasonForTeminationBtn: UIButton?
    @IBOutlet var reloactingBtn: UIButton?
    @IBOutlet var relocateAddress: UIStackView?
    @IBOutlet var clinicLocationBtn: UIButton?
    @IBOutlet var clinicOperatingBtn: UIButton?
    @IBOutlet var subsidyPlanBtn: UIButton?
    @IBOutlet var problemResolvedBtn: UIButton?
    @IBOutlet var problemNotResolvedBtn: UIButton?
    @IBOutlet var issueInQualityBtn: UIButton?
    @IBOutlet var issueWithDoctorBtn: UIButton?
    @IBOutlet var issueWithStaffBtn: UIButton?
    @IBOutlet var othersTermination: UIButton?
    var customDateFormatter = CustomDateFormatter()
    var patientId = ""
    var datePicker = UIDatePicker()
    @IBOutlet var textFieldHeightConstraint: NSLayoutConstraint?
    var pendingRefundModel : PendingRefundModel?
    let maxCharacterLimit = 131072
    
    var isClinicManagerYes: Bool = false
    var isClinicManagerNo: Bool = false
    var isSpokenToPatientTrue: Bool = false
    
    var isClinicDoctorDifficultPatients: Bool = false
    var isClinicDoctorNonCompliance: Bool = false
    var isClinicDoctorSpokenCounselled: Bool = false
    var isClinicDoctorOthers: Bool = false
    
    var isReviewClinicManagerEnable: Bool = false
    var isCallPatientEnable: Bool = false
    var isOfferToTransferToOtherYesEnable: Bool = false
    var isOfferToTransferToOtherEnable: Bool = false
    var isOfferToTransferToOtherNoEnable: Bool = false
    var isExtendValidityEnabled: Bool = false
    var isUpdateSystemEnabled: Bool = false
    var isTransferToFamilyFriendsEnabled: Bool = false
    var isOfferToSeeSeniorConsultantEnabled: Bool = false
    var isOfferToSeeSeniorConsultantYesEnabled: Bool = false
    var isOfferToSeeSeniorConsultantNoEnabled: Bool = false
    var isOfferToSeeSeniorConsultantScheduleAppointmentEnabled: Bool = false
    var isRefundWithAmountBalancetEnabled: Bool = false
    var isNoRefundvaluetEnabled: Bool = false
    var isNoRefundvalueCaseClosedEnabled: Bool = false
    var isNoRefundvaluePursueWithOMEnabled: Bool = false
    var isSpeakToHigherAuthorityEnabled: Bool = false
    
    var isAMFollowUpPatientToContinue: Bool = false
    var isAMFollowUpPatientToTransfer: Bool = false
    var isAMFollowUpRefundWithAmount: Bool = false
    var isAMFollowUpRemarks: Bool = false
    
    var isPatientToContinueCareWithSeniorConsultantEnabled: Bool = false
    var isPatientToContinueCareWithFormerClinicDoctorEnabled: Bool = false
    var isPatientToTransferToOtherDoctorEnabled: Bool = false
    var isApprovedRefundWithAmountBalnaceEnabled: Bool = false
    var isSeniorConsultantOthersEnabled: Bool = false
    
    var isPatientToContinueCareWithAMFollowUpEnabled: Bool = false
    var isPatientToContinueCareWithAMFollowUpTransferFileEnabled: Bool = false
    var isPatientToTransferToOtherDoctorAMFollowUpEnabled: Bool = false
    var isPatientToTransferToOtherDoctorAMFollowUpTransferFileEnabled: Bool = false
    var isRefundWithAmountBalnaceAMFollowUpEnabled: Bool = false
    
    var isReviewAndApprovedRefundOMCommentEnabled: Bool = false
    var isCaseCloseOMCommentEnabled: Bool = false
    
    var isReviewedBySystemAdminEnabled: Bool = false
    var isApprovedBySystemAdminEnabled: Bool = false
    
    var isReviewedBySystemAdmin: Bool = false {
        didSet {
            if isReviewedBySystemAdmin {
                isReviewedBySystemAdminEnabled = true
                isApprovedBySystemAdmin = false
                reviewedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isReviewedBySystemAdminEnabled = false
                reviewedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isApprovedBySystemAdmin: Bool = false {
        didSet {
            if isApprovedBySystemAdmin {
                isApprovedBySystemAdminEnabled = true
                isReviewedBySystemAdmin = false
                approvedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isApprovedBySystemAdminEnabled = false
                approvedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isReviewAndApprovedRefundOMComment: Bool = false {
        didSet {
            if isReviewAndApprovedRefundOMComment {
                isReviewAndApprovedRefundOMCommentEnabled = true
                isCaseCloseOMComment = false
                reviewApprovedRefundBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isReviewAndApprovedRefundOMCommentEnabled = false
                reviewApprovedRefundBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isCaseCloseOMComment: Bool = false {
        didSet {
            if isCaseCloseOMComment {
                isCaseCloseOMCommentEnabled = true
                isReviewAndApprovedRefundOMCommentEnabled = false
                caseClosedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isCaseCloseOMCommentEnabled = false
                caseClosedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
   
    var isPatientToContinueCareWithAMFollowUp: Bool = false {
        didSet {
            if isPatientToContinueCareWithAMFollowUp {
                isPatientToContinueCareWithAMFollowUpEnabled = true
                PatientToContinueCareBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                TransferFileBackStackVw?.isHidden = false
                isPatientToTransferToOtherDoctorAMFollowUp = false
                isPatientToTransferToOtherDoctorAMFollowUpTransferFile = false
                isRefundWithAmountBalnaceAMFollowUp = false
            } else {
                isPatientToContinueCareWithAMFollowUpEnabled = false
                PatientToContinueCareBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isPatientToContinueCareWithAMFollowUpTransferFileEnabled = false
                TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                TransferFileBackStackVw?.isHidden = true
                TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
            }
        }
    }
    
    var isPatientToContinueCareWithAMFollowUpTransferFile: Bool = false {
        didSet {
            if isPatientToContinueCareWithAMFollowUpTransferFile {
                isPatientToContinueCareWithAMFollowUpTransferFileEnabled = true
                TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                TransferFileBackAcceptanceTextFieldStackVw?.isHidden = false
            } else {
                isPatientToContinueCareWithAMFollowUpTransferFileEnabled = false
                TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
            }
        }
    }
   
    var isPatientToTransferToOtherDoctorAMFollowUp: Bool = false {
        didSet {
            if isPatientToTransferToOtherDoctorAMFollowUp {
                isPatientToTransferToOtherDoctorAMFollowUpEnabled = true
                PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                PatientToTransferToOtherDoctorStackVw?.isHidden = false
                isPatientToContinueCareWithAMFollowUp = false
                isPatientToContinueCareWithAMFollowUpTransferFile = false
                isRefundWithAmountBalnaceAMFollowUp = false
            } else {
                isPatientToTransferToOtherDoctorAMFollowUpEnabled = false
                PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isPatientToTransferToOtherDoctorAMFollowUpTransferFileEnabled = false
                transferFileBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                PatientToTransferToOtherDoctorStackVw?.isHidden = true
                PatientToTransferAcceptanceDateStackVw?.isHidden = true
            }
        }
    }
    
    var isPatientToTransferToOtherDoctorAMFollowUpTransferFile: Bool = false {
        didSet {
            if isPatientToTransferToOtherDoctorAMFollowUpTransferFile {
                isPatientToTransferToOtherDoctorAMFollowUpTransferFileEnabled = true
                transferFileBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                PatientToTransferAcceptanceDateStackVw?.isHidden = false
            } else {
                isPatientToTransferToOtherDoctorAMFollowUpTransferFileEnabled = false
                transferFileBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                PatientToTransferAcceptanceDateStackVw?.isHidden = true
            }
        }
    }
    
    var isRefundWithAmountBalnaceAMFollowUp: Bool = false {
        didSet {
            if isRefundWithAmountBalnaceAMFollowUp {
                isRefundWithAmountBalnaceAMFollowUpEnabled = true
                refundWithAmountBalanceBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                isPatientToTransferToOtherDoctorAMFollowUpTransferFileEnabled = false
                transferFileBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                PatientToTransferAcceptanceDateStackVw?.isHidden = true
                isPatientToTransferToOtherDoctorAMFollowUpEnabled = false
                PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                PatientToTransferToOtherDoctorStackVw?.isHidden = true
                isPatientToContinueCareWithAMFollowUpTransferFileEnabled = false
                TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
                isPatientToContinueCareWithAMFollowUpEnabled = false
                PatientToContinueCareBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                TransferFileBackStackVw?.isHidden = true
            } else {
                isRefundWithAmountBalnaceAMFollowUpEnabled = false
                refundWithAmountBalanceBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }

    var isPatientToContinueCareWithSeniorConsultant: Bool = false {
        didSet {
            if isPatientToContinueCareWithSeniorConsultant {
                isPatientToContinueCareWithFormerClinicDoctor = false
                isPatientToTransferToOtherDoctor = false
                isApprovedRefundWithAmountBalnace = false
                isSeniorConsultantOthers = false
                isPatientToContinueCareWithSeniorConsultantEnabled = true
                patientToContinueWithSeniorConsultantBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isPatientToContinueCareWithSeniorConsultantEnabled = false
                patientToContinueWithSeniorConsultantBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isPatientToContinueCareWithFormerClinicDoctor: Bool = false {
        didSet {
            if isPatientToContinueCareWithFormerClinicDoctor {
                isPatientToContinueCareWithSeniorConsultant = false
                isPatientToTransferToOtherDoctor = false
                isApprovedRefundWithAmountBalnace = false
                isSeniorConsultantOthers = false
                isPatientToContinueCareWithFormerClinicDoctorEnabled = true
                patientToContinueWithClinicDoctoreBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isPatientToContinueCareWithFormerClinicDoctorEnabled = false
                patientToContinueWithClinicDoctoreBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isPatientToTransferToOtherDoctor: Bool = false {
        didSet {
            if isPatientToTransferToOtherDoctor {
                isPatientToContinueCareWithSeniorConsultant = false
                isPatientToContinueCareWithFormerClinicDoctor = false
                isApprovedRefundWithAmountBalnace = false
                isSeniorConsultantOthers = false
                isPatientToTransferToOtherDoctorEnabled = true
                patientToTransferBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isPatientToTransferToOtherDoctorEnabled = false
                patientToTransferBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }

    var isApprovedRefundWithAmountBalnace: Bool = false {
        didSet {
            if isApprovedRefundWithAmountBalnace {
                isPatientToContinueCareWithSeniorConsultant = false
                isPatientToContinueCareWithFormerClinicDoctor = false
                isPatientToTransferToOtherDoctor = false
                isSeniorConsultantOthers = false
                isApprovedRefundWithAmountBalnaceEnabled = true
                refundWithAmountBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isApprovedRefundWithAmountBalnaceEnabled = false
                refundWithAmountBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isSeniorConsultantOthers: Bool = false {
        didSet {
            if isSeniorConsultantOthers {
                isPatientToContinueCareWithSeniorConsultant = false
                isPatientToContinueCareWithFormerClinicDoctor = false
                isPatientToTransferToOtherDoctor = false
                isApprovedRefundWithAmountBalnace = false
                isSeniorConsultantOthersEnabled = true
                OtherBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                OtherTextViewHeight?.constant = 60
                OtherTotalTxtCount?.text = "/131072"
                OtherTxtCount?.text = "0"
                seniorConsulatantOtherCommentsHeadingLbl?.text = "Comments"
            } else {
                isSeniorConsultantOthersEnabled = false
                OtherBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                OtherTextViewHeight?.constant = 0
                OtherTotalTxtCount?.text = ""
                OtherTxtCount?.text = ""
                seniorConsultantOtherTextView?.text = ""
                seniorConsulatantOtherCommentsHeadingLbl?.text = ""
            }
        }
    }
    
    var isReviewClinicManager: Bool = false {
        didSet {
            if isReviewClinicManager {
                isReviewClinicManagerEnable = true
                reviewClinicManagerBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isReviewClinicManagerEnable = false
                reviewClinicManagerBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isCallPatient: Bool = false {
        didSet {
            if isCallPatient {
                isCallPatientEnable = true
                callPatientBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                callPatientCommentLbl?.text = "Comments"
                callPatientBtnTextViewHeight?.constant = 60
                callPatientBtnTotalTxtCount?.text = "/131072"
                callPatientBtnTxtCount?.text = "0"
            } else {
                isCallPatientEnable = false
                callPatientBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                callPatientCommentLbl?.text = ""
                callPatientBtnTextViewHeight?.constant = 0
                callPatientBtnTotalTxtCount?.text = ""
                callPatientBtnTxtCount?.text = ""
            }
        }
    }
    
    var isOfferToTransferToOther: Bool = false {
        didSet {
            if isOfferToTransferToOther {
                isOfferToTransferToOtherEnable = true
                offerToTransferBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                offerToTransferSubOptionsStackVwHeight?.constant = 120
                offerToTransferSubOptionsStackVw?.isHidden = false
                profileAcceptedtextFldStackVw?.isHidden = true
                profileAcceptedtextFldStackVwHeight?.constant = 0
            } else {
                isOfferToTransferToOtherEnable = false
                offerToTransferBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isOfferToTransferToOtherYesEnable = false
                offerToTransferYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                profileAcceptedtextFldStackVw?.isHidden = true
                isOfferToTransferToOtherNoEnable = false
                offerToTransferNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                offerToTransferSubOptionsStackVwHeight?.constant = 0
                offerToTransferSubOptionsStackVw?.isHidden = true
                profileAcceptedtextFldStackVw?.isHidden = true
            }
        }
    }
    
    var isOfferToTransferToOtherYes: Bool = false {
        didSet {
            if isOfferToTransferToOtherYes {
                isOfferToTransferToOtherYesEnable = true
                offerToTransferYesBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                profileAcceptedtextFldStackVw?.isHidden = false
                profileAcceptedtextFldStackVwHeight?.constant = 45
                isOfferToTransferToOtherNoEnable = false
                offerToTransferNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isOfferToTransferToOtherYesEnable = false
                offerToTransferYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                profileAcceptedtextFldStackVw?.isHidden = true
                profileAcceptedtextFldStackVwHeight?.constant = 0
            }
        }
    }
    
    var isOfferToTransferToOtherNo: Bool = false {
        didSet {
            if isOfferToTransferToOtherNo {
                isOfferToTransferToOtherNoEnable = true
                offerToTransferNoBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                isOfferToTransferToOtherYesEnable = false
                offerToTransferYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                profileAcceptedtextFldStackVw?.isHidden = true
                profileAcceptedtextFldStackVwHeight?.constant = 0
            } else {
                isOfferToTransferToOtherNoEnable = false
                offerToTransferNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isExtendValidity: Bool = false {
        didSet {
            if isExtendValidity {
                isExtendValidityEnabled = true
                extendValidityBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                updateSystemStackVw?.isHidden = false
                updateSystemStackVwHeight?.constant = 30
            } else {
                isExtendValidityEnabled = false
                extendValidityBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                updateSystemBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isUpdateSystemEnabled = false
                updateSystemStackVw?.isHidden = true
                updateSystemStackVwHeight?.constant = 0
                
                
            }
        }
    }
    
    var isUpdateSystem: Bool = false {
        didSet {
            if isUpdateSystem {
                isUpdateSystemEnabled = true
                updateSystemBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isUpdateSystemEnabled = false
                updateSystemBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isTransferToFamilyFriends: Bool = false {
        didSet {
            if isTransferToFamilyFriends {
                isTransferToFamilyFriendsEnabled = true
                transferToFamilyBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                acceptanceDateStackVwHeight?.constant = 45
                transferToFamilySubOptionsStackVw?.isHidden = false
                
            } else {
                isTransferToFamilyFriendsEnabled = false
                transferToFamilyBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                acceptanceDateStackVwHeight?.constant = 0
                transferToFamilySubOptionsStackVw?.isHidden = true
                
            }
        }
    }
    
    var isOfferToSeeSeniorConsultantAM: Bool = false {
        didSet {
            if isOfferToSeeSeniorConsultantAM {
                isOfferToSeeSeniorConsultantEnabled = true
                offerToSeeSeniorConsultantBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                offerToSeeSeniorConsultantStackVw?.isHidden = false
                offerToSeeSeniorConsultantSubOptionsheight?.constant = 170
                scheduleAppointmentTextFldwHeight?.constant = 0
                scheduleAppointmentStackVw?.isHidden = true
            } else {
                isOfferToSeeSeniorConsultantEnabled = false
                offerToSeeSeniorConsultantBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                offerToSeeSeniorConsultantSubOptionsheight?.constant = 0
                scheduleAppointmentTextFldwHeight?.constant = 0
                offerToSeeSeniorConsultantStackVw?.isHidden = true
                isOfferToSeeSeniorConsultantNoEnabled = false
                offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isOfferToSeeSeniorConsultantYesEnabled = false
                offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isOfferToSeeSeniorConsultantScheduleAppointmentEnabled = false
                scheduleAppointmnetBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
//                acceptanceDateStackVw?.isHidden = true
            }
        }
    }
   
    var isOfferToSeeSeniorConsultantAMYes: Bool = false {
        didSet {
            if isOfferToSeeSeniorConsultantAMYes {
                isOfferToSeeSeniorConsultantYesEnabled = true
                offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
//                profileAcceptedtextFldStackVw?.isHidden = false
                isOfferToSeeSeniorConsultantNoEnabled = false
                offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isOfferToSeeSeniorConsultantYesEnabled = false
                offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
//                profileAcceptedtextFldStackVw?.isHidden = true
            }
        }
    }
    
    var isOfferToSeeSeniorConsultantAMNo: Bool = false {
        didSet {
            if isOfferToSeeSeniorConsultantAMNo {
                isOfferToSeeSeniorConsultantNoEnabled = true
                offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                scheduleAppointmentStackVw?.isHidden = true
                scheduleAppointmnetBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                scheduleAppointmentTextFldwHeight?.constant = 0
                isOfferToSeeSeniorConsultantYesEnabled = false
                offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isOfferToSeeSeniorConsultantScheduleAppointmentEnabled = false
            } else {
                isOfferToSeeSeniorConsultantNoEnabled = false
                offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isOfferToSeeSeniorConsultantAMScheduleAppointment: Bool = false {
        didSet {
            if isOfferToSeeSeniorConsultantAMScheduleAppointment {
                isOfferToSeeSeniorConsultantScheduleAppointmentEnabled = true
                scheduleAppointmnetBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                scheduleAppointmentStackVw?.isHidden = false
                scheduleAppointmentTextFldwHeight?.constant = 45
                isOfferToSeeSeniorConsultantNoEnabled = false
                offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isOfferToSeeSeniorConsultantScheduleAppointmentEnabled = false
                scheduleAppointmnetBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                scheduleAppointmentStackVw?.isHidden = true
                scheduleAppointmentTextFldwHeight?.constant = 0
            }
        }
    }
    
    var isRefundWithAmountBalancet: Bool = false {
        didSet {
            if isRefundWithAmountBalancet {
                isRefundWithAmountBalancetEnabled = true
                refundWihAmountBalanceBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isRefundWithAmountBalancetEnabled = false
                refundWihAmountBalanceBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNoRefundvaluet: Bool = false {
        didSet {
            if isNoRefundvaluet {
                isNoRefundvaluetEnabled = true
                noRefundValueBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                noRefundValueStackVw?.isHidden = false
                noRefundValueStackViewHeight?.constant = 70
                
            } else {
                isNoRefundvaluetEnabled = false
                noRefundValueBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                noRefundValueStackViewHeight?.constant = 0
                noRefundValueStackVw?.isHidden = true
                isNoRefundvalueCaseClosed = false
                noRefundValueCloseCaseBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                isNoRefundvaluePursueWithOM = false
                noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                
            }
        }
    }
    
    var isNoRefundvalueCaseClosed: Bool = false {
        didSet {
            if isNoRefundvalueCaseClosed {
                isNoRefundvalueCaseClosed = true
                noRefundValueCloseCaseBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                isNoRefundvaluePursueWithOM = false
                noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isNoRefundvalueCaseClosed = false
                noRefundValueCloseCaseBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNoRefundvaluePursueWithOM: Bool = false {
        didSet {
            if isNoRefundvaluePursueWithOM {
                isNoRefundvaluePursueWithOM = true
                noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                isNoRefundvalueCaseClosed = false
                noRefundValueCloseCaseBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isNoRefundvaluePursueWithOM = false
                noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isSpeakToHigherAuthority: Bool = false {
        didSet {
            if isSpeakToHigherAuthority {
                isSpeakToHigherAuthorityEnabled = true
                speakToHigherAuthorityBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isSpeakToHigherAuthorityEnabled = false
                speakToHigherAuthorityBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isOfferToSeeSeniorConsultant: Bool = false {
        didSet {
            if isOfferToSeeSeniorConsultant {
                isOfferToSeeSeniorConsultantEnabled = true
                spokenWithPatient?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                commentLbl?.text = "Comment"
                spokenWithCommentHeight?.constant = 60
                spokenWithPatientTotalTxtCount?.text = "/131072"
                spokenWithPatientTxtCount?.text = "0"
            } else {
                isOfferToSeeSeniorConsultantEnabled = false
                spokenWithPatient?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                commentLbl?.text = ""
                spokenWithCommentHeight?.constant = 0
                spokenWithPatientTotalTxtCount?.text = ""
                spokenWithPatientTxtCount?.text = ""
            }
        }
    }
    
    
    var isSpokenToPatient: Bool = false {
        didSet {
            if isSpokenToPatient {
                isSpokenToPatientTrue = true
                spokenWithPatient?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                commentLbl?.text = "Comment"
                spokenWithCommentHeight?.constant = 60
                spokenWithPatientTotalTxtCount?.text = "/131072"
                spokenWithPatientTxtCount?.text = "0"
            } else {
                isSpokenToPatientTrue = false
                spokenWithPatient?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                commentLbl?.text = ""
                spokenWithCommentHeight?.constant = 0
                spokenWithPatientTotalTxtCount?.text = ""
                spokenWithPatientTxtCount?.text = ""
            }
        }
    }
    
    var isClinicManagerYES: Bool = false {
        didSet {
            if isClinicManagerYES {
                isClinicManagerYes = true
                spokenWithPatientYesButton?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                spokenWithPatientYesDateStackViewHeight?.constant = 45
                spokenWithPatientNoButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                spokenWithCommenNOtHeight?.constant = 0
                spokenWithPatientNoTotalTxtCount?.text = ""
                spokenWithPatientNoTxtCount?.text = ""
                whyLbl?.text = ""
            } else {
                isClinicManagerYes = false
                spokenWithPatientYesButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                spokenWithPatientYesDateStackViewHeight?.constant = 0
            }
        }
    }
    
    var isClinicManagerNO: Bool = false {
        didSet {
            if isClinicManagerNO {
                isClinicManagerNo = true
                spokenWithPatientNoButton?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                spokenWithCommenNOtHeight?.constant = 60
                spokenWithPatientNoTotalTxtCount?.text = "/131072"
                spokenWithPatientNoTxtCount?.text = "0"
                whyLbl?.text = "Why?"
                spokenWithPatientYesDateStackViewHeight?.constant = 0
                spokenWithPatientYesButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            } else {
                isClinicManagerNo = false
                spokenWithPatientNoButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                spokenWithCommenNOtHeight?.constant = 0
                spokenWithPatientNoTotalTxtCount?.text = ""
                spokenWithPatientNoTxtCount?.text = ""
                whyLbl?.text = ""
            }
        }
    }
    
    var isDifficultPatient: Bool = false {
        didSet {
            if isDifficultPatient {
                isClinicDoctorDifficultPatients = true
                difficultPatientBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isClinicDoctorDifficultPatients = false
                difficultPatientBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isNonCompliance: Bool = false {
        didSet {
            if isNonCompliance {
                isClinicDoctorNonCompliance = true
                nonComplianceBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isClinicDoctorNonCompliance = false
                nonComplianceBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isSpokenCounselled: Bool = false {
        didSet {
            if isSpokenCounselled {
                isClinicDoctorSpokenCounselled = true
                spokenCounselledBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                isClinicDoctorSpokenCounselled = false
                spokenCounselledBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }

    var isClinicDoctorOthrsClicks: Bool = false {
        didSet {
            if isClinicDoctorOthrsClicks {
                isClinicDoctorOthers = true
                othersBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                othersBtnTextViewHeight?.constant = 60
                othersBtnTotalTxtCount?.text = "/131072"
                othersBtnTxtCount?.text = "0"
                clinicDoctorReasonLbl?.text = "Reason"
            } else {
                isClinicDoctorOthers = false
                othersBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                othersBtnTextViewHeight?.constant = 0
                othersBtnTotalTxtCount?.text = ""
                othersBtnTxtCount?.text = ""
                clinicDoctorReasonLbl?.text = ""
            }
        }
    }
    
    @IBAction func OMCommentsAction(_ sender: UIButton) {
        if sender.tag == 71 {
            isReviewAndApprovedRefundOMComment = !isReviewAndApprovedRefundOMComment
        } else if sender.tag == 72 {
            isCaseCloseOMComment = !isCaseCloseOMComment
        }
    }
    
    @IBAction func AMFollowUpAction(_ sender: UIButton) {
        if sender.tag == 51 {
            isPatientToContinueCareWithAMFollowUp = !isPatientToContinueCareWithAMFollowUp
        } else if sender.tag == 511 {
            isPatientToContinueCareWithAMFollowUpTransferFile = !isPatientToContinueCareWithAMFollowUpTransferFile
        } else if sender.tag == 52 {
            isPatientToTransferToOtherDoctorAMFollowUp = !isPatientToTransferToOtherDoctorAMFollowUp
        } else if sender.tag == 522 {
            isPatientToTransferToOtherDoctorAMFollowUpTransferFile = !isPatientToTransferToOtherDoctorAMFollowUpTransferFile
        } else if sender.tag == 53 {
            isRefundWithAmountBalnaceAMFollowUp = !isRefundWithAmountBalnaceAMFollowUp
        }
    }
    
    @IBAction func seniorConsultantCommentAction(_ sender: UIButton) {
        if sender.tag == 41 {
            isPatientToContinueCareWithSeniorConsultant = !isPatientToContinueCareWithSeniorConsultant
        } else if sender.tag == 42 {
            isPatientToContinueCareWithFormerClinicDoctor = !isPatientToContinueCareWithFormerClinicDoctor
        } else if sender.tag == 43 {
            isPatientToTransferToOtherDoctor = !isPatientToTransferToOtherDoctor
        } else if sender.tag == 44 {
            isApprovedRefundWithAmountBalnace = !isApprovedRefundWithAmountBalnace
        } else if sender.tag == 45 {
            isSeniorConsultantOthers = !isSeniorConsultantOthers
        }
    }
    
    @IBAction func clinicManagerAction(_ sender: UIButton) {
        if sender.tag == 21 {
            isSpokenToPatient = !isSpokenToPatient
        } else if sender.tag == 22 {
            isClinicManagerYES = !isClinicManagerYES
        } else if sender.tag == 23 {
            isClinicManagerNO = !isClinicManagerNO
        }
    }
    
    @IBAction func AMCheckListAction(_ sender: UIButton) {
        if sender.tag == 61 {
            isReviewClinicManager = !isReviewClinicManager
        } else if sender.tag == 62 {
            isCallPatient = !isCallPatient
        } else if sender.tag == 63 {
            isOfferToTransferToOther = !isOfferToTransferToOther
        } else if sender.tag == 631 {
            isOfferToTransferToOtherYes = !isOfferToTransferToOtherYes
        } else if sender.tag == 632 {
            isOfferToTransferToOtherNo = !isOfferToTransferToOtherNo
        } else if sender.tag == 64 {
            isExtendValidity = !isExtendValidity
        } else if sender.tag == 641 {
            isUpdateSystem = !isUpdateSystem
        } else if sender.tag == 65 {
            isTransferToFamilyFriends = !isTransferToFamilyFriends
        } else if sender.tag == 66 {
            isOfferToSeeSeniorConsultantAM = !isOfferToSeeSeniorConsultantAM
        } else if sender.tag == 661 {
            isOfferToSeeSeniorConsultantAMYes = !isOfferToSeeSeniorConsultantAMYes
        } else if sender.tag == 662 {
            isOfferToSeeSeniorConsultantAMScheduleAppointment = !isOfferToSeeSeniorConsultantAMScheduleAppointment
        } else if sender.tag == 663 {
            isOfferToSeeSeniorConsultantAMNo = !isOfferToSeeSeniorConsultantAMNo
        } else if sender.tag == 67 {
            isRefundWithAmountBalancet = !isRefundWithAmountBalancet
        } else if sender.tag == 68 {
            isNoRefundvaluet = !isNoRefundvaluet
        } else if sender.tag == 681 {
            isNoRefundvalueCaseClosed = !isNoRefundvalueCaseClosed
        } else if sender.tag == 682 {
            isNoRefundvaluePursueWithOM = !isNoRefundvaluePursueWithOM
        } else if sender.tag == 69 {
            isSpeakToHigherAuthority = !isSpeakToHigherAuthority
        }
    }
    
    @IBAction func clinicDoctorAction(_ sender: UIButton) {
        if sender.tag == 31 {
            isDifficultPatient = !isDifficultPatient
        } else if sender.tag == 32 {
            isNonCompliance = !isNonCompliance
        } else if sender.tag == 33 {
            isSpokenCounselled = !isSpokenCounselled
        } else if sender.tag == 34 {
            isClinicDoctorOthrsClicks = !isClinicDoctorOthrsClicks
        }
    }
    
    @IBAction func systemAdminAction(_ sender: UIButton) {
        if sender.tag == 81 {
            isReviewedBySystemAdmin = !isReviewedBySystemAdmin
        } else if sender.tag == 82 {
            isApprovedBySystemAdmin = !isApprovedBySystemAdmin
        }
    }
    
    func SetUIInitialUIForAMCheckList() {
        callPatientCommentLbl?.text = ""
        callPatientBtnTextViewHeight?.constant = 0
        callPatientBtnTotalTxtCount?.text = ""
        callPatientBtnTxtCount?.text = ""
        
        offerToTransferYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        profileAcceptedtextFldStackVw?.isHidden = true
        offerToTransferNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        offerToTransferSubOptionsStackVwHeight?.constant = 0
        profileAcceptedtextFldStackVw?.isHidden = true
        offerToTransferSubOptionsStackVwHeight?.constant = 0
        offerToTransferSubOptionsStackVw?.isHidden = true
        
        isUpdateSystemEnabled = false
        updateSystemStackVw?.isHidden = true
        updateSystemStackVwHeight?.constant = 0
        
        acceptanceDateStackVwHeight?.constant = 0
        offerToSeeSeniorConsultantStackVw?.isHidden = true
        isOfferToSeeSeniorConsultantNoEnabled = false
        offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        profileAcceptedtextFldStackVw?.isHidden = true
        isOfferToSeeSeniorConsultantYesEnabled = false
        offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        isOfferToSeeSeniorConsultantScheduleAppointmentEnabled = false
        scheduleAppointmnetBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        acceptanceDateStackVw?.isHidden = true
        noRefundValueStackVw?.isHidden = true
        noRefundValueStackViewHeight?.constant = 0
        isNoRefundvalueCaseClosed = false
        noRefundValueCloseCaseBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        isNoRefundvaluePursueWithOM = false
        noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pendingRefundModel)
        SetUIInitialUIForAMCheckList()
        setUpInitialUI()
        textFieldHeightConstraint = otherReasonTxtFld?.heightAnchor.constraint(equalToConstant: 0)
        textFieldHeightConstraint?.isActive = true
        otherReasonTxtFld?.isHidden = true
        self.view.layoutIfNeeded()
        addTapGestureToDismissKeyboard()
        TransferFileBackStackVw?.isHidden = true
        TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
        PatientToTransferToOtherDoctorStackVw?.isHidden = true
        PatientToTransferAcceptanceDateStackVw?.isHidden = true
    }
    
    func setUpInitialUI() {
        systemAdminTextView?.layer.cornerRadius = 12
        systemAdminTextView?.layer.borderWidth = 1
        systemAdminTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        systemAdminTextView?.layer.masksToBounds = false
        
        OMCommentsTextView?.layer.cornerRadius = 12
        OMCommentsTextView?.layer.borderWidth = 1
        OMCommentsTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        OMCommentsTextView?.layer.masksToBounds = false
        
        TransferFileBackAcceptanceTextFieldStackVw?.layer.cornerRadius = 12
        TransferFileBackAcceptanceTextFieldStackVw?.layer.borderWidth = 1
        TransferFileBackAcceptanceTextFieldStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        TransferFileBackAcceptanceTextFieldStackVw?.layer.masksToBounds = false
        
        PatientToTransferAcceptanceDateStackVw?.layer.cornerRadius = 12
        PatientToTransferAcceptanceDateStackVw?.layer.borderWidth = 1
        PatientToTransferAcceptanceDateStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        PatientToTransferAcceptanceDateStackVw?.layer.masksToBounds = false
        
        AMRemarksTextView?.layer.cornerRadius = 12
        AMRemarksTextView?.layer.borderWidth = 1
        AMRemarksTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        AMRemarksTextView?.layer.masksToBounds = false
        
        seniorConsultantOtherTextView?.layer.cornerRadius = 12
        seniorConsultantOtherTextView?.layer.borderWidth = 1
        seniorConsultantOtherTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        seniorConsultantOtherTextView?.layer.masksToBounds = false
        
        callPatientTextView?.layer.cornerRadius = 12
        callPatientTextView?.layer.borderWidth = 1
        callPatientTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        callPatientTextView?.layer.masksToBounds = false
        
        AMTextView?.layer.cornerRadius = 12
        AMTextView?.layer.borderWidth = 1
        AMTextView?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        AMTextView?.layer.masksToBounds = false
        
        transferToFamilySubOptionsStackVw?.layer.cornerRadius = 12
        transferToFamilySubOptionsStackVw?.layer.borderWidth = 1
        transferToFamilySubOptionsStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        transferToFamilySubOptionsStackVw?.layer.masksToBounds = false
        
        profileAcceptedtextFldStackVw?.layer.cornerRadius = 12
        profileAcceptedtextFldStackVw?.layer.borderWidth = 1
        profileAcceptedtextFldStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        profileAcceptedtextFldStackVw?.layer.masksToBounds = false
        
        scheduleAppointmentStackVw?.layer.cornerRadius = 12
        scheduleAppointmentStackVw?.layer.borderWidth = 1
        scheduleAppointmentStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        scheduleAppointmentStackVw?.layer.masksToBounds = false
        
        clinicManagerStackVw?.layer.cornerRadius = 12
        clinicManagerStackVw?.layer.borderWidth = 1
        clinicManagerStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        clinicManagerStackVw?.layer.masksToBounds = false
        
        clinicDoctorStackVw?.layer.cornerRadius = 12
        clinicDoctorStackVw?.layer.borderWidth = 1
        clinicDoctorStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        clinicDoctorStackVw?.layer.masksToBounds = false
        
        doctorReviewCommentsStackVw?.layer.cornerRadius = 12
        doctorReviewCommentsStackVw?.layer.borderWidth = 1
        doctorReviewCommentsStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        doctorReviewCommentsStackVw?.layer.masksToBounds = false
        
        AMCheckListStackVw?.layer.cornerRadius = 12
        AMCheckListStackVw?.layer.borderWidth = 1
        AMCheckListStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        AMCheckListStackVw?.layer.masksToBounds = false
        
        SeniorConsultantCommentsStackVw?.layer.cornerRadius = 12
        SeniorConsultantCommentsStackVw?.layer.borderWidth = 1
        SeniorConsultantCommentsStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        SeniorConsultantCommentsStackVw?.layer.masksToBounds = false
        
        AMFollowUpStackVw?.layer.cornerRadius = 12
        AMFollowUpStackVw?.layer.borderWidth = 1
        AMFollowUpStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        AMFollowUpStackVw?.layer.masksToBounds = false
        
        OMCommentStackVw?.layer.cornerRadius = 12
        OMCommentStackVw?.layer.borderWidth = 1
        OMCommentStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        OMCommentStackVw?.layer.masksToBounds = false
        
        SystemAdminStackVw?.layer.cornerRadius = 12
        SystemAdminStackVw?.layer.borderWidth = 1
        SystemAdminStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        SystemAdminStackVw?.layer.masksToBounds = false
        
        
        financeRemarkStackVw?.layer.cornerRadius = 12
        financeRemarkStackVw?.layer.borderWidth = 1
        financeRemarkStackVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        financeRemarkStackVw?.layer.masksToBounds = false
        
        nextBtn?.layer.masksToBounds = false
        nextBtn?.layer.cornerRadius = 8
        headerVw?.layer.cornerRadius = 12
        headerVw?.layer.borderWidth = 0.5
        headerVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        headerVw?.layer.masksToBounds = false
        headerVw?.dropShadowTableView()
        
        bankDetailsVw?.layer.cornerRadius = 12
        bankDetailsVw?.layer.borderWidth = 0.5
        bankDetailsVw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        bankDetailsVw?.layer.masksToBounds = false
        bankDetailsVw?.dropShadowTableView()
        
        dateTxtFld?.label.text = "Date"
        dateTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        dateTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        dateTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        dateTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        passportNoTxtFld?.label.text = "NRIC/Passport Number"
        passportNoTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        passportNoTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        passportNoTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        passportNoTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        passportNoTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectClinicTxtFld?.label.text = "Select Clinic"
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectClinicTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectClinicTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectClinicTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectDoctorTxtFld?.label.text = "Select Doctor"
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        selectDoctorTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectDoctorTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectDoctorTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        otherReasonTxtFld?.label.text = "Other reason"
        otherReasonTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        otherReasonTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        otherReasonTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        otherReasonTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        otherReasonTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        nameWhereAccountIsTxtFld?.label.text = "Name (as reflected in Bank A/c)"
        nameWhereAccountIsTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        nameWhereAccountIsTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        nameWhereAccountIsTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        nameWhereAccountIsTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        nameWhereAccountIsTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        nameWhereAccountIsTxtFld?.isUserInteractionEnabled = false
        
        bankNameTxtFld?.label.text = "Bank Name"
        bankNameTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        bankNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        bankNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        bankNameTxtFld?.isUserInteractionEnabled = false
        
        bankAccountTxtFld?.label.text = "Bank A/c No"
        bankAccountTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        bankAccountTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankAccountTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        bankAccountTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        bankAccountTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        bankAccountTxtFld?.isUserInteractionEnabled = false
        
        contactTxtFld?.label.text = "Contact No"
        contactTxtFld?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
        contactTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        contactTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        contactTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        contactTxtFld?.isUserInteractionEnabled = false
        
//        TransferFileBackAcceptanceTextField?.label.text = "Acceptance date"
//        TransferFileBackAcceptanceTextField?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
//        TransferFileBackAcceptanceTextField?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
//        TransferFileBackAcceptanceTextField?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
//        TransferFileBackAcceptanceTextField?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
//        TransferFileBackAcceptanceTextField?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
//        
//        PatientToTransferAcceptanceDateTextField?.label.text = "Acceptance date"
//        PatientToTransferAcceptanceDateTextField?.setOutlineColor(UIColor(red: 78.0 / 255.0, green: 78.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0), for: .normal)
//        PatientToTransferAcceptanceDateTextField?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
//        PatientToTransferAcceptanceDateTextField?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
//        PatientToTransferAcceptanceDateTextField?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
//        PatientToTransferAcceptanceDateTextField?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        let toolbar = createToolbar()
        dateTxtFld?.inputAccessoryView = toolbar
        nextBtn?.layer.cornerRadius = 8
        autoPopulateData()
    }
    
    func autoPopulateData() {
        doctorReviewTextView?.borderWidth = 1
        doctorReviewTextView?.borderColor = .gray
        doctorReviewTextView?.layer.cornerRadius = 8
        advisedTextView?.borderWidth = 1
        advisedTextView?.borderColor = .gray
        advisedTextView?.layer.cornerRadius = 8
        spokenWithPatientYesDateStackView?.borderWidth = 1
        spokenWithPatientYesDateStackView?.borderColor = .gray
        spokenWithPatientYesDateStackView?.layer.cornerRadius = 8
        spokenWithPatientTextView?.borderWidth = 1
        spokenWithPatientTextView?.borderColor = .gray
        spokenWithPatientTextView?.layer.cornerRadius = 8
        spokenWithPatientNoTextView?.borderWidth = 1
        spokenWithPatientNoTextView?.borderColor = .gray
        spokenWithPatientNoTextView?.layer.cornerRadius = 8
        othersBtnTextView?.borderWidth = 1
        othersBtnTextView?.borderColor = .gray
        othersBtnTextView?.layer.cornerRadius = 8
        guard let patientDetail = pendingRefundModel else {
            print("No data available in pendingRefundModel")
            return
        }
        DispatchQueue.main.async {
            self.caseNoLbl?.text = patientDetail.name
            self.cretedDateLbl?.text = self.customDateFormatter.getDateForCreatedAt(dateString: patientDetail.createdDate ?? "")
            self.cretedTimeLbl?.text = self.customDateFormatter.getDateForCreatedAtTime(dateString: patientDetail.createdDate ?? "")
            self.dateTxtFld?.text = patientDetail.date
            self.dateTxtFld?.isEnabled = false
            self.passportNoTxtFld?.text = patientDetail.nricPassportNo
            self.passportNoTxtFld?.isEnabled = false
            self.selectClinicTxtFld?.text = patientDetail.clinic?.name
            self.selectClinicTxtFld?.isEnabled = false
            self.selectDoctorTxtFld?.text = patientDetail.doctor?.name
            self.selectDoctorTxtFld?.isEnabled = false
            self.patientNameLbl?.text = patientDetail.patient?.name
            self.healthCardNoLbl?.text = patientDetail.patientHealthCard?.cardNumber
            self.financialBalanceLbl?.text = "\(patientDetail.patientHealthCard?.financialBalance ?? 0).0"
            self.planStartLbl?.text = patientDetail.patientHealthCard?.planStartDate
            self.serviceTypeLbl?.text = patientDetail.patientHealthCard?.serviceType
            if patientDetail.advisedToDiscontinueTreatment == true {
                self.isAdvisedBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                self.advisedTextViewHeight?.constant = 50
                self.advisedTextView?.text = patientDetail.Were_you_advised_to_discontinue_by_whom__c
                self.advisedTextViewTotaltextCount?.text = ""
                self.davisedTextViewtextCount?.text = ""
                self.isAdvisedBtn?.isEnabled = false
                self.advisedTextView?.isUserInteractionEnabled = false
            } else {
                self.isAdvisedBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                self.advisedTextViewHeight?.constant = 0
                self.davisedTextViewtextCount?.text = ""
                self.advisedTextViewTotaltextCount?.text = ""
                
            }
            if patientDetail.relocating == true {
                self.reloactingBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                self.relocateAddress?.isHidden = false
                
            } else {
                self.reloactingBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                self.relocateAddress?.isHidden = true
            }
            if patientDetail.clinicLocationInconvenient == true {
                self.clinicLocationBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.clinicLocationBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.clinicOperatingHoursNotFit == true {
                self.clinicOperatingBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.clinicOperatingBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.subsidyPlanNotWithinBudget == true {
                self.subsidyPlanBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.subsidyPlanBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.problemsResolved == true {
                self.problemResolvedBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.problemResolvedBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.problemsNotResolved == true {
                self.problemNotResolvedBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.problemNotResolvedBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.issueWithQualityOfService == true {
                self.issueInQualityBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.issueInQualityBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.issueWithDoctor == true {
                self.issueWithDoctorBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.issueWithDoctorBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            if patientDetail.issueWithStaff == true {
                self.issueWithStaffBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
            } else {
                self.issueWithStaffBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            self.nameLbl?.text = patientDetail.name
            self.bankNameLbl?.text = patientDetail.bankName
            self.bankAccNumberLbl?.text = patientDetail.bankACNo
            self.contactNoLbl?.text = patientDetail.bankContactNo
            self.nameWhereAccountIsTxtFld?.text = patientDetail.bankName
            self.bankNameTxtFld?.text = patientDetail.bankName
            self.bankAccountTxtFld?.text = patientDetail.bankACNo
            self.contactTxtFld?.text = patientDetail.bankContactNo
            
            //Clinic Manager
            
            if (patientDetail.spokenToPatient ?? false) {
                self.spokenWithPatient?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.spokenWithCommentHeight?.constant = 0
                self.spokenWithCommentLbl?.text = patientDetail.Spoken_to_Patient_Comments__c
                self.spokenWithPatientTxtCount?.text = ""
                self.spokenWithPatientTotalTxtCount?.text = ""
            } else {
                self.spokenWithPatient?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.spokenWithCommentHeight?.constant = 0
                self.spokenWithPatientTxtCount?.text = ""
                self.spokenWithPatientTotalTxtCount?.text = ""
            }
            if (patientDetail.offeredReviewWithCDYes ?? false) {
                self.spokenWithPatientYesButton?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.scheduleAppointmentLbl?.text = "Schedule appointment date:"
                self.scheduleAppointmentDateLbl?.text =  self.customDateFormatter.getDateForCreatedAt(dateString: patientDetail.createdDate ?? "")
                self.scheduleAppointmentTimeLbl?.text =  self.customDateFormatter.getDateForCreatedAtTime(dateString: patientDetail.createdDate ?? "")
                self.spokenWithPatientYesDateStackViewHeight?.constant = 0
                self.spokenWithPatientNoTxtCount?.text = ""
                self.spokenWithPatientNoTotalTxtCount?.text = ""
            } else {
                self.spokenWithPatientNoButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.scheduleAppointmentLbl?.text = ""
                self.scheduleAppointmentDateLbl?.text = ""
                self.scheduleAppointmentTimeLbl?.text = ""
                self.spokenWithPatientYesDateStackViewHeight?.constant = 0
            }
            if (patientDetail.offeredReviewWithCDNo ?? false) {
                self.spokenWithPatientNoButton?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.whyLbl?.text = "why?"
                self.spokenWithCommenNOtHeight?.constant = 0
                self.spokenWithPatientNoLbl?.text = patientDetail.Offered_Review_with_CD_No_Why__c
                self.spokenWithPatientTxtCount?.text = ""
                self.spokenWithPatientTotalTxtCount?.text = ""
            } else {
                self.spokenWithPatientNoButton?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.whyLbl?.text = ""
                self.spokenWithCommenNOtHeight?.constant = 0
                self.spokenWithPatientNoLbl?.text = ""
                self.spokenWithPatientTxtCount?.text = ""
                self.spokenWithPatientTotalTxtCount?.text = ""
            }
            
            //Clinic Doctor
            
            if (patientDetail.difficultPatientAlwaysComplaining ?? false) {
                self.difficultPatientBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.difficultPatientBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.nonComplianceOnCPFrequencyVisit ?? false) {
                self.nonComplianceBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.nonComplianceBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.spokenCounselledMultipleTimes ?? false) {
                self.spokenCounselledBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.spokenCounselledBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.clinicDoctorOthers ?? false) {
                self.othersBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.othersBtnTextViewHeight?.constant = 0
                self.othersBtnTxtCount?.text = ""
                self.othersBtnTotalTxtCount?.text = ""
                self.clinicDoctorReasonLbl?.text = "Reason"
                self.clinicDoctorReasonTextLbl?.text = patientDetail.Clinic_Doctor_Others_Reason__c
               
            } else {
                self.othersBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.othersBtnTextViewHeight?.constant = 0
                self.othersBtnTxtCount?.text = ""
                self.othersBtnTotalTxtCount?.text = ""
                self.clinicDoctorReasonLbl?.text = ""
                self.clinicDoctorReasonTextLbl?.text = ""
                self.clinicDoctorReasonLbl?.text = ""
                self.clinicDoctorReasonTextLbl?.text = ""
            }
            
            // Doctor review Comment
            
            if !(patientDetail.Doctor_s_Comment__c?.isEmpty ?? true ){
                self.doctorReviewCommentsLbl?.text = patientDetail.Doctor_s_Comment__c
                self.doctorReviewTextViewHeight?.constant = 0
                self.doctorReviewTotalTxtCount?.text = ""
                self.doctorReviewTxtCount?.text = ""
            } else {
                self.doctorReviewCommentsLbl?.text = ""
                self.doctorReviewTextViewHeight?.constant = 60
                self.doctorReviewTotalTxtCount?.text = "/131072"
                self.doctorReviewTxtCount?.text = "0"
            }
            
            //AM CheckList
            
            if (patientDetail.reviewedClinicManagerDoctorRemarks ?? false) {
                self.reviewClinicManagerBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.reviewClinicManagerBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.callPatientAMChecklist ?? false) {
                self.callPatientBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.callPatientCommentLbl?.text = "Comments"
                self.callPatientCommentTextLbl?.text = patientDetail.Call_Patient_Comments_AM_Checklist__c
                self.callPatientBtnTextViewHeight?.constant = 0
                self.callPatientBtnTxtCount?.text = ""
                self.callPatientBtnTotalTxtCount?.text = ""
            } else {
                self.callPatientBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.callPatientCommentLbl?.text = ""
                self.callPatientCommentTextLbl?.text = ""
                self.callPatientCommentTextLbl?.text = ""
                self.callPatientBtnTextViewHeight?.constant = 0
                self.callPatientBtnTxtCount?.text = ""
                self.callPatientBtnTotalTxtCount?.text = ""
            }
            if (patientDetail.transferToOtherDoctorAM ?? false) {
                self.offerToTransferBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.offerToTransferSubOptionsStackVwHeight?.constant = 120
                self.offerToTransferSubOptionsStackVw?.isHidden = false
                if (patientDetail.Yes_Arrange_Transfer_of_File_AM_Checklis__c ?? false) {
                    self.offerToTransferNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    self.offerToTransferYesBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    self.isOfferToTransferToOtherYesEnable = true
                    self.profileAcceptedtextFldStackVw?.isHidden = false
                    self.profileAcceptedtextFldStackVwHeight?.constant = 45
                    self.isOfferToTransferToOtherNoEnable = false
                } else {
                    self.offerToTransferNoBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    self.offerToTransferYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    self.isOfferToTransferToOtherNoEnable = true
                    self.isOfferToTransferToOtherYesEnable = false
                    self.profileAcceptedtextFldStackVw?.isHidden = true
                    self.profileAcceptedtextFldStackVwHeight?.constant = 0
                }
            } else {
                self.offerToTransferBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.offerToTransferSubOptionsStackVwHeight?.constant = 0
            }
            
            if (patientDetail.extendValidityUpdateSystemAMChecklist ?? false) {
                self.extendValidityBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.updateSystemStackVwHeight?.constant = 45
                self.updateSystemBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.extendValidityBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.updateSystemStackVwHeight?.constant = 0
            }
            
            if (patientDetail.transferToFriendsRelatives ?? false) {
                self.transferToFamilyBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.transferToFamilyBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.offerToSeeSeniorConsultantAMChecklist ?? false) {
                self.offerToSeeSeniorConsultantBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.offerToSeeSeniorConsultantSubOptionsheight?.constant = 180
                self.offerToSeeSeniorConsultantStackVw?.isHidden = false
                if (patientDetail.offerToSeeSeniorConsultantNo ?? false) {
                    self.offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    self.acceptanceDateStackVw?.isHidden = false
                } else {
                    self.offerToSeeSeniorConsultantNoBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    self.acceptanceDateStackVw?.isHidden = true
                    if (patientDetail.yesArrangeTransferOfFileSrCon ?? false) {
                        self.offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                    } else {
                        self.offerToSeeSeniorConsultantYesBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                    }
                    if (patientDetail.scheduleAppointmentSeniorConsultant ?? false) {
                        self.scheduleAppointmnetBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                        self.acceptanceDateStackVw?.isHidden = false
                    } else {
                        self.scheduleAppointmnetBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                        self.acceptanceDateStackVw?.isHidden = true
                    }
                }
                
            } else {
                self.offerToSeeSeniorConsultantBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.offerToSeeSeniorConsultantStackVw?.isHidden = true
                self.offerToSeeSeniorConsultantSubOptionsheight?.constant = 0
            }
            
            if (patientDetail.refundWithAmountBalanceAMChecklist ?? false) {
                self.refundWithAmountBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.refundWithAmountBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.noRefundValueAMChecklist ?? false) {
                self.noRefundValueBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.noRefundValueStackViewHeight?.constant = 70
                self.noRefundValueStackVw?.isHidden = false
                if (patientDetail.noRefundValueCaseClose ?? false) {
                    self.caseClosedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                } else {
                    self.caseClosedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                }
                if (patientDetail.noRefundValuePursueWithOM ?? false) {
                    self.noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                } else {
                    self.noRefundValuePursueWithOMBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                }
            } else {
                self.noRefundValueBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.noRefundValueStackVw?.isHidden = true
                self.noRefundValueStackViewHeight?.constant = 0
            }
            
            if (patientDetail.speakToHigherAuthorityAMChecklist ?? false) {
                self.speakToHigherAuthorityBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.speakToHigherAuthorityBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            self.AMCheckListCommentTextVwHeight?.constant = 0
            self.AMCheckListCommentLbl?.text = patientDetail.AM_Comments__c
            self.AMTxtCount?.text = ""
            self.AMTotalTxtCount?.text = ""
            
            // Senior Consultant
            
            if (patientDetail.patientToContinueCareWithSeniorCon ?? false) {
                self.patientToContinueWithSeniorConsultantBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.patientToContinueWithSeniorConsultantBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
           
            if (patientDetail.patientToContinueCareWithFormerCD ?? false) {
                self.patientToContinueWithClinicDoctoreBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.patientToContinueWithClinicDoctoreBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.patientToTransferToOtherDoctorAM ?? false) {
                self.PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.refundWithAmountBalanceSrConsultant ?? false) {
                self.refundWithAmountBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.refundWithAmountBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.seniorConsultantOthers ?? false) {
                self.OtherBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.OtherTextViewHeight?.constant = 0
                self.seniorConsulatantOtherCommentsHeadingLbl?.text = "Comments"
                self.seniorConsultantCommentLbl?.text = patientDetail.Senior_Consultant_Others_Comments__c
            } else {
                self.OtherBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.OtherTextViewHeight?.constant = 0
                self.OtherTotalTxtCount?.text = ""
                self.OtherTxtCount?.text = ""
                self.seniorConsultantCommentLbl?.text = ""
                self.seniorConsulatantOtherCommentsHeadingLbl?.text = ""
                self.OtherTextViewHeight?.constant = 0
            }
            // AM FollowUp
            
            if (patientDetail.patientToContinueCareWFormerCDAM ?? false) {
                self.PatientToContinueCareBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.TransferFileBackStackVw?.isHidden = false
                self.isPatientToTransferToOtherDoctorAMFollowUp = false
                self.isPatientToTransferToOtherDoctorAMFollowUpTransferFile = false
                self.isRefundWithAmountBalnaceAMFollowUp = false
            } else {
                self.PatientToContinueCareBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.isPatientToContinueCareWithAMFollowUpTransferFileEnabled = false
                self.TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.TransferFileBackStackVw?.isHidden = true
                self.TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
            }
            
            if (patientDetail.transferFileBackToFormerClinicAM ?? false) {
                self.TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.TransferFileBackAcceptanceTextFieldStackVw?.isHidden = false
                self.TransferFileBackAcceptanceTextField?.text = patientDetail.Transfer_File_Acceptance_Date_AM__c
            } else {
                self.TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.TransferFileBackAcceptanceTextFieldStackVw?.isHidden = true
            }
            
            if (patientDetail.patientToTransferToOtherDrAMFollow ?? false) {
                self.PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.PatientToTransferToOtherDoctorStackVw?.isHidden = false
            } else {
                self.PatientToTransferToOtherDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if (patientDetail.transferFileToOtherDoctorAMFollow ?? false) {
                self.TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                self.PatientToTransferAcceptanceDateStackVw?.isHidden = false
                self.PatientToTransferAcceptanceDateTextField?.text = patientDetail.Transfer_File_Acceptance_Date_AM__c == "NA" ? "" : patientDetail.Transfer_File_Acceptance_Date_AM__c
            } else {
                self.TransferFileBackToFormerClinicBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                self.PatientToTransferAcceptanceDateStackVw?.isHidden = true
            }
            
            if (patientDetail.refundWithAmountBalanceAMFollowUp ?? false) {
                self.refundWithAmountBalanceBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.refundWithAmountBalanceBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            if ((patientDetail.patientToContinueCareWFormerCDAM ?? false) || (patientDetail.transferFileBackToFormerClinicAM ?? false) || (patientDetail.patientToTransferToOtherDrAMFollow ?? false) || (patientDetail.transferFileToOtherDoctorAMFollow ?? false) || (patientDetail.refundWithAmountBalanceAMFollowUp ?? false)) {
                self.AMRemarksTextViewHeight?.constant = 0
                self.AMFollowUpCommentsLbl?.text = patientDetail.AM_Closing_Comment__c
                self.AMRemarksTxtCount?.text = ""
                self.AMRemarksTotalTxtCount?.text = ""
            }
            
            // OM Comment
            
            if (patientDetail.reviewAndApproveRefundOMComments ?? false) {
                self.reviewApprovedRefundBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.reviewApprovedRefundBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.caseCloseOMComments ?? false) {
                self.caseClosedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.caseClosedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
            self.OMCommentsTextViewHeight?.constant = 0
            self.OMCommentsCommentsLbl?.text = patientDetail.AM_Closing_Comment__c
            self.OMCommentsTxtCount?.text = ""
            self.OMCommentsTotalTxtCount?.text = ""
            
            // System Admin Comment
            if (patientDetail.reviewedBySystemAdmin ?? false) {
                self.reviewedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.reviewedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.caseyApproved ?? false) {
                self.approvedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.approvedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if ((patientDetail.caseyApproved ?? false) || (patientDetail.caseyApproved ?? false)) {
                self.systemAdminTextViewHeight?.constant = 0
                self.systemAdminCommentsLbl?.text = patientDetail.System_Admin_Comments__c
                self.systemAdminTxtCount?.text = ""
                self.systemAdminTotalTxtCount?.text = ""
            }
            
            // Finanace remarks
            if (patientDetail.processPayment ?? false) {
                self.processPaymentBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.processPaymentBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            if (patientDetail.bankDetails ?? false) {
                self.bankdetailsBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                self.bankdetailsBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
            
        }
        manageScreenAccordingToRole()
    }
    
    func manageScreenAccordingToRole() {
        let userRoleEnum = Defaults.userRole
        print("userRoleEnummmmm \(userRoleEnum ?? "")")
        reloactingBtn?.isEnabled = false
        clinicLocationBtn?.isEnabled = false
        clinicOperatingBtn?.isEnabled = false
        subsidyPlanBtn?.isEnabled = false
        problemResolvedBtn?.isEnabled = false
        problemNotResolvedBtn?.isEnabled = false
        issueInQualityBtn?.isEnabled = false
        issueWithDoctorBtn?.isEnabled = false
        issueWithStaffBtn?.isEnabled = false
        othersTermination?.isEnabled = false
        if pendingRefundModel?.status == "Pending" && userRoleEnum == "Clinic FD/Supervisors" {
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            } else {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            }
            AMCheckListStackVw?.isHidden = true
            SeniorConsultantCommentsStackVw?.isHidden = true
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            commentLbl?.text = ""
            spokenWithPatientTxtCount?.text = ""
            spokenWithPatientTotalTxtCount?.text = ""
            spokenWithPatientNoTxtCount?.text = ""
            spokenWithPatientNoTotalTxtCount?.text = ""
            return
        } else if pendingRefundModel?.status == "Pending AM/Doctor Comments" && userRoleEnum == "Doctor" && (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
            
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = true
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending Review with Clinic Doctor" && userRoleEnum == "Doctor" &&  (!(pendingRefundModel?.nonComplianceOnCPFrequencyVisit ?? true) && !(pendingRefundModel?.spokenCounselledMultipleTimes ?? true) && !(pendingRefundModel?.clinicDoctorOthers ?? true) && !(pendingRefundModel?.difficultPatientAlwaysComplaining ?? true)) {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            clinicDoctorStackVw?.isHidden = false
            doctorReviewCommentsStackVw?.isHidden = true
            AMCheckListStackVw?.isHidden = true
            SeniorConsultantCommentsStackVw?.isHidden = true
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
            
        } else if pendingRefundModel?.status == "Pending Review with Clinic Doctor" && userRoleEnum == "Doctor" && ((pendingRefundModel?.nonComplianceOnCPFrequencyVisit ?? false) || (pendingRefundModel?.spokenCounselledMultipleTimes ?? false) || (pendingRefundModel?.clinicDoctorOthers ?? false) || (pendingRefundModel?.difficultPatientAlwaysComplaining ?? false)) {
            
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            clinicDoctorStackVw?.isHidden = false
            doctorReviewCommentsStackVw?.isHidden = false
            AMCheckListStackVw?.isHidden = true
            SeniorConsultantCommentsStackVw?.isHidden = true
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending AM Review" && userRoleEnum == "AM"  {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending Senior Consultant Review" && userRoleEnum == "Senior Consultant" {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            reviewClinicManagerBtn?.isEnabled = false
            callPatientBtn?.isEnabled = false
            offerToTransferBtn?.isEnabled = false
            offerToTransferNoBtn?.isEnabled = false
            offerToTransferYesBtn?.isEnabled = false
            extendValidityBtn?.isEnabled = false
            updateSystemBtn?.isEnabled = false
            transferToFamilyBtn?.isEnabled = false
            offerToSeeSeniorConsultantBtn?.isEnabled = false
            offerToSeeSeniorConsultantNoBtn?.isEnabled = false
            offerToSeeSeniorConsultantYesBtn?.isEnabled = false
            scheduleAppointmnetBtn?.isEnabled = false
            refundWihAmountBalanceBtn?.isEnabled = false
            noRefundValueBtn?.isEnabled = false
            noRefundValueCloseCaseBtn?.isEnabled = false
            noRefundValuePursueWithOMBtn?.isEnabled = false
            speakToHigherAuthorityBtn?.isEnabled = false
            callPatientTextView?.isEditable = false
            AMTextView?.isEditable = false
            scheduleAppointmentTextFld?.isEnabled = false
            profileAcceptedtextFld?.isEnabled = false
            acceptanceDatetextFldBtn?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending AM Follow Up" && userRoleEnum == "AM" {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            reviewClinicManagerBtn?.isEnabled = false
            callPatientBtn?.isEnabled = false
            offerToTransferBtn?.isEnabled = false
            offerToTransferNoBtn?.isEnabled = false
            offerToTransferYesBtn?.isEnabled = false
            extendValidityBtn?.isEnabled = false
            updateSystemBtn?.isEnabled = false
            transferToFamilyBtn?.isEnabled = false
            offerToSeeSeniorConsultantBtn?.isEnabled = false
            offerToSeeSeniorConsultantNoBtn?.isEnabled = false
            offerToSeeSeniorConsultantYesBtn?.isEnabled = false
            scheduleAppointmnetBtn?.isEnabled = false
            refundWihAmountBalanceBtn?.isEnabled = false
            noRefundValueBtn?.isEnabled = false
            noRefundValueCloseCaseBtn?.isEnabled = false
            noRefundValuePursueWithOMBtn?.isEnabled = false
            speakToHigherAuthorityBtn?.isEnabled = false
            callPatientTextView?.isEditable = false
            AMTextView?.isEditable = false
            scheduleAppointmentTextFld?.isEnabled = false
            profileAcceptedtextFld?.isEnabled = false
            acceptanceDatetextFldBtn?.isEnabled = false
            
            patientToContinueWithSeniorConsultantBtn?.isEnabled = false
            patientToContinueWithClinicDoctoreBtn?.isEnabled = false
            patientToTransferBtn?.isEnabled = false
            refundWithAmountBtn?.isEnabled = false
            OtherBtn?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = false
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        }  else if pendingRefundModel?.status == "Pending OM Review"  && userRoleEnum == "OM" {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            reviewClinicManagerBtn?.isEnabled = false
            callPatientBtn?.isEnabled = false
            offerToTransferBtn?.isEnabled = false
            offerToTransferNoBtn?.isEnabled = false
            offerToTransferYesBtn?.isEnabled = false
            extendValidityBtn?.isEnabled = false
            updateSystemBtn?.isEnabled = false
            transferToFamilyBtn?.isEnabled = false
            offerToSeeSeniorConsultantBtn?.isEnabled = false
            offerToSeeSeniorConsultantNoBtn?.isEnabled = false
            offerToSeeSeniorConsultantYesBtn?.isEnabled = false
            scheduleAppointmnetBtn?.isEnabled = false
            refundWihAmountBalanceBtn?.isEnabled = false
            noRefundValueBtn?.isEnabled = false
            noRefundValueCloseCaseBtn?.isEnabled = false
            noRefundValuePursueWithOMBtn?.isEnabled = false
            speakToHigherAuthorityBtn?.isEnabled = false
            callPatientTextView?.isEditable = false
            AMTextView?.isEditable = false
            scheduleAppointmentTextFld?.isEnabled = false
            profileAcceptedtextFld?.isEnabled = false
            acceptanceDatetextFldBtn?.isEnabled = false
            
            patientToContinueWithSeniorConsultantBtn?.isEnabled = false
            patientToContinueWithClinicDoctoreBtn?.isEnabled = false
            patientToTransferBtn?.isEnabled = false
            refundWithAmountBtn?.isEnabled = false
            OtherBtn?.isEnabled = false
            
            PatientToContinueCareBtn?.isEnabled = false
            TransferFileBackToFormerClinicBtn?.isEnabled = false
            PatientToTransferToOtherDoctorBtn?.isEnabled = false
            transferFileBtn?.isEnabled = false
            refundWithAmountBalanceBtn?.isEnabled = false
            TransferFileBackAcceptanceTextField?.isEnabled = false
            PatientToTransferAcceptanceDateTextField?.isEnabled = false
            
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = false
            OMCommentStackVw?.isHidden = false
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending System Admin Approval" && (userRoleEnum == "Admin" || userRoleEnum == "OM") {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            reviewClinicManagerBtn?.isEnabled = false
            callPatientBtn?.isEnabled = false
            offerToTransferBtn?.isEnabled = false
            offerToTransferNoBtn?.isEnabled = false
            offerToTransferYesBtn?.isEnabled = false
            extendValidityBtn?.isEnabled = false
            updateSystemBtn?.isEnabled = false
            transferToFamilyBtn?.isEnabled = false
            offerToSeeSeniorConsultantBtn?.isEnabled = false
            offerToSeeSeniorConsultantNoBtn?.isEnabled = false
            offerToSeeSeniorConsultantYesBtn?.isEnabled = false
            scheduleAppointmnetBtn?.isEnabled = false
            refundWihAmountBalanceBtn?.isEnabled = false
            noRefundValueBtn?.isEnabled = false
            noRefundValueCloseCaseBtn?.isEnabled = false
            noRefundValuePursueWithOMBtn?.isEnabled = false
            speakToHigherAuthorityBtn?.isEnabled = false
            callPatientTextView?.isEditable = false
            AMTextView?.isEditable = false
            scheduleAppointmentTextFld?.isEnabled = false
            profileAcceptedtextFld?.isEnabled = false
            acceptanceDatetextFldBtn?.isEnabled = false
            
            patientToContinueWithSeniorConsultantBtn?.isEnabled = false
            patientToContinueWithClinicDoctoreBtn?.isEnabled = false
            patientToTransferBtn?.isEnabled = false
            refundWithAmountBtn?.isEnabled = false
            OtherBtn?.isEnabled = false
            
            PatientToContinueCareBtn?.isEnabled = false
            TransferFileBackToFormerClinicBtn?.isEnabled = false
            PatientToTransferToOtherDoctorBtn?.isEnabled = false
            transferFileBtn?.isEnabled = false
            refundWithAmountBalanceBtn?.isEnabled = false
            TransferFileBackAcceptanceTextField?.isEnabled = false
            PatientToTransferAcceptanceDateTextField?.isEnabled = false
            
            reviewApprovedRefundBtn?.isEnabled = false
            caseClosedBtn?.isEnabled = false
            
//            reviewedBtn?.isEnabled = false
//            approvedBtn?.isEnabled = false
//            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = false
            OMCommentStackVw?.isHidden = false
            SystemAdminStackVw?.isHidden = false
            financeRemarkStackVw?.isHidden = true
            return
        } else if pendingRefundModel?.status == "Pending Finance Preparation"  && userRoleEnum == "Finance"  {
            spokenWithPatientNoButton?.isEnabled = false
            spokenWithPatientYesButton?.isEnabled = false
            spokenWithPatient?.isEnabled = false
            
            difficultPatientBtn?.isEnabled = false
            nonComplianceBtn?.isEnabled = false
            spokenCounselledBtn?.isEnabled = false
            othersBtn?.isEnabled = false
            
            reviewClinicManagerBtn?.isEnabled = false
            callPatientBtn?.isEnabled = false
            offerToTransferBtn?.isEnabled = false
            offerToTransferNoBtn?.isEnabled = false
            offerToTransferYesBtn?.isEnabled = false
            extendValidityBtn?.isEnabled = false
            updateSystemBtn?.isEnabled = false
            transferToFamilyBtn?.isEnabled = false
            offerToSeeSeniorConsultantBtn?.isEnabled = false
            offerToSeeSeniorConsultantNoBtn?.isEnabled = false
            offerToSeeSeniorConsultantYesBtn?.isEnabled = false
            scheduleAppointmnetBtn?.isEnabled = false
            refundWihAmountBalanceBtn?.isEnabled = false
            noRefundValueBtn?.isEnabled = false
            noRefundValueCloseCaseBtn?.isEnabled = false
            noRefundValuePursueWithOMBtn?.isEnabled = false
            speakToHigherAuthorityBtn?.isEnabled = false
            callPatientTextView?.isEditable = false
            AMTextView?.isEditable = false
            scheduleAppointmentTextFld?.isEnabled = false
            profileAcceptedtextFld?.isEnabled = false
            acceptanceDatetextFldBtn?.isEnabled = false
            
            patientToContinueWithSeniorConsultantBtn?.isEnabled = false
            patientToContinueWithClinicDoctoreBtn?.isEnabled = false
            patientToTransferBtn?.isEnabled = false
            refundWithAmountBtn?.isEnabled = false
            OtherBtn?.isEnabled = false
            
            PatientToContinueCareBtn?.isEnabled = false
            TransferFileBackToFormerClinicBtn?.isEnabled = false
            PatientToTransferToOtherDoctorBtn?.isEnabled = false
            transferFileBtn?.isEnabled = false
            refundWithAmountBalanceBtn?.isEnabled = false
            TransferFileBackAcceptanceTextField?.isEnabled = false
            PatientToTransferAcceptanceDateTextField?.isEnabled = false
            
            reviewApprovedRefundBtn?.isEnabled = false
            caseClosedBtn?.isEnabled = false
            
            reviewedBtn?.isEnabled = false
            approvedBtn?.isEnabled = false
            
            clinicManagerStackVw?.isHidden = false
            if (pendingRefundModel?.offeredReviewWithCDNo ?? false) {
                clinicDoctorStackVw?.isHidden = true
                doctorReviewCommentsStackVw?.isHidden = true
            } else {
                clinicDoctorStackVw?.isHidden = false
                doctorReviewCommentsStackVw?.isHidden = false
            }
            AMCheckListStackVw?.isHidden = false
            SeniorConsultantCommentsStackVw?.isHidden = false
            AMFollowUpStackVw?.isHidden = false
            OMCommentStackVw?.isHidden = false
            SystemAdminStackVw?.isHidden = false
            financeRemarkStackVw?.isHidden = false
            return
        } else {
            clinicManagerStackVw?.isHidden = true
            clinicDoctorStackVw?.isHidden = true
            doctorReviewCommentsStackVw?.isHidden = true
            AMCheckListStackVw?.isHidden = true
            SeniorConsultantCommentsStackVw?.isHidden = true
            AMFollowUpStackVw?.isHidden = true
            OMCommentStackVw?.isHidden = true
            SystemAdminStackVw?.isHidden = true
            financeRemarkStackVw?.isHidden = true
            let checkInalert = UIAlertController(
                title: "Info",
                message: "You do not have permission to edit this ticket.",
                preferredStyle: .alert
            )
            self.present(checkInalert, animated: true, completion: nil)
            checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                print("Cancel tapped")
            }))
            return
        }
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
        spokenWithPatientYesTextFld?.inputAccessoryView = toolbar
        spokenWithPatientYesTextFld?.inputView = datePicker
        profileAcceptedtextFld?.inputAccessoryView = toolbar
        profileAcceptedtextFld?.inputView = datePicker
        acceptanceDatetextFldBtn?.inputAccessoryView = toolbar
        acceptanceDatetextFldBtn?.inputView = datePicker
        scheduleAppointmentTextFld?.inputAccessoryView = toolbar
        scheduleAppointmentTextFld?.inputView = datePicker
        TransferFileBackAcceptanceTextField?.inputAccessoryView = toolbar
        TransferFileBackAcceptanceTextField?.inputView = datePicker
        PatientToTransferAcceptanceDateTextField?.inputAccessoryView = toolbar
        PatientToTransferAcceptanceDateTextField?.inputView = datePicker
        
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        if (spokenWithPatientYesTextFld?.isFirstResponder ?? true) {
            spokenWithPatientYesTextFld?.text = selectedDate
        } else if (profileAcceptedtextFld?.isFirstResponder ?? true) {
            profileAcceptedtextFld?.text = selectedDate
        } else if (acceptanceDatetextFldBtn?.isFirstResponder ?? true) {
            acceptanceDatetextFldBtn?.text = selectedDate
        } else if (scheduleAppointmentTextFld?.isFirstResponder ?? true) {
            scheduleAppointmentTextFld?.text = selectedDate
        } else if (TransferFileBackAcceptanceTextField?.isFirstResponder ?? true) {
            TransferFileBackAcceptanceTextField?.text = selectedDate
        } else if (PatientToTransferAcceptanceDateTextField?.isFirstResponder ?? true) {
            PatientToTransferAcceptanceDateTextField?.text = selectedDate
        }
        self.view.endEditing(true)
        
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction() {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "PendingCases", bundle: storyboardBundle)
        let ClinicManagerVC = storyboard.instantiateViewController(withIdentifier: "ClinicManagerVC") as! ClinicManagerVC
        self.navigationController?.pushViewController(ClinicManagerVC, animated: true)
    }
}

extension PendingCaseDetailVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == spokenWithPatientYesTextFld {
            self.createDatePicker()
        } else if textField == profileAcceptedtextFld {
            self.createDatePicker()
        } else if textField == acceptanceDatetextFldBtn {
            self.createDatePicker()
        } else if textField == scheduleAppointmentTextFld {
            self.createDatePicker()
        } else if textField == TransferFileBackAcceptanceTextField {
            self.createDatePicker()
        } else if textField == PatientToTransferAcceptanceDateTextField {
            self.createDatePicker()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentTextCount = textView.text.count
        
        if textView == spokenWithPatientTextView {
            spokenWithPatientTxtCount?.text = "\(currentTextCount)"
        } else if textView == spokenWithPatientNoTextView {
            spokenWithPatientNoTxtCount?.text = "\(currentTextCount)"
        } else if textView == othersBtnTextView {
            othersBtnTxtCount?.text = "\(currentTextCount)"
        } else if textView == doctorReviewTextView {
            doctorReviewTxtCount?.text = "\(currentTextCount)"
        } else if textView == callPatientTextView {
            callPatientBtnTxtCount?.text = "\(currentTextCount)"
        } else if textView == AMTextView {
            AMTxtCount?.text = "\(currentTextCount)"
        } else if textView == seniorConsultantOtherTextView {
            OtherTxtCount?.text = "\(currentTextCount)"
        } else if textView == AMRemarksTextView {
            AMRemarksTxtCount?.text = "\(currentTextCount)"
        } else if textView == OMCommentsTextView {
            OMCommentsTxtCount?.text = "\(currentTextCount)"
        } else if textView == systemAdminTextView {
            systemAdminTxtCount?.text = "\(currentTextCount)"
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
}


