//
//  MRTStationData.swift
//  MRTStation
//
//  Created by sodas on 3/23/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import Foundation
//import SwiftyJSON
import UIKit
// MARK: Properties
// ---------------------------------------------------------------------------------------------------------------------


struct MRTStationSource {
    let lines: [Line]
}

struct Line {
    let name: String
    let stations: [Station]
}

struct Station {
    let name: String
    var line: [String]
    var stationCode: [String]

}


// MARK: - Loaders
// ---------------------------------------------------------------------------------------------------------------------
//    /**
//     Convert a subJSON into object instances.
//     */
extension Station {
    init?(fromJSON subJson: JSON){
        let stationName = subJson["name"].stringValue
        self.name = stationName
        let linesDict = subJson["lines"].dictionaryObject
        let line = [String](linesDict!.keys)
        self.line = line
        let stationCode = [Any](linesDict!.values)
        self.stationCode = stationCode as! [String]
    }
    //    * `文湖線` - rgb(158, 101, 46)
    //    * `淡水信義線` - rgb(203, 44, 48)
    //    * `新北投支線` - rgb(248, 144, 165)
    //    * `松山新店線` - rgb(0, 119, 73)
    //    * `小碧潭支線` - rgb(206, 220, 0)
    //    * `中和新蘆線` - rgb(255, 163, 0)
    //    * `板南線` - rgb(0, 94, 184)
    //    * `貓空纜車` - rgb(119, 185, 51)
    
    func backgroundColor4Line(lineName: String) -> UIColor {
        switch lineName {
        case "文湖線":
            return UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1)
        case "淡水信義線":
            return UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1)
        case "新北投支線":
            return UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1)
        case "松山新店線":
            return UIColor(red: 0, green: 119/255, blue: 73/255, alpha: 1)
        case "小碧潭支線":
            return UIColor(red: 206/255, green: 220/255, blue: 0, alpha: 1)
        case "中和新蘆線":
            return UIColor(red: 255/255 , green: 163/255, blue: 0, alpha: 1)
        case "板南線":
            return UIColor(red: 0, green: 94/255, blue: 184/255, alpha: 1)
        case "貓空纜車":
            return UIColor(red: 119/255, green: 185/255, blue: 51/255, alpha: 1)
        default:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
}

//enum AirportsSourceErrorType: Error {
//    case fileNotFound
//    case invalidContent
//}

extension MRTStationSource {

    init(contentsOfFile path: String) throws {
        // Read json file into string and use swiftyJSON to get data
        let jsonString = try! String.init(contentsOfFile: path)
        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)
        let json = JSON(data: dataFromString!)

        // Create a dictionary which keys are line name and values are stations list
        var dictOfLineAndStations = [String: [Station]]()
        for (_,subJson):(String, JSON) in json {
            let linesDict = subJson["lines"].dictionaryObject
            //            var station = Station(fromJSON: subJson)            
            var station = Station(fromJSON: subJson)
            
            for line in linesDict!.keys {
                if dictOfLineAndStations[line] == nil {
                    // Create an array to put station by line name
                    dictOfLineAndStations[line] = []
                }
                //fisrt line the station belong to must confirm with the line
                if line != station?.line[0] {
                   station?.line = (station?.line.reversed())!
                   station?.stationCode = (station?.stationCode.reversed())!
                }
                dictOfLineAndStations[line]!.append(station!)
            }
        }
        
        // Create a lines array and convert previous dictionary
        var lines = [Line]()
        for (lineName,station) in dictOfLineAndStations {
            // Sort stations by their name
            let sortedStations = station.sorted(by: { (station1: Station, station2: Station) -> Bool in
                return station1.stationCode[0] < station2.stationCode[0]
            })
            // Create the line object
            let line = Line(name: lineName, stations: sortedStations)
            lines.append(line)
        }
        // Sort lines by their name
        self.lines = lines.sorted { (line1: Line, line2: Line) -> Bool in
            return line1.name < line2.name
        }
        
    }
}

// MARK: - Default content
// ---------------------------------------------------------------------------------------------------------------------

extension MRTStationSource {
    private static func loadDefaultSource() -> MRTStationSource {
        // Get default json file from the Bundle
        let dataPath = Bundle.main.path(forResource: "MRT", ofType: "json")!
        // Create the source
        guard let source = try? MRTStationSource(contentsOfFile: dataPath) else {
            fatalError()
        }
        return source
    }

    static let `default`: MRTStationSource = loadDefaultSource()
}
