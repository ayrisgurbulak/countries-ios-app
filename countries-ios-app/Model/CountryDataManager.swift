//
//  CountryDataManager.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 9.01.2022.
//

import Foundation


struct CountryDataManager {
    
    func fetchCountryData(completion: @escaping (CountryData) ->Void) {

        let request = NSMutableURLRequest(url: NSURL(string: C.url)! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = C.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error != nil) {
                print(error!)
            }
            if let safeData = data {
                
                if let countries = parseJSON(safeData) {
                    completion(countries)
                }
            }

        })

        dataTask.resume()
        
    }
    func parseJSON(_ countries: Data) -> CountryData? {
        let decoder = JSONDecoder()
        
        do{
            let countries = try decoder.decode(CountryData.self, from: countries)
            return countries
            
        }catch {
            print(error)
            return nil
        }
    }
    
    
    func fetchCountryCodeData(code: String, completion: @escaping (CountryCodeData) ->Void) {

        let request = NSMutableURLRequest(url: NSURL(string: "\(C.url)/\(code)")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = C.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error != nil) {
                print(error!)
            }
            if let safeData = data {
                
                if let country = parseCodeJSON(safeData) {
                    completion(country)
                }
            }

        })

        dataTask.resume()
        
    }
    func parseCodeJSON(_ country: Data) -> CountryCodeData? {
        let decoder = JSONDecoder()
        
        do{
            let countries = try decoder.decode(CountryCodeData.self, from: country)
            return countries
            
        }catch {
            print(error)
            return nil
        }
    }
    

}
