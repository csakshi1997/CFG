//
//  ClinicOperation.swift
//  CFGApp
//
//  Created by Sakshi on 03/02/25.
//

import Foundation
import UIKit

class ClinicOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func getClinicNamesList(outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        let alertCondition = "Senior_Consultant_Alert__r.Name = '\(Defaults.userName ?? "")' OR Patient_Alert__r.Name = '\(Defaults.userName ?? "")' OR OM_Alert__r.Name = '\(Defaults.userName ?? "")' OR MO_Alert__r.Name = '\(Defaults.userName ?? "")' OR Finance_Alert__r.Name = '\(Defaults.userName ?? "")' OR Clinic_Manager_Alert__r.Name = '\(Defaults.userName ?? "")' OR Clinic_Doctor_Alert__r.Name = '\(Defaults.userName ?? "")' OR AM_Alert__r.Name = '\(Defaults.userName ?? "")'"
        
        let query = "SELECT Id, Name, RecordTypeId FROM Account WHERE RecordTypeId = '0127F000000BeSTQA0'AND (\(alertCondition))"
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")/services/data/v59.0/query/?q=\(query)", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("getClinicNamesList Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = result as? [String: Any], let _ = responseData["records"] as? [[String: Any]] else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
}
    
