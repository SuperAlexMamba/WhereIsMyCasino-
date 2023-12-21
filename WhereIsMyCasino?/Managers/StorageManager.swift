//
//  StorageManager.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 02.12.2023.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func saveVenuesToFile(items: [Venue]) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("venuesData.json")

        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(items)
            try encodedData.write(to: fileURL)
        } catch {
            print("\(error)")
        }
    }

    func loadVenuesFromFile() -> [Venue]? {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("venuesData.json")

        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL)
            let loadedItems = try decoder.decode([Venue].self, from: data)
            return loadedItems
        } catch {
            print("\(error)")
            return nil
        }
    }
}
