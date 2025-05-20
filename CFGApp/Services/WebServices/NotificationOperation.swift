//
//  NotificationOperation.swift
//  CFGApp
//
//  Created by Sakshi on 01/04/25.
//

import Foundation
import UIKit

class NotificationOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    
    func getAllNotification(outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "https://cfg.lightning.force.com/services/apexrest/UserDetailsApi?username=\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("GET_NOTIFICATION Response: \(result ?? EMPTY)")
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
    
    func updateNotificationStatus(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "https://cfg.lightning.force.com/services/apexrest/UserDetailsApi", parameters: param, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("update Notification Response: \(result ?? EMPTY)")
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
