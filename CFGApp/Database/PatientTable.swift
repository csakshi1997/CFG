//
//  PatientTable.swift
//  CFGApp
//
//  Created by Sakshi on 27/01/25.
//

import Foundation
import UIKit
import SQLite3

class PatientTable: Database {
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    var statement: OpaquePointer? = nil
    
    func createPatientTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS PatientTable (
                localId INTEGER PRIMARY KEY AUTOINCREMENT,
                Id INTEGER,
                Name TEXT,
                RecordTypeId TEXT,
                attributesType TEXT,
                attributesUrl TEXT,
                createdAt TEXT
            );
        """
        if sqlite3_exec(Database.databaseConnection, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Error creating PatientTable")
        }
    }
    
    // Insert data into AssetRequisitionTable
    func savePatientTable(model: PatientModel, completion: @escaping (Bool, String?) -> Void) {
        var statement: OpaquePointer?
        let insertQuery = "INSERT INTO PatientTable (Id, Name, RecordTypeId, attributesType, attributesUrl) VALUES (?, ?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(Database.databaseConnection, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, model.Id ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 2, model.Name ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 3, model.RecordTypeId ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 4, model.attributes?.type ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 5, model.attributes?.url ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 6, model.createdAt ?? "", -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                let errorMsg = String(cString: sqlite3_errmsg(Database.databaseConnection))
                print("Error inserting PatientTable: \(errorMsg)")
                completion(false, errorMsg)
            } else {
                print("PatientTable inserted successfully")
                completion(true, nil)
            }
        } else {
            let errorMsg = String(cString: sqlite3_errmsg(Database.databaseConnection))
            print("Error preparing statement: \(errorMsg)")
            completion(false, errorMsg)
        }
        
        sqlite3_finalize(statement)
    }
    
    // Fetch all records from AssetRequisitionTable
    func getPatientTable() -> [PatientModel] {
        var resultArray = [PatientModel]()
        var statement: OpaquePointer?
        let query = "SELECT * FROM PatientTable"
        
        if sqlite3_prepare_v2(Database.databaseConnection, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                var model = PatientModel()
                model.localId = Int(sqlite3_column_int(statement, 0))
                model.Id = String(cString: sqlite3_column_text(statement, 1))
                model.Name = String(cString: sqlite3_column_text(statement, 2))
                model.RecordTypeId = String(cString: sqlite3_column_text(statement, 3))
                let attributesType = String(cString: sqlite3_column_text(statement, 4))
                let attributesUrl = String(cString: sqlite3_column_text(statement, 5))
                model.attributes = PatientModel.Attributes(type: attributesType, url: attributesUrl)
                model.createdAt = String(cString: sqlite3_column_text(statement, 6))
                resultArray.append(model)
            }
            sqlite3_finalize(statement)
        } else {
            print("Failed to prepare statement for fetching PatientTable records.")
        }
        return resultArray
    }
}
