//
//  BaseWebService.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit
import Alamofire

struct EndPoints {
    var PATIENT_LIST = "/services/apexrest/RefundApi/patient?"
    var PATIENT_DETAILS = "/services/apexrest/RefundApi/patient?"
    var PENDING_MAINTENANCE = "/services/apexrest/MaintenanceApi/Pending?username="
    var CLOSED_MAINTENANCE = "/services/apexrest/MaintenanceApi/closed?username="
    var SAVE_MAINTENANCE = "/services/data/v63.0/composite"
    var UPDATE_MAINTENANCE = "/services/apexrest/MaintenanceApi/updatemaintenance"
    var GET_UPDATE_MAINTENANCE = "/services/apexrest/MaintenanceApi/Maintenance?MaintenanceId="
    var PENDING_REDFLAG = "/services/apexrest/RedFlagApi/pending?username="
    var CLOSED_REDFLAG = "/services/apexrest/RedFlagApi/closed?username="
    var SAVE_REDFLAG = "/services/apexrest/RedFlagApi/new?created_user="
    var GET_REDFLAG_BY_ID = "/services/apexrest/RedFlagApi/RedFlag?RedFlagId="
    var UPDATE_REDFLAG = "/services/apexrest/RedFlagApi/updateRedFlags?redflagid="
    var SAVE_REFUND = "/services/apexrest/RefundApi/new"
    var FINANCIAL_API = "/services/apexrest/RefundApi/finance?username="
    var PENDING_REFUND_API = "/services/apexrest/RefundApi/pending?username="
    var CLOSING_REFUND_API = "/services/apexrest/RefundApi/closed?username="
    
}

enum ContentType: String {
    case multipart = "multipart/form-data"
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
    case none = ""
}

let tokenExpiredErrorMessage = "jwt expired"

class BaseWebService {
    let reachabilityManager = NetworkReachabilityManager()
    func setLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.spinnerColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        config.foregroundColor = .black
        config.foregroundAlpha = 0.5
        SwiftLoader.setConfig(config: config)
    }
    
    func getHeader(contentType: ContentType = .json) ->  [String: String] {
        var header: [String: String] = [:]
        if !(Defaults.accessToken ?? "").isEmpty {
            header["Authorization"] = "Bearer \(Defaults.accessToken ?? "")"
            header["created_user"] = Defaults.userName
            print("Defaults.accessToken \(Defaults.accessToken ?? "")")
            print("Defaults.userName \(Defaults.userName ?? "")")
        }
        if contentType == .multipart {
            header["Content-Type"] = "multipart/form-data"
        } else if contentType == .json  {
            header["Content-Type"] = "application/json"
            header["accept"] = "application/json"
            header["created_user"] = Defaults.userName
        } else if contentType == .urlEncoded  {
            header["Content-Type"] = "application/x-www-form-urlencoded"
        } else if contentType == .none {
        }
        return header
    }
    
    func processRequestUsingPostMethod(url: String, parameters: [String: Any]?, showLoader: Bool, contentType: ContentType, closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        setLoader()
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        if showLoader == true {
            SwiftLoader.show(title: "Loading...", animated: true)
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(getHeader(contentType: contentType)))
            .responseJSON { response in
                SwiftLoader.hide()
                print(response)
                let dict = response.value as? [String : Any] ?? [:]
                let errorDict = dict["error"] as? [String : Any] ?? [:]
                let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
                if let statusCode = response.response?.statusCode {
                    if (statusCode == 401) {
                        if errorMessage == tokenExpiredErrorMessage {
                            Utility.tokenExpiredAction()
                            closure(errorMessage, false, nil, statusCode)
                        } else {
                            closure(errorMessage, false, nil, statusCode)
                        }
                        return
                    }
                    if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                        closure(nil, true, response.value, statusCode)
                    } else {
                        let dict = response.value as? [String : Any] ?? [:]
                        closure(errorMessage, false, dict, statusCode)
                    }
                } else {
                    closure(errorMessage, false, nil, response.response?.statusCode)
                }
            }
    }
    
    func processRequestUsingGetMethod(url: String, parameters: [String: Any]?, showLoader: Bool,  closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        setLoader()
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        if showLoader {
            DispatchQueue.main.async() {
                SwiftLoader.show(title: "Loading...", animated: true)
            }
        }
        AF.request(url, method: .get, parameters: parameters, headers: HTTPHeaders(getHeader()))
            .responseJSON { response in
                print(response)
                SwiftLoader.hide()
                let dict = response.value as? [String : Any] ?? [:]
                let errorDict = dict["error"] as? [String : Any] ?? [:]
                let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
                if let statusCode = response.response?.statusCode {
                    if (statusCode == 401) {
                        if errorMessage == tokenExpiredErrorMessage {
                            Utility.tokenExpiredAction()
                            closure(errorMessage, false, nil, statusCode)
                        } else {
                            closure(errorMessage, false, nil, statusCode)
                        }
                        return
                    }
                    if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                        closure(nil, true, response.value, statusCode)
                    } else {
                        let dict = response.value as? [String : Any] ?? [:]
                        closure(dict["message"] as? String ?? ERROR_OCCURRED, false, dict, statusCode)
                    }
                } else {
                    closure(errorMessage, false, nil, response.response?.statusCode)
                }
            }
    }
    
    func processRequestUsingPutMethod(url: String, parameters: [String: Any]?, showLoader: Bool, closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        setLoader()
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        if showLoader {
            DispatchQueue.main.async() {
                SwiftLoader.show(title: "Loading...", animated: true)
            }
        }
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(getHeader(contentType: .json))) .responseJSON { response in
            SwiftLoader.hide()
            let dict = response.value as? [String : Any] ?? [:]
            let errorDict = dict["error"] as? [String : Any] ?? [:]
            let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
            if let statusCode = response.response?.statusCode {
                if (statusCode == 401) {
                    if errorMessage == tokenExpiredErrorMessage {
                        Utility.tokenExpiredAction()
                        closure(errorMessage, false, nil, statusCode)
                    } else {
                        closure(errorMessage, false, nil, statusCode)
                    }
                    return
                }
                if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                    closure(nil, true, response.value, statusCode)
                } else {
                    let dict = response.value as? [String : Any] ?? [:]
                    closure(dict["message"] as? String ?? ERROR_OCCURRED, false, dict, statusCode)
                }
            } else {
                closure(errorMessage, false, nil, response.response?.statusCode)
            }
        }
    }
    
    func processRequestUsingDeleteMethod(url: String, parameters: [String: Any]?, showLoader: Bool, closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        setLoader()
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        if showLoader {
            DispatchQueue.main.async() {
                SwiftLoader.show(title: "Loading...", animated: true)
            }
        }
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(getHeader(contentType: .json)))
            .responseJSON { response in
                SwiftLoader.hide()
                let dict = response.value as? [String : Any] ?? [:]
                let errorDict = dict["error"] as? [String : Any] ?? [:]
                let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
                if let statusCode = response.response?.statusCode {
                    if (statusCode == 401) {
                        if errorMessage == tokenExpiredErrorMessage {
                            Utility.tokenExpiredAction()
                            closure(errorMessage, false, nil, statusCode)
                        } else {
                            closure(errorMessage, false, nil, statusCode)
                        }
                        return
                    }
                    if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                        closure(nil, true, response.value, statusCode)
                    } else {
                        let dict = response.value as? [String : Any] ?? [:]
                        closure(dict["message"] as? String ?? ERROR_OCCURRED, false, dict, statusCode)
                    }
                } else {
                    closure(errorMessage, false, nil, response.response?.statusCode)
                }
            }
    }
    
    func multipartSingleImageUpload(isUpdate: Bool, url: String, imageKey: String, image: UIImage, closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        setLoader()
        SwiftLoader.show(title: "Loading...", animated: true)
        var httpMethod = HTTPMethod(rawValue: "POST")
        if isUpdate {
            httpMethod =  HTTPMethod(rawValue: "PUT")
        }
        AF.upload(multipartFormData: { multiPart in
            multiPart.append((image.jpegData(compressionQuality: 1.0)!), withName: imageKey, fileName: "\(Utility.getUniqueName()).jpeg", mimeType: "image/jpeg")
        }, to: url, method: httpMethod , headers: HTTPHeaders(getHeader(contentType: .multipart)))
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { response in
            SwiftLoader.hide()
            let dict = response.value as? [String : Any] ?? [:]
            let errorDict = dict["error"] as? [String : Any] ?? [:]
            let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
            if let statusCode = response.response?.statusCode {
                if (statusCode == 401) {
                    if errorMessage == tokenExpiredErrorMessage {
                        Utility.tokenExpiredAction()
                        closure(errorMessage, false, nil, statusCode)
                    } else {
                        closure(errorMessage, false, nil, statusCode)
                    }
                }
                if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                    closure(nil, true, response.value, statusCode)
                } else {
                    let dict = response.value as? [String : Any] ?? [:]
                    closure(errorMessage, false, dict, statusCode)
                }
            } else {
                closure(errorMessage, false, nil, response.response?.statusCode)
            }
        })
    }
    
    func multipartUploadImagewithParam(url: String, parameters: [String: Any]?, multupleImages: [UIImage], isUpdate: Bool = false, closure:@escaping (String?, Bool?, Any?, Int?) -> ()) {
        if !reachabilityManager!.isReachable {
            closure(INTERNET_NOT_AVAILABLE_STR, false, nil, nil)
            return
        }
        setLoader()
        SwiftLoader.show(title: "Loading...", animated: true)
        var httpMethod = HTTPMethod(rawValue: "POST")
        if isUpdate {
            httpMethod = HTTPMethod(rawValue: "PUT")
        }
        AF.upload(multipartFormData:{
            (multipartFormData) in
            for (key, value) in parameters! {
                if value is [String] {
                    let array = value as? [String] ?? []
                    for data in array {
                        multipartFormData.append((data as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key, mimeType: "text")
                    }
                } else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key, mimeType: "text")
                }
            }
            for img in multupleImages {
                multipartFormData.append((img.jpegData(compressionQuality: 1.0)!), withName: "attachments", fileName: "\(Utility.getUniqueName()).jpeg", mimeType: "image/jpeg")
            }
        }, to: url, method: httpMethod , headers: HTTPHeaders(getHeader(contentType: .multipart)))
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { response in
            SwiftLoader.hide()
            let dict = response.value as? [String : Any] ?? [:]
            let errorDict = dict["error"] as? [String : Any] ?? [:]
            let errorMessage = errorDict["message"] as? String ?? ERROR_OCCURRED
            if let statusCode = response.response?.statusCode {
                if (statusCode == 401) {
                    if errorMessage == tokenExpiredErrorMessage {
                        Utility.tokenExpiredAction()
                        closure(errorMessage, false, nil, statusCode)
                    } else {
                        closure(errorMessage, false, nil, statusCode)
                    }
                }
                if statusCode == 200 || statusCode == 201 || statusCode == 203 || statusCode == 204 {
                    closure(nil, true, response.value, statusCode)
                } else {
                    let dict = response.value as? [String : Any] ?? [:]
                    closure(errorMessage, false, dict, statusCode)
                }
            } else {
                closure(errorMessage, false, nil, response.response?.statusCode)
            }
        })
    }
}
