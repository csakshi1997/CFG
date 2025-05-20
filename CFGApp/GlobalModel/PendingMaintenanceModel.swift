//
//  PendingMaintenanceModel.swift
//  CFGApp
//
//  Created by Sakshi on 30/01/25.
//


import Foundation

struct PendingMaintenanceModel {
    var id: String
    var userId: String
    var name: String
    var status: String
    var ticketType: String
    var issue: String
    var amRemarks: String
    var amRemarksDate: String
    var moRemarksDate: String
    var maintenanceOfficerRemarks: String
    var isIssueFixedByAM: String
    var isIssueFixedByMO: String
    var isIssueFixedByOV: String
    var Outsource_Vendor_Remarks_Date__c: String
    var Outsource_Vendor_Remarks__c: String
    var Is_this_Issue_Fixed_by_MO_Final__c: String
    var LastReferencedDate: String
    var LastViewedDate: String
    var Clinic__c: String
    var createdById: String
    var createdDate: String
    var lastModifiedById: String
    var lastModifiedDate: String
    var ReAssignedToMO__c: String
    var ownerId: String
    var Closed_Date__c: String
    var clinic: Clinic?
    var attachments: [Attachment]?

    struct Clinic {
        var id: String
        var name: String
        var attributes: Attributes?
    }

    struct Attributes {
        var type: String
        var url: String
    }

    struct Attachment {
        var id: String
        var name: String
        var parentId: String
        var base64Body: String?  
        var attributes: Attributes?
    }

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
        
        self.id = getStringValue("Id")
        self.userId = getStringValue("User__c")
        self.name = getStringValue("Name")
        self.status = getStringValue("Status__c")
        self.ticketType = getStringValue("Ticket_Type__c")
        self.issue = getStringValue("Issue__c")
        self.amRemarks = getStringValue("AM_Remarks__c")
        self.amRemarksDate = getStringValue("AM_Remarks_Date__c")
        self.moRemarksDate = getStringValue("MO_Remarks_Date__c")
        self.maintenanceOfficerRemarks = getStringValue("Maintenance_Officer_Remarks__c")
        self.isIssueFixedByAM = getStringValue("Is_this_Issue_Fixed_by_AM__c")
        self.isIssueFixedByMO = getStringValue("Is_this_Issue_Fixed_by_MO__c")
        self.isIssueFixedByOV = getStringValue("Did_Outsource_vendor_has_fixed_the_Issue__c")
        self.Outsource_Vendor_Remarks_Date__c = getStringValue("Outsource_Vendor_Remarks_Date__c")
        self.Outsource_Vendor_Remarks__c = getStringValue("Outsource_Vendor_Remarks__c")
        self.Is_this_Issue_Fixed_by_MO_Final__c = getStringValue("Is_this_Issue_Fixed_by_MO_Final__c")
        self.LastReferencedDate = getStringValue("LastReferencedDate")
        self.LastViewedDate = getStringValue("LastViewedDate")
        self.Clinic__c = getStringValue("Clinic__c")
        self.createdById = getStringValue("CreatedById")
        self.createdDate = getStringValue("CreatedDate")
        self.lastModifiedById = getStringValue("LastModifiedById")
        self.lastModifiedDate = getStringValue("LastModifiedDate")
        self.ownerId = getStringValue("OwnerId")
        self.Closed_Date__c = getStringValue("Closed_Date__c")
        
        let reAssignedValue = dict?["ReAssignedToMO__c"]
        if let intValue = reAssignedValue as? Int {
            self.ReAssignedToMO__c = (intValue == 0) ? "No" : "Yes"
        } else if let strValue = reAssignedValue as? String {
            self.ReAssignedToMO__c = (strValue == "0") ? "No" : "Yes"
        } else {
            self.ReAssignedToMO__c = "NA"
        }
        
        if let clinicDict = dict?["Clinic__r"] as? [String: Any] {
            let attributesDict = clinicDict["attributes"] as? [String: Any] ?? [:]
            self.clinic = Clinic(
                id: clinicDict["Id"] as? String ?? "NA",
                name: clinicDict["Name"] as? String ?? "NA",
                attributes: Attributes(
                    type: attributesDict["type"] as? String ?? "NA",
                    url: attributesDict["url"] as? String ?? "NA"
                )
            )
        }
                
        if let attachmentsArray = dict?["Attachments"] as? [[String: Any]] {
            self.attachments = attachmentsArray.map { attachmentDict in
                let attributesDict = attachmentDict["attributes"] as? [String: Any] ?? [:]
                return Attachment(
                    id: attachmentDict["Id"] as? String ?? "NA",
                    name: attachmentDict["Name"] as? String ?? "NA",
                    parentId: attachmentDict["ParentId"] as? String ?? "NA",
                    base64Body: attachmentDict["Base64Body"] as? String,
                    attributes: Attributes(
                        type: attributesDict["type"] as? String ?? "NA",
                        url: attributesDict["url"] as? String ?? "NA"
                    )
                )
            }
        } else {
            self.attachments = []
        }
    }
}
