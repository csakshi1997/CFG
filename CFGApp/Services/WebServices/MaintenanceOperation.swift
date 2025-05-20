//
//  MaintenanceOperation.swift
//  CFGApp
//
//  Created by Sakshi on 29/01/25.
//

import Foundation
import UIKit

class MaintenanceOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func getMaintenancePendingList(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.PENDING_MAINTENANCE)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("PENDING_MAINTENANCE Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, result as? [[String: Any]], Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = (result as? [[String: Any]]) else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
    
    func getMaintenanceClosedList(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.CLOSED_MAINTENANCE)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("CLOSED_MAINTENANCE Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, result as? [[String: Any]], Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = (result as? [[String: Any]]) else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
    
    func getMaintenanceDataOnTheBasisOfID(maintenanceId: String, outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.GET_UPDATE_MAINTENANCE)\(maintenanceId)&username=\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("GET_UPDATE_MAINTENANCE Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, result as? [[String: Any]], Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = (result as? [[String: Any]]) else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
    
    func submitNewTicketFormaintenance(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.SAVE_MAINTENANCE)", parameters: param, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("SAVE_MAINTENANCE Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, result as? [String: Any], Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = (result as? [String: Any]) else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
    
    func updateTicketFormaintenance(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.UPDATE_MAINTENANCE)", parameters: param, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("UPDATE_MAINTENANCE Response: \(result ?? EMPTY)")
            guard error == nil else {
                outerClosure(error, result as? [String: Any], Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            guard let responseData = (result as? [String: Any]) else {
                outerClosure(error, nil, Utility.getStatus(responseCode: statusCode ?? 0))
                return
            }
            outerClosure(nil, responseData, Utility.getStatus(responseCode: statusCode ?? 0))
        }
    }
}
