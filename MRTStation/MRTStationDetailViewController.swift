//
//  MRTStationDetailViewController.swift
//  MRTStation
//
//  Created by sodas on 3/23/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit

class MRTStationDetailViewController: UIViewController {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    var station: Station? {
        didSet {
            // Update when the model is changed.
            self.updateLablesAndImages()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update when the view is loaded.
        self.updateLablesAndImages()
    }

    func updateLablesAndImages() {
        // If the view is not loaded yet, don't update
        guard self.isViewLoaded else {
            return
        }

        // Update title of the navigation bar
        self.navigationItem.title = self.station?.name

        // Update labels
        self.stationNameLabel.text = self.station?.name
        self.line1.text = self.station?.line[0]
        self.line1.backgroundColor = self.station?.backgroundColor4Line(lineName: (self.station?.line[0])!)
        if (station?.line.count)! > 1 {
            self.line2.text = self.station?.line[1]
            self.line2.backgroundColor = self.station?.backgroundColor4Line(lineName: (self.station?.line[1])!)
        } else {
            self.line2.text = self.station?.line[0]
            self.line2.backgroundColor = self.station?.backgroundColor4Line(lineName: (self.station?.line[0])!)
            
        }
        // Update images
//        var image: UIImage? = nil
//        if let imageName = self.airport?.imageName {
//             image = UIImage(named: imageName)
//        }
//        self.imageView.image = image
    }
}
