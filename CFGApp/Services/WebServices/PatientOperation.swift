//
//  PatientOperation.swift
//  CFGApp
//
//  Created by Sakshi on 27/01/25.
//

import Foundation
import UIKit

class PatientOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func getPatientNamesList(outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        let alertCondition = "Assign_Clinic__r.Patient_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.OM_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.MO_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.Finance_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.Clinic_Manager_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.Clinic_Doctor_Alert__r.name = '\(Defaults.userName ?? "")' OR Assign_Clinic__r.AM_Alert__r.name = '\(Defaults.userName ?? "")'"
        let query = "Select Id, Name, RecordTypeId From Account Where RecordTypeId = '0127F000000BeSYQA0'AND (\(alertCondition))"
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")/services/data/v59.0/query/?q=\(query)", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("getPatientNamesList Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = result as? [String: Any] else {
                outerClosure("Invalid response format", nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            
            guard let records = responseData["records"] as? [[String: Any]], !records.isEmpty else {
                outerClosure("No records found", nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
    
    func getPatienDetails(patientId: String, outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.PATIENT_DETAILS)PatientId=\(patientId)&username=\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("PatientId: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = result as? [String: Any] else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
}
