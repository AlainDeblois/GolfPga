//
//  APIHelper.swift
//  ApprendreAPI
//
//  Created by Alain Deblois on 2023-10-13.
//

import Foundation

class APIHelper  {
    static let shared = APIHelper()

    let apiEntryPoint = "https://api.sportsdata.io/golf/v2/json/Tournaments/"
    var apiKey: String = "key=f2a14a802d664df18d7197d9afe3d84d"
    
    func getUrl(season: String) -> URL? {
        var urlStr = apiEntryPoint
        urlStr += season
        urlStr += "?"
        urlStr += apiKey
        return URL(string: urlStr)
    }
    
    func performRequest(season: String, completed: @escaping( ([Tournament]) -> Void)) {
        if let url = getUrl(season: season) {
            URLSession.shared.dataTask(with: url) { jsondata, _, error in
                if let d = jsondata {
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode([Tournament].self, from: d)
                        completed(results)
                    } catch {
                        print("erreur: \(error.localizedDescription) \(error)")
                    }
                } else {
                    print(error!)
                    completed([])
                }
            }.resume()
        } else {
            completed([])
        }
    }
}


