//
//  StockDetail.swift
//  StocksAPIWebChallenge
//
//  Created by Felix Yu on 2/28/21.
//

import Foundation
//create a Codable for the API JSON Stock Data
//Must go from top down

struct StockDetail: Codable {
    //Stock codeable with MetaData and TimeSeriesDaily
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
        //CodingKeys are a type used for encoding and decoding JSON. This tells the JSON what keys to look for.
    }
}

struct MetaData: Codable {
    let information, symbol, lastRefreshed, outputSize: String
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

struct TimeSeriesDaily: Codable {
    let open, high, low, close: String
    let volume: String
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}
