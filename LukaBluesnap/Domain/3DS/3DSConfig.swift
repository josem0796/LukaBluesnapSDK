//
//  3DSConfig.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 3/4/24.
//

import Foundation

struct Country {
    let name: String
    let isoCode: String
    let telephoneCode: Int
}

struct ThreeDSConfig {
  static let europe = [
    Country(name: "Russia", isoCode: "RU", telephoneCode: 7),
    Country(name: "Germany", isoCode: "DE", telephoneCode: 49),
    Country(name: "United Kingdom", isoCode: "GB", telephoneCode: 44),
    Country(name: "France", isoCode: "FR", telephoneCode: 33),
    Country(name: "Italy", isoCode: "IT", telephoneCode: 39),
    Country(name: "Spain", isoCode: "ES", telephoneCode: 34),
    Country(name: "Ukraine", isoCode: "UA", telephoneCode: 380),
    Country(name: "Poland", isoCode: "PL", telephoneCode: 48),
    Country(name: "Romania", isoCode: "RO", telephoneCode: 40),
    Country(name: "Netherlands", isoCode: "NL", telephoneCode: 31),
    Country(name: "Belgium", isoCode: "BE", telephoneCode: 32),
    Country(name: "Czech Republic", isoCode: "CZ", telephoneCode: 420),
    Country(name: "Greece", isoCode: "GR", telephoneCode: 30),
    Country(name: "Portugal", isoCode: "PT", telephoneCode: 351),
    Country(name: "Sweden", isoCode: "SE", telephoneCode: 46),
    Country(name: "Hungary", isoCode: "HU", telephoneCode: 36),
    Country(name: "Belarus", isoCode: "BY", telephoneCode: 375),
    Country(name: "Austria", isoCode: "AT", telephoneCode: 43),
    Country(name: "Serbia", isoCode: "RS", telephoneCode: 381),
    Country(name: "Switzerland", isoCode: "CH", telephoneCode: 41),
    Country(name: "Bulgaria", isoCode: "BG", telephoneCode: 359),
    Country(name: "Denmark", isoCode: "DK", telephoneCode: 45),
    Country(name: "Finland", isoCode: "FI", telephoneCode: 358),
    Country(name: "Slovakia", isoCode: "SK", telephoneCode: 421),
    Country(name: "Norway", isoCode: "NO", telephoneCode: 47),
    Country(name: "Ireland", isoCode: "IE", telephoneCode: 353),
    Country(name: "Croatia", isoCode: "HR", telephoneCode: 385),
    Country(name: "Moldova", isoCode: "MD", telephoneCode: 373),
    Country(name: "Bosnia and Herzegovina", isoCode: "BA", telephoneCode: 387),
    Country(name: "Albania", isoCode: "AL", telephoneCode: 355),
    Country(name: "Lithuania", isoCode: "LT", telephoneCode: 370),
    Country(name: "North Macedonia", isoCode: "MK", telephoneCode: 389),
    Country(name: "Slovenia", isoCode: "SI", telephoneCode: 386),
    Country(name: "Latvia", isoCode: "LV", telephoneCode: 371),
    Country(name: "Estonia", isoCode: "EE", telephoneCode: 372),
    Country(name: "Montenegro", isoCode: "ME", telephoneCode: 382),
    Country(name: "Luxembourg", isoCode: "LU", telephoneCode: 352),
    Country(name: "Malta", isoCode: "MT", telephoneCode: 356),
    Country(name: "Iceland", isoCode: "IS", telephoneCode: 354),
    Country(name: "Andorra", isoCode: "AD", telephoneCode: 376),
    Country(name: "Monaco", isoCode: "MC", telephoneCode: 377),
    Country(name: "Liechtenstein", isoCode: "LI", telephoneCode: 423),
    Country(name: "San Marino", isoCode: "SM", telephoneCode: 378)
  ]
}
