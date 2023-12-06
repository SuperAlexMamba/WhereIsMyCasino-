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
    
    func saveCasinosToFile(casinos: [Casino]) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("casinosData.json")

        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(casinos)
            try encodedData.write(to: fileURL)
        } catch {
            print("Ошибка при сохранении данных в файл: \(error)")
        }
    }

    func loadCasinosFromFile() -> [Casino]? {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("casinosData.json")

        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL)
            let loadedCasinos = try decoder.decode([Casino].self, from: data)
            return loadedCasinos
        } catch {
            print("Ошибка при загрузке данных из файла: \(error)")
            return nil
        }
    }
}
