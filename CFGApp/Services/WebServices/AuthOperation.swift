//
//  AuthOperation.swift
//  CFGApp
//
//  Created by Sakshi on 27/01/25.
//

import Foundation
import UIKit

class AuthOperation {
    let webRequest = BaseWebService()
    let endPoint = EndPoints()
    
    func executLogin(userDetail: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) -> () {
        var components = URLComponents(string: LoginBaseURL)
        components?.queryItems = userDetail.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
        guard let finalURL = components?.url else {
            print("Error creating URL")
            return
        }
        print(finalURL)
        webRequest.processRequestUsingPostMethod(url: "\(finalURL)", parameters: userDetail, showLoader: true, contentType: .json) { error, val, result, statusCode in
            print("Login Response: \(result ?? EMPTY)")
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
        
    func executeCFGMAppLogin(param: [String: Any], outerClosure: @escaping ((String?, [String: Any]?, ResponseStatus) -> ())) {
        print(" CFGMAppLoginBaseURL:: \(CFGMAppLoginBaseURL)")
        webRequest.processRequestUsingGetMethod(url: "\(CFGMAppLoginBaseURL)", parameters: param, showLoader: true) { error, val, result, statusCode in
            print("Login Response: \(result ?? EMPTY)")
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

