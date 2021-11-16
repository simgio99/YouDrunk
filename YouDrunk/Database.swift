//
//  Database.swift
//  YouDrunk
//
//  Created by Simone Giordano on 15/11/21.
//

import Foundation
import SQLite3

let dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
func openDatabase() -> OpaquePointer? {
  var db: OpaquePointer?
  let url = NSURL(fileURLWithPath: dbURL)
    
    if let pathComponent = url.appendingPathComponent("YouDrunk.sqlite") {
        let filePath = pathComponent.path
        if sqlite3_open(filePath, &db) == SQLITE_OK {
            print("Connection to database successufully estabilished")
            return db
        }
        else {
            print("Could not estabilish connection to database")
        }
       
    }
    else {
        print("Filepath not available")
    }
    return db
    
}

func createTables (dbHandler: OpaquePointer) -> Bool {
    var success: Bool = false
    let createTableDrinks = sqlite3_exec(dbHandler, "CREATE TABLE if not exists drinks(drink_id INTEGER PRIMARY KEY AUTOINCREMENT, drink_type INTEGER NOT NULL, drink_name TEXT NOT NULL, alcohol_percentage REAL NOT NULL)", nil, nil, nil)
    let createTableDrinkTypes = sqlite3_exec(dbHandler, "CREATE TABLE if not exists drink_types(drink_type_id INTEGER PRIMARY KEY AUTOINCREMENT, drink_type_name TEXT NOT NULL)" , nil, nil, nil)
    let createTableDrinkEntries = sqlite3_exec(dbHandler, "CREATE TABLE if not exists drink_entries(drink_entry_id INTEGER PRIMARY KEY AUTOINCREMENT, drink_id INTEGER NOT NULL, entry_date DATE NOT NULL)", nil, nil, nil)
    
    success = createTableDrinks == SQLITE_OK && createTableDrinkTypes == SQLITE_OK && createTableDrinkEntries == SQLITE_OK
    return success
}
