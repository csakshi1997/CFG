//
//  RefundWebService.swift
//  CFGApp
//
//  Created by Sakshi on 25/02/25.
//

import Foundation
import UIKit

class RefundWebService {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    let dateFormatter = DateFormatter()
    
    func submitNewTicketForRefund(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingPostMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.SAVE_REFUND)", parameters: param, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("SAVE_REFUND Response: \(result ?? EMPTY)")
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
    
    func getFinancialApi(outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.FINANCIAL_API)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("FINANCIAL_API Response: \(result ?? EMPTY)")
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
    
    func getPendingRefund(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.PENDING_REFUND_API)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("PENDING_REFUND_API Response: \(result ?? EMPTY)")
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
    func getClosedRefund(outerClosure: @escaping ((String?, [[String: Any]]?, ResponseStatus) -> ())) {
        webRequest.processRequestUsingGetMethod(url: "\(Defaults.instanceUrl ?? "")\(endPoint.CLOSING_REFUND_API)\(Defaults.userName ?? "")", parameters: nil, showLoader: true) { error, val, result, statusCode in
            print("CLOSING_REFUND_API Response: \(result ?? EMPTY)")
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
}

