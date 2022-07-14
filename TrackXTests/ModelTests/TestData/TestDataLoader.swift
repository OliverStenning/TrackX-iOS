//
//  TestData.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import Foundation

class TestDataLoader {
    
    func getTestObjectFromJson<T>(_ type: T.Type, name: String) throws -> T? where T : Decodable {
        let bundle = Bundle(for: TestDataLoader.self)
        
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return nil
        }
        let json = try Data(contentsOf: url)
        
        let object = try JSONDecoder().decode(type, from: json)
        return object
    }

    
}
