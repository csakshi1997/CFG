//
//  DoctorModel.swift
//  CFGApp
//
//  Created by Sakshi on 16/02/25.
//

import Foundation

struct DoctorModel {
    var localId: Int?
    var Id: String?
    var Name: String?
    var RecordTypeId: String?
    var attributes: Attributes?
    var createdAt: String?
    
    struct Attributes {
        var type: String?
        var url: String?
    }
    
    init() { }
    
    init(dict: [String: Any]?) {
        self.Id = dict?["Id"] as? String ?? ""
        self.Name = dict?["Name"] as? String ?? ""
        self.RecordTypeId = dict?["RecordTypeId"] as? String ?? ""
        
        if let attributesDict = dict?["attributes"] as? [String: Any] {
            self.attributes = Attributes(
                type: attributesDict["type"] as? String ?? "",
                url: attributesDict["url"] as? String ?? ""
            )
        }
    }
    
    static func fromArray(_ array: [[String: Any]]?) -> [DoctorModel] {
        return array?.map { DoctorModel(dict: $0) } ?? []
    }
}
