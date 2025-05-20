//
//  PendingRefundModel.swift
//  CFGApp
//
//  Created by Sakshi on 26/02/25.
//

import Foundation

struct PatientHealthCard {
    var id: String
    var cardNumber: String
    var expiryDate: String
    var issuingAuthority: String
    var financialBalance: Int
    var planStartDate: String
    var serviceType: String
}

struct Patient {
    var id: String
    var name: String
    var nric: String
    var contactNumber: String
    var email: String
    var dateOfBirth: String
    var gender: String
}

struct Clinic {
    var id: String
    var name: String
    var location: String
    var contactNumber: String
    var email: String
    var operatingHours: String
}

struct Doctor {
    var id: String
    var name: String
    var specialization: String
    var contactNumber: String
    var email: String
}

struct PendingRefundModel {
    let patientHealthCardID: String?
    let doctorID: String?
    let clinicID: String?
    let patientID: String?
    let id: String?
    let ownerID: String?
    let isDeleted: Bool?
    let name: String?
    let createdDate: String?
    let createdByID: String?
    let lastModifiedDate: String?
    let lastModifiedByID: String?
    let systemModstamp: String?
    let lastViewedDate: String?
    let lastReferencedDate: String?
    
    let offerExtensionOfVisitsUsage: Bool?
    let offerSecondReviewWithChiropractor: Bool?
    let offerTransferClinicOrDoctor: Bool?
    let offerTransferToFamilyMembers: Bool?
    let recovered: Bool?
    let transactionEnteredByFinance: Bool?
    
    let nricPassportNo: String?
    let contact: String?
    
    let advisedToDiscontinueTreatment: Bool?
    let Were_you_advised_to_discontinue_by_whom__c: String?
    let relocating: Bool?
    let clinicLocationInconvenient: Bool?
    let clinicOperatingHoursNotFit: Bool?
    let subsidyPlanNotWithinBudget: Bool?
    let problemsResolved: Bool?
    let problemsNotResolved: Bool?
    let issueWithQualityOfService: Bool?
    let issueWithDoctor: Bool?
    let issueWithStaff: Bool?
    
    let nameAsReflectedInBankAC: String?
    let bankName: String?
    let bankACNo: String?
    let date: String?
    let status: String?
    let transferToOtherDoctor: Bool?
    let extendPlanExpiry: Bool?
    let refund: Bool?
    let caseyApproved: Bool?
    let transferToFriendsRelatives: Bool?
    let wereYouAdvisedToDiscontinueTreatment: Bool?
    let extendPlanExpiryAM: Bool?
    let bankContactNo: String?
    let formFillUpDate: String?
    let transferToOtherDoctorAM: Bool?
    let subsidyPlan: String?
    let spokenToPatient: Bool?
    let Spoken_to_Patient_Comments__c: String?
    let Offered_Review_with_CD_No_Why__c: String?
    
    let offeredReviewWithCDYes: Bool?
    let offeredReviewWithCDNo: Bool?
    let offeredReviewWithCDAppDate: String?
    
    let difficultPatientAlwaysComplaining: Bool?
    let nonComplianceOnCPFrequencyVisit: Bool?
    let spokenCounselledMultipleTimes: Bool?
    let clinicDoctorOthers: Bool?
    let Doctor_s_Comment__c: String?
    let Clinic_Doctor_Others_Reason__c: String?
    
    let reviewedClinicManagerDoctorRemarks: Bool?
    let callPatientAMChecklist: Bool?
    let Call_Patient_Comments_AM_Checklist__c: String?
    let yesArrangeTransferOfFileAMChecklist: Bool?
    let offerToTransferOtherClinicDoctorNo: Bool?
    let Yes_Arrange_Transfer_of_File_AM_Checklis__c: Bool?
    let extendValidityUpdateSystemAMChecklist: Bool?
    let offerToSeeSeniorConsultantAMChecklist: Bool?
    let yesArrangeTransferOfFileSrCon: Bool?
    let scheduleAppointmentSeniorConsultant: Bool?
    let offerToSeeSeniorConsultantNo: Bool?
    let AM_Comments__c: String?
    
    let refundWithAmountBalanceAMChecklist: Bool?
    let noRefundValueAMChecklist: Bool?
    let noRefundValueCaseClose: Bool?
    let noRefundValuePursueWithOM: Bool?
    let speakToHigherAuthorityAMChecklist: Bool?
    let patientToContinueCareWithSeniorCon: Bool?
    let patientToContinueCareWithFormerCD: Bool?
    let refundWithAmountBalanceSrConsultant: Bool?
    let seniorConsultantOthers: Bool?
    let Senior_Consultant_Others_Comments__c: String?
    let AM_Closing_Comment__c: String?
    let patientToContinueCareWFormerCDAM: Bool?
    let transferFileBackToFormerClinicAM: Bool?
    let Transfer_File_Acceptance_Date_AM__c: String?
    let patientToTransferToOtherDoctorAM: Bool?
    let patientToTransferToOtherDrAMFollow: Bool?
    let transferFileToOtherDoctorAMFollow: Bool?
    let refundWithAmountBalanceAMFollowUp: Bool?
    let reviewAndApproveRefundOMComments: Bool?
    let otherOMComments: Bool?
    let caseCloseOMComments: Bool?
    let reviewedBySystemAdmin: Bool?
    let approvedBySystemAdmin: Bool?
    let processPayment: Bool?
    let bankDetails: Bool?
    let System_Admin_Comments__c: String?
    var patientHealthCard: PatientHealthCard?
    var patient: Patient?
    var clinic: Clinic?
    var doctor: Doctor?
    
    init(dict: [String: Any]?) {
        func getStringValue(_ key: String) -> String {
            if let value = dict?[key] {
                if let intValue = value as? Int {
                    return String(intValue)
                } else if let strValue = value as? String, !strValue.isEmpty {
                    return strValue
                }
            }
            return "NA"
        }
        
        
        func getBoolValue(_ key: String) -> Bool {
            guard let value = dict?[key] else {
                print("Key \(key) not found in dictionary")
                return false
            }
            switch value {
            case let boolValue as Bool:
                return boolValue
            case let intValue as Int:
                return intValue == 1
            case let strValue as String:
                let lowercasedValue = strValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                return lowercasedValue == "true" || lowercasedValue == "1"
            default:
                return false
            }
        }
        
        
        self.patientHealthCardID = getStringValue("Patient_Health_Card__c")
        self.doctorID = getStringValue("Doctor__c")
        self.clinicID = getStringValue("Clinic__c")
        self.patientID = getStringValue("Patient__c")
        self.id = getStringValue("Id")
        self.ownerID = getStringValue("OwnerId")
        self.isDeleted = getBoolValue("IsDeleted")
        self.name = getStringValue("Name")
        self.createdDate = getStringValue("CreatedDate")
        self.createdByID = getStringValue("CreatedById")
        self.lastModifiedDate = getStringValue("LastModifiedDate")
        self.lastModifiedByID = getStringValue("LastModifiedById")
        self.systemModstamp = getStringValue("SystemModstamp")
        self.lastViewedDate = getStringValue("LastViewedDate")
        self.lastReferencedDate = getStringValue("LastReferencedDate")
        
        self.offerExtensionOfVisitsUsage = getBoolValue("Offer_extension_of_visits_usage__c")
        self.offerSecondReviewWithChiropractor = getBoolValue("Offer_second_review_with_chiropractor__c")
        self.offerTransferClinicOrDoctor = getBoolValue("Offer_transfer_clinic_or_doctor__c")
        self.offerTransferToFamilyMembers = getBoolValue("Offer_transfer_to_family_members__c")
        self.recovered = getBoolValue("Recovered__c")
        self.transactionEnteredByFinance = getBoolValue("Transaction_entered_by_Finance__c")
        
        self.nricPassportNo = getStringValue("NRIC_Passport_No__c")
        self.contact = getStringValue("Contact__c")
        
        self.advisedToDiscontinueTreatment = getBoolValue("Advised_To_Discontinue_Treatment__c")
        self.Were_you_advised_to_discontinue_by_whom__c = getStringValue("Were_you_advised_to_discontinue_by_whom__c")
        self.relocating = getBoolValue("I_m_Relocating__c")
        self.clinicLocationInconvenient = getBoolValue("Clinic_s_Location_is_Inconvenient_for_Me__c")
        self.clinicOperatingHoursNotFit = getBoolValue("Clinic_s_Operating_Hours_Does_not_Fit__c")
        self.subsidyPlanNotWithinBudget = getBoolValue("Subsidy_Plan_is_not_Within_my_Budget__c")
        self.problemsResolved = getBoolValue("My_Problems_Have_Been_Resolved__c")
        self.problemsNotResolved = getBoolValue("My_Problems_Have_Not_Been_Resolved__c")
        self.issueWithQualityOfService = getBoolValue("I_have_an_Issue_with_the_Quality_of_Serv__c")
        self.issueWithDoctor = getBoolValue("I_have_an_Issue_with_the_Doctor__c")
        self.issueWithStaff = getBoolValue("I_have_an_Issue_with_the_Staff_s__c")
        
        self.nameAsReflectedInBankAC = getStringValue("Name_as_reflected_in_Bank_A_C__c")
        self.bankName = getStringValue("Bank_Name__c")
        self.bankACNo = getStringValue("Bank_A_C_No__c")
        self.date = getStringValue("Date__c")
        self.status = getStringValue("Status__c")
        self.transferToOtherDoctor = getBoolValue("Transfer_to_Other_Doctor__c")
        self.extendPlanExpiry = getBoolValue("Extend_Plan_Expiry__c")
        self.refund = getBoolValue("Refund__c")
        self.caseyApproved = getBoolValue("Casey_Approved__c")
        self.transferToFriendsRelatives = getBoolValue("Transfer_to_friends_Relatives__c")
        self.wereYouAdvisedToDiscontinueTreatment = getBoolValue("Were_you_advised_to_discontinue_treatmen__c")
        self.extendPlanExpiryAM = getBoolValue("Extend_Plan_Expiry_AM__c")
        self.bankContactNo = getStringValue("Bank_Contact_No__c")
        self.formFillUpDate = getStringValue("Form_Fill_up_Date__c")
        self.transferToOtherDoctorAM = getBoolValue("Transfer_to_Other_Doctor_AM__c")
        self.subsidyPlan = getStringValue("Subsidy_Plan__c")
        self.spokenToPatient = getBoolValue("Spoken_to_Patient__c")
        self.Spoken_to_Patient_Comments__c = getStringValue("Spoken_to_Patient_Comments__c")
        self.AM_Closing_Comment__c = getStringValue("AM_Closing_Comment__c")
        self.AM_Comments__c = getStringValue("AM_Comments__c")
        self.Offered_Review_with_CD_No_Why__c = getStringValue("Offered_Review_with_CD_No_Why__c")
        self.offeredReviewWithCDYes = getBoolValue("Offered_Review_with_CD_Yes__c")
        self.offeredReviewWithCDNo = getBoolValue("Offered_Review_with_CD_No__c")
        self.offeredReviewWithCDAppDate = getStringValue("Offered_Review_With_CD_App_Date__c")

        self.difficultPatientAlwaysComplaining = getBoolValue("Difficult_Patient_Always_Complaining__c")
        self.nonComplianceOnCPFrequencyVisit = getBoolValue("Non_Compliance_on_CP_Frequency_Visit__c")
        self.spokenCounselledMultipleTimes = getBoolValue("Spoken_Counselled_Multiple_Times__c")
        self.clinicDoctorOthers = getBoolValue("Clinic_Doctor_Others__c")
        self.reviewedClinicManagerDoctorRemarks = getBoolValue("Reviewed_Clinic_Manager_Doctor_s_Remarks__c")
        self.Doctor_s_Comment__c = getStringValue("Doctor_s_Comment__c")
        self.Clinic_Doctor_Others_Reason__c = getStringValue("Clinic_Doctor_Others_Reason__c")

        self.callPatientAMChecklist = getBoolValue("Call_Patient_AM_Checklist__c")
        self.Call_Patient_Comments_AM_Checklist__c = getStringValue("Call_Patient_Comments_AM_Checklist__c")
        self.yesArrangeTransferOfFileAMChecklist = getBoolValue("Yes_Arrange_Transfer_of_File_AM_Checklis__c")
        self.offerToTransferOtherClinicDoctorNo = getBoolValue("Offer_to_Transfer_Other_Clinic_Doctor_NO__c")
        self.Yes_Arrange_Transfer_of_File_AM_Checklis__c = getBoolValue("Yes_Arrange_Transfer_of_File_AM_Checklis__c")
        self.extendValidityUpdateSystemAMChecklist = getBoolValue("Extend_Validity_Update_System_AM_Checkli__c")
        self.offerToSeeSeniorConsultantAMChecklist = getBoolValue("Offer_to_see_Senior_Consultant_AM_Check__c")
        self.yesArrangeTransferOfFileSrCon = getBoolValue("Yes_Arrange_Transfer_of_File_Sr_Con__c")
        self.scheduleAppointmentSeniorConsultant = getBoolValue("Schedule_Appointment_Senior_Consultant__c")
        self.offerToSeeSeniorConsultantNo = getBoolValue("Offer_to_see_Senior_Consultant_NO__c")
        self.Senior_Consultant_Others_Comments__c = getStringValue("Senior_Consultant_Others_Comments__c")

        self.refundWithAmountBalanceAMChecklist = getBoolValue("Refund_with_Amount_Balance_AM_Checklist__c")
        self.noRefundValueAMChecklist = getBoolValue("No_Refund_Value_AM_Checklist__c")
        self.noRefundValueCaseClose = getBoolValue("No_Refund_Value_Case_Close__c")
        self.noRefundValuePursueWithOM = getBoolValue("No_Refund_Value_Pursue_with_OM__c")
        self.speakToHigherAuthorityAMChecklist = getBoolValue("Speak_to_Higher_Authority_AM_Checklist__c")
        self.patientToContinueCareWithSeniorCon = getBoolValue("Patient_to_continue_care_with_Senior_Con__c")
        self.patientToContinueCareWithFormerCD = getBoolValue("Patient_to_continue_care_with_former_CD__c")
        self.refundWithAmountBalanceSrConsultant = getBoolValue("Refund_with_Amount_Balance_Sr_Consultant__c")
        self.seniorConsultantOthers = getBoolValue("Senior_Consultant_Others__c")
        self.patientToContinueCareWFormerCDAM = getBoolValue("Patient_to_continue_care_w_former_CD_AM__c")
        self.transferFileBackToFormerClinicAM = getBoolValue("Transfer_File_back_to_former_Clinic_AM__c")
        self.Transfer_File_Acceptance_Date_AM__c = getStringValue("Transfer_File_Acceptance_Date_AM__c")
        self.patientToTransferToOtherDoctorAM = getBoolValue("Patient_to_transfer_to_other_Doctor_AM__c")
        self.patientToTransferToOtherDrAMFollow = getBoolValue("Patient_to_transfer_to_other_Dr_AM_Follo__c")
        self.transferFileToOtherDoctorAMFollow = getBoolValue("Transfer_File_to_other_Doctor_AM_Follow__c")
        self.refundWithAmountBalanceAMFollowUp = getBoolValue("Refund_with_Amount_Balance_AM_Follow_Up__c")
        self.reviewAndApproveRefundOMComments = getBoolValue("Review_and_Approve_Refund_OM_Comments__c")
        self.System_Admin_Comments__c = getStringValue("System_Admin_Comments__c")
        self.otherOMComments = getBoolValue("Other_OM_Comments__c")
        self.caseCloseOMComments = getBoolValue("Case_Close_OM_Comments__c")
        self.reviewedBySystemAdmin = getBoolValue("Reviewed_by_System_Admin__c")
        self.approvedBySystemAdmin = getBoolValue("Approved_by_System_Admin__c")
        self.processPayment = getBoolValue("Process_Payment__c")
        self.bankDetails = getBoolValue("Bank_Details__c")
        
        if let healthCardDict = dict?["Patient_Health_Card__r"] as? [String: Any] {
            self.patientHealthCard = PatientHealthCard(
                id: healthCardDict["Id"] as? String ?? "NA",
                cardNumber: healthCardDict["Name"] as? String ?? "NA",
                expiryDate: healthCardDict["Expiry_Date__c"] as? String ?? "NA",
                issuingAuthority: healthCardDict["Issuing_Authority__c"] as? String ?? "NA",
                financialBalance: healthCardDict["Financial_Balance__c"] as? Int ?? 0,
                planStartDate: healthCardDict["Plan_Start_Date__c"] as? String ?? "NA",
                serviceType: healthCardDict["Service_Type__c"] as? String ?? "NA"
            )
        }
        
        if let patientDict = dict?["Patient__r"] as? [String: Any] {
            self.patient = Patient(
                id: patientDict["Id"] as? String ?? "NA",
                name: patientDict["Name"] as? String ?? "NA",
                nric: patientDict["NRIC__c"] as? String ?? "NA",
                contactNumber: patientDict["Contact_Number__c"] as? String ?? "NA",
                email: patientDict["Email__c"] as? String ?? "NA",
                dateOfBirth: patientDict["Date_of_Birth__c"] as? String ?? "NA",
                gender: patientDict["Gender__c"] as? String ?? "NA"
            )
        }
        
        // Parsing and saving Clinic
        if let clinicDict = dict?["Clinic__r"] as? [String: Any] {
            self.clinic = Clinic(
                id: clinicDict["Id"] as? String ?? "NA",
                name: clinicDict["Name"] as? String ?? "NA",
                location: clinicDict["Location__c"] as? String ?? "NA",
                contactNumber: clinicDict["Contact_Number__c"] as? String ?? "NA",
                email: clinicDict["Email__c"] as? String ?? "NA",
                operatingHours: clinicDict["Operating_Hours__c"] as? String ?? "NA"
            )
        }
        
        if let doctorDict = dict?["Doctor__r"] as? [String: Any] {
            self.doctor = Doctor(
                id: doctorDict["Id"] as? String ?? "NA",
                name: doctorDict["Name"] as? String ?? "NA",
                specialization: doctorDict["Specialization__c"] as? String ?? "NA",
                contactNumber: doctorDict["Contact_Number__c"] as? String ?? "NA",
                email: doctorDict["Email__c"] as? String ?? "NA"
            )
        }
    }
}
