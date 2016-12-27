//
//  MRTStationListViewController.swift
//  MRTStation
//
//  Created by sodas on 3/23/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit

class MRTStationListViewController: UITableViewController {


    var stationsData: MRTStationSource = MRTStationSource.default
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.stationsData.lines.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationsData.lines[section].stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the cell by reuse identifier.
        // This identifier should be set via the Storyboard.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MRTStationCell", for: indexPath) as! CustomTableViewCell

        // Get airport object from the index path
        let station = self.stationsData.lines[indexPath.section].stations[indexPath.row]

        // Setup the cell
        cell.stationNameLabel.text = station.name
        cell.stationCode1Label.text = station.stationCode[0]
        cell.stationCode1Label.backgroundColor = station.backgroundColor4Line(lineName: station.line[0])
        if station.stationCode.count > 1 {
            cell.stationCode2Label.text = station.stationCode[1]
            cell.stationCode2Label.backgroundColor = station.backgroundColor4Line(lineName: station.line[1])
        } else {
            cell.stationCode2Label.text = ""
            cell.stationCode2Label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.stationsData.lines[section].name
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the identifier of the segue
        // Here, we only handle segue we know
        if segue.identifier == "ShowDetail" {
            // Get the destination view controller and cast it to our detail view controller class
            guard let detailViewController = segue.destination as? MRTStationDetailViewController else {
                return
            }
            // Check whether the sender is cell or not, and get its index path

            guard let cell = sender as? CustomTableViewCell else {
                return
            }
            
            let indexPath = self.tableView.indexPath(for: cell)!

            // Get airport object from the index path
            let station = self.stationsData.lines[indexPath.section].stations[indexPath.row]
            // Tell the detail view controller which airport to show
            detailViewController.station = station
        } else {
            // Ask the super class to handle segues we don't know
            super.prepare(for: segue, sender: sender)
        }
    }

}
