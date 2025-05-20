//
//  CustomDateFormatter.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit

class CustomDateFormatter {
    func getTodayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatOneType
        let todayDate = Date()
        return dateFormatter.string(from: todayDate)
    }
    
    func getDateForVisitsOrderDate(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MMM"
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getDateForCreatedAt(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getDateForCreatedAtTime(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a"
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func getCurrentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Adjust the format as needed
        return dateFormatter.string(from: Date())
    }
    
    func getFormattedDateForAccount() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // Specify the format including timezone
        formatter.timeZone = TimeZone.current  // Use the current time zone (e.g., +0530 for India Standard Time)
        
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }
    
    func getFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss" // Specify the time format
        formatter.timeZone = TimeZone.current // Use the current time zone
        
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }
}

