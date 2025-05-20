//
//  Database.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit
import SQLite3

class Database: NSObject {
    static var databaseConnection: OpaquePointer? = nil
    
    func printErroMessage() -> String {
        return String(cString:sqlite3_errmsg(Database.databaseConnection))
    }
    
    func getStringAt(statement:OpaquePointer, column:Int ) -> String? {
        let cColumn:CInt = CInt(column)
        let c = sqlite3_column_text(statement, cColumn)
        if ( c != nil ) {
            let cStringPtr = UnsafePointer<UInt8>(c)
            return String(cString:cStringPtr!)
        } else  {
            return EMPTY
        }
    }
    
    func getIntAt(statement:OpaquePointer, column:Int) -> Int {
        let cColumn:CInt = CInt(column)
        return Int(sqlite3_column_int(statement, cColumn))
    }
    
    class func createDatabase() {
        print(sqlite3_libversion()!)
        print(sqlite3_threadsafe())
        openDatabase()
        let patientTable = PatientTable()
        patientTable.createPatientTable()
    }
    
    class func openDatabase() {
        if sqlite3_open_v2(getDBPath(), &databaseConnection, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK {
            print("Successfully opened connection to database")
        } else {
            print("Unable to open database.")
        }
    }
    
    class func getDBPath() -> String {
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir: String? = (paths[0] as? String)
        let folderDir: String = documentsDir! + "/cfg.db"
        print(folderDir)
        return folderDir
    }
}

extension Database {
    static func deleteTable(tableName: String) {
        let querySQL = "delete from \(tableName)"
        var localStatement: OpaquePointer? = nil
        sqlite3_prepare_v2(Database.databaseConnection, querySQL, -1, &localStatement, nil)
        sqlite3_step(localStatement)
        sqlite3_reset(localStatement)
    }
    
    static func alterTable(tableName: String, dictArray : [[String : String]]) {
        for(_, dict) in dictArray.enumerated() {
            let querySQL = "ALTER TABLE \(tableName) ADD \(dict["column"]!) TEXT default '\(dict["defaultValue"]!)'"
            var localStatement: OpaquePointer? = nil
            sqlite3_prepare_v2(Database.databaseConnection, querySQL, -1, &localStatement, nil)
            sqlite3_step(localStatement)
            sqlite3_reset(localStatement)
        }
    }
}


