//
//  PendingRedFlagModel.swift
//  CFGApp
//
//  Created by Sakshi on 10/02/25.
//

import Foundation

struct PendingRedFlagModel {
    var id: String
    var ownerId: String
    var name: String
    var status: String
    var concern: String
    var doctorId: String
    var financialBalance: String
    var typeOfSubsidyPlan: String
    var frequency: String
    var isConcernResolved: String
    var supervisorManagerRemarks: String
    var patientRetention: String
    var clinicDoctorRemarks: String
    var transferToOtherDoctor: String
    var offerDTService: String
    var offerSWTService: String
    var consultSeniorConsultant: String
    var consultTCMService: String
    var areaManagerRemarks: String
    var finishUpSubsidyPlan: String
    var transferBalanceToFamily: String
    var extendSubsidyPlanValidity: String
    var refund: String
    var closedDate: String
    var patientHealthCardId: String
    var clinicSupervisorSubmittedAt: String
    var clinicDoctorSubmittedAt: String
    var clinicAMSubmittedAt: String
    var retainInCurrentClinic: String
    var createdDate: String
    var patient: RelatedEntity?
    var clinic: RelatedEntity?
    var doctor: RelatedEntity?
    var patientHealthCard: RelatedEntity?
    
    struct RelatedEntity {
        var id: String
        var name: String
        var attributes: Attributes?
    }
    
    struct Attributes {
        var type: String
        var url: String
    }
    
    init(dict: [String: Any]?) {
        
        func getStringValue(_ key: String) -> String {
            if let value = dict?[key], !(value is NSNull) {
                
                if let intValue = value as? Int {
                    return String(intValue)
                } else if let strValue = value as? String, !strValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return strValue
                } else if let doubleValue = value as? Double {
                    return String(doubleValue)
                }
            }
            return "NA"
        }
        
        func getBoolValue(_ key: String) -> String {
            if let value = dict?[key] as? Bool {
                return value ? "Yes" : "No"
            }
            return "NA"
        }
        
        self.id = getStringValue("Id")
        self.ownerId = getStringValue("OwnerId")
        self.name = getStringValue("Name")
        self.status = getStringValue("Status__c")
        self.concern = getStringValue("Concern__c")
        self.doctorId = getStringValue("Doctor__c")
        self.financialBalance = getStringValue("Financial_Balance__c")
        self.typeOfSubsidyPlan = getStringValue("Type_of_Subsidy_Plan__c")
        self.frequency = getStringValue("Frequency__c")
        self.isConcernResolved = getStringValue("Is_concern_resolved__c")
        self.supervisorManagerRemarks = getStringValue("Supervisor_Manager_Remarks__c")
        self.patientRetention = getStringValue("Patient_Retention__c")
        self.clinicDoctorRemarks = getStringValue("Clinic_Doctor_Remarks__c")
        self.transferToOtherDoctor = getBoolValue("Transfer_to_other_Dr_in_other_Clinic__c")
        self.offerDTService = getBoolValue("Offer_DT_Service__c")
        self.offerSWTService = getBoolValue("Offer_SWT_SIT_Service__c")
        self.consultSeniorConsultant = getBoolValue("Consult_Senior_Consultant__c")
        self.consultTCMService = getBoolValue("Consult_TCM_Service__c")
        self.areaManagerRemarks = getStringValue("Area_Manager_Remarks__c")
        self.finishUpSubsidyPlan = getBoolValue("Finish_Up_Subsidy_Plan__c")
        self.transferBalanceToFamily = getBoolValue("Transfer_Balance_to_Family_Friends__c")
        self.extendSubsidyPlanValidity = getBoolValue("Extend_Subsidy_Plan_Validity_Period__c")
        self.refund = getBoolValue("Refund__c")
        self.closedDate = getStringValue("Closed_Date__c")
        self.patientHealthCardId = getStringValue("Patient_Health_Card__c")
        self.clinicSupervisorSubmittedAt = getStringValue("Clinic_Supervisor_Manager_Submitted_At__c")
        self.clinicDoctorSubmittedAt = getStringValue("Clinic_Doctor_Submitted_At__c")
        self.clinicAMSubmittedAt = getStringValue("Clinic_AM_Submitted_At__c")
        self.retainInCurrentClinic = getBoolValue("Retain_in_Current_Clinic__c")
        self.createdDate = getStringValue("CreatedDate")
        if let patientDict = dict?["Patient__r"] as? [String: Any] {
            let attributesDict = patientDict["attributes"] as? [String: Any] ?? [:]
            self.patient = RelatedEntity(
                id: patientDict["Id"] as? String ?? "NA",
                name: patientDict["Name"] as? String ?? "NA",
                attributes: Attributes(
                    type: attributesDict["type"] as? String ?? "NA",
                    url: attributesDict["url"] as? String ?? "NA"
                )
            )
        }
        
        if let clinicDict = dict?["Clinic__r"] as? [String: Any] {
            let attributesDict = clinicDict["attributes"] as? [String: Any] ?? [:]
            self.clinic = RelatedEntity(
                id: clinicDict["Id"] as? String ?? "NA",
                name: clinicDict["Name"] as? String ?? "NA",
                attributes: Attributes(
                    type: attributesDict["type"] as? String ?? "NA",
                    url: attributesDict["url"] as? String ?? "NA"
                )
            )
        }
        
        if let doctorDict = dict?["Doctor__r"] as? [String: Any] {
            let attributesDict = doctorDict["attributes"] as? [String: Any] ?? [:]
            self.doctor = RelatedEntity(
                id: doctorDict["Id"] as? String ?? "NA",
                name: doctorDict["Name"] as? String ?? "NA",
                attributes: Attributes(
                    type: attributesDict["type"] as? String ?? "NA",
                    url: attributesDict["url"] as? String ?? "NA"
                )
            )
        }
        
        if let healthCardDict = dict?["Patient_Health_Card__r"] as? [String: Any] {
            let attributesDict = healthCardDict["attributes"] as? [String: Any] ?? [:]
            self.patientHealthCard = RelatedEntity(
                id: healthCardDict["Id"] as? String ?? "NA",
                name: healthCardDict["Name"] as? String ?? "NA",
                attributes: Attributes(
                    type: attributesDict["type"] as? String ?? "NA",
                    url: attributesDict["url"] as? String ?? "NA"
                )
            )
        }
    }
}
