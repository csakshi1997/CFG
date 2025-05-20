//
//  Enum.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit

enum ResponseStatus: Int {
    case success
    case alreadyRegister
    case tokenExpired
    case error
    case badRequest
}

enum MediaType {
    case image
    case video
    case pdf
}

struct MediaItem {
    var fileName: String?
    var type: MediaType
    var image: UIImage?
    var videoURL: URL?
    var pdfURL: URL?
    var thumbnail: UIImage? 
}

enum TaskStatus: String {
    case inProgress = "inProgress"
    case completed = "completed"
    case hold = "hold"
    case blocked = "blocked"
}

enum HomeItems: String, CaseIterable {
    case dailyStatics = "Daily Statics"
    case toDoList = "To-Do List"
    case refund = "Refund Process"
    case maintenance = "Maintenance"
    case compliance = "Compliance Report"
    case calender = "Calender"
    case marcom = "Marcom"
    case triggers = "Triggers"
    case leadsFollowUp = "Leads Follow Up"
    case redFlagProcess = "Red Flag Process"
    case am = "AM"
    case sgMonthlyReport = "SG Monthly Report"
    case generalbacklogClear = "General Backlog to Clear"
    
    func getHomeItemsText() -> String{
        switch self {
        case .dailyStatics:
            return "Your Daily End Reports are here."
        case .toDoList:
            return "Your To-Do list are here."
        case .refund:
            return "Seamless Refund Management - Track, Process and Resolve with Ease"
        case .maintenance:
            return "Track and manage Maintenance"
        case .compliance:
            return "Leave, Events, Promotions schedule here."
        case .calender:
            return "Leave, Events, Promotions schedule here."
        case .marcom:
            return "Events, Talks, Roadshows, Digital Marketing Internals."
        case .triggers:
            return "Leave, Events, Promotions schedule here."
        case .leadsFollowUp:
            return "Events, Talks, Roadshows, Digital Marketing Internals."
        case .redFlagProcess:
            return "A Red Flag is raised for a patient who repeatedly misses appointments and does not follow the prescribed medical process."
        case .am:
            return "Events, Talks, Roadshows, Digital Marketing Internals."
        case .sgMonthlyReport:
            return "Leave, Events, Promotions schedule here."
        case .generalbacklogClear:
            return "Events, Talks, Roadshows, Digital Marketing Internals."
        }
    }
}

enum TriggerHomeItems: String, CaseIterable {
    case triggerEvents = "Trigger Events"
    case triggerCropTalk = "Trigger Crop Talk"
    case triggerTestimonials = "Trigger Testimonials"
    case triggerReferral = "Trigger Referral"
    
    func getTriggerHomeItemst() -> String{
        switch self {
        case .triggerEvents:
            return "This Trigger is for Create Events to Select Patients."
        case .triggerCropTalk:
            return "This Trigger is for Crop talk to Select Patients."
        case .triggerTestimonials:
            return "This Trigger is Get Testimonials from Patients."
        case .triggerReferral:
            return "This Trigger is Get Referral from Patients."
        }
    }
}

enum StatusItems: String, CaseIterable {
    case admin = "Admin"
    case clinicFDSupervisorsRedFlag = "Clinic FD/Supervisors"
    case aMRedFlag = "AM"
    case doctor = "Doctor"
    case mo = "MO"
    case ov = "OV"
    
    // Function that dynamically returns different status texts
    func getStatusItemsText(isForAM: Bool = false) -> String {
        switch self {
        case .admin:
            return "admin"
        case .clinicFDSupervisorsRedFlag:       
            return isForAM ? "Pending by AM" : "Pending Review with Clinic Supervisor/Manager"
        case .aMRedFlag:
            return "Pending by AM"
        case .doctor:
            return "Pending Review with Clinic Doctor"
        case .mo:
            return "Pending by MO"
        case .ov:
            return "Pending by OV"
        }
    }
}
enum Permission: String {
    case view = "view"
    case comment = "comment"
    case edit = "edit"
    case full = "full"

    func getPermissionText() -> String{
        switch self {
        case .view:
            return "Can View"
        case .comment:
            return "Can Comment"
        case .edit:
            return "Can Edit"
        case .full:
            return "Full Access"
        }
    }
}

let customDateFormatter1 = CustomDateFormatter()
let todayDateString1 = customDateFormatter1.getTodayDateString()
