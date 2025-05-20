//
//  ClinicModel.swift
//  CFGApp
//
//  Created by Sakshi on 03/02/25.
//

import Foundation

struct ClinicModel {
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
    
    init() {
    }
    
    init (dict: [String: Any]?) {
        self.Id = dict?["Id"] as? String ?? EMPTY
        self.Name = dict?["Name"] as? String ?? EMPTY
        self.RecordTypeId = dict?["RecordTypeId"] as? String ?? EMPTY
        let attributesDict = dict?["attributes"] as? [String: Any] ?? [:]
        let attributesType = attributesDict["type"] as? String ?? EMPTY
        let attributesUrl = attributesDict["url"] as? String ?? EMPTY
        self.attributes = ClinicModel.Attributes(type: attributesType, url: attributesUrl)
    }
}


