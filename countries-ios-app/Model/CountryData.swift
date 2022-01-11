//
//  CountryData.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 9.01.2022.
//

import Foundation

struct CountryData: Decodable {
    let data: [countryData]
}

struct countryData: Decodable {
    let name: String
    let code: String
}
