//
//  Constant.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit

var DeviceId : String = UIDevice.current.identifierForVendor!.uuidString
var DeviceToken : String = ""
let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String
let BundleID = Bundle.main.bundleIdentifier
var Device_Token : String = EMPTY
var selectedTabIndex : Int = 0

var currentVisitId: String = ""
var chcekInDate: String = ""
var chcekintime: String = ""
var savedCurrentDate: String = ""
var savedCurrentTime: String = ""

#if DEBUG
var grant_type : String = "password"
var client_id : String = "3MVG9ZFAO4mAUDanh8g7lNfsGDbxxpSggAtAv5Dy1FA8AQQ6txxIovNRxwLBFkyTEWynBGltw.E6FVSFcFOxE"
var client_secret : String = "6E5EC4FDFF78AFEDBAB5BA72F50AECCECE559FE4E32567F50CA30BA2DB03787D"
var IntegrationPassword : String = "Cfg@1234"
let AppMode = "DevelopmentMode"
let apiUrl = "https://cfg--partialcop.sandbox.my.salesforce.com/services/data/v59.0/"
let LoginBaseURL : String = "https://test.salesforce.com/services/oauth2/token"
let CFGMAppLoginBaseURL : String = "https://cfg--partial.sandbox.my.salesforce.com/services/apexrest/LoginValidation"
var isProduction: Bool = false

#else
var grant_type : String = "password"
var client_id : String = "3MVG9d8..z.hDcPK.jTB5TIX1bDs1zY.u.KZihzRaR4SyhAnwKMbrNvBodRO2UG5st_5rP3Dua4lFZDU7KySz"
var client_secret : String = "AFD1B53B2E0453E8EDD862BD54ADD9F6F8AA43C0B1C4E39B26B64B728F0C005E"
let AppMode = "ProductionMode"
var IntegrationPassword : String = "Cfg@1234DCLQriVU07pAUczijRGWiOKE"
let apiUrl = "https://cfg.lightning.force.com/services/data/v59.0/"
let LoginBaseURL : String = "https://login.salesforce.com/services/oauth2/token"
let CFGMAppLoginBaseURL : String = "https://cfg.my.salesforce.com/services/apexrest/LoginValidation"
var isProduction: Bool = true
#endif

#if arch(i386) || arch(x86_64)
let IsSimulator = true
#else
let IsSimulator = false
#endif

// MARK: Date Format Type
let twelveHoursTimeFormat = "hh:mm a"
let twentyFourHoursTimeFormat = "HH:mm:ss"
let dateFormatOneType = "yyyy-MM-dd"
let dateFormatTwoType = "MMMM yyyy"
let dateFormatThreeType = "dd/MM/yyyy"
var dateTimeFormat = "yyyy-MM-dd HH:mm:ss"

// TextFeild error color code
let colorForError: String = "#FF3B30"
let borderColorForError: String = "#FF3B30"
let textColor: String = "#722F37"
let buttonColor: String = "#722F37"

func getSideMenuWidth() -> CGFloat {
    if DeviceType.IS_IPHONE_5 {
        return 250.0
    } else {
        return 290.0
    }
}





