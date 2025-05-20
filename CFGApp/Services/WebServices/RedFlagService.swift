//
//  RedFlagService.swift
//  CFGApp
//
//  Created by Sakshi on 10/02/25.
//

import Foundation
import UIKit

class RedFlagService {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func getRedFlagPendingList(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.PENDING_REDFLAG)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("PENDING_REDFLAG Response: \(result ?? EMPTY)")
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
    
    func getRedFlagClosedList(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.CLOSED_REDFLAG)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("CLOSED_REDFLAG Response: \(result ?? EMPTY)")
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
    
    func submitNewTicketForRedFlag(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.SAVE_REDFLAG)\(Defaults.userName ?? "")", parameters: param, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("SAVE_REDFLAG Response: \(result ?? EMPTY)")
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
    
    func updateForRedFlag(redFlagId: String, payload: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.UPDATE_REDFLAG)\(redFlagId)", parameters: payload, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("UPDATE_REDFLAG Response: \(result ?? EMPTY)")
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
    
    func getRedFlagDataOnTheBasisOfID(redFlagId: String, outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.GET_REDFLAG_BY_ID)\(redFlagId)&username=\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("GET_REDFLAG_BY_ID Response: \(result ?? EMPTY)")
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
    
