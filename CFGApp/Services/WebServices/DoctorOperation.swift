//
//  DoctorOperation.swift
//  CFGApp
//
//  Created by Sakshi on 16/02/25.
//

import Foundation

class DoctorOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func getDoctorsNamesList(clinicId: String, outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        let query = "Select Id, Name, RecordTypeId From Account Where RecordTypeId = '0127F000000BeSXQA0' and (Assign_Clinic__c='\(clinicId)' or Clinic__c= '\(clinicId)')"
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")/services/data/v59.0/query/?q=\(query)", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("getDoctorsNamesList Response: \(result ?? EMPTY)")
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
