//
//  FacultyCell.swift
//  Faculty Locations
//
//  Created by Giyu Tomioka on 8/17/24.
//

import UIKit
import CoreLocation

class FacultyCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func set(faculty: AUPlace) {
        nameLabel.text = faculty.facultyName
        abbreviationLabel.text = faculty.abbreviation
        
        logoImage.image = UIImage(named: faculty.imageLogoName)
        let facultyLocation = CLLocation(latitude: faculty.locationLat, longitude: faculty.locationLong)
        let initialLocation = CLLocation(latitude: 13.612320, longitude: 100.836808)
        let distance = initialLocation.distance(from: facultyLocation) // Distance in meters
        distanceLabel.text = String(format: "%.2f km", distance / 1000.0) // Convert to kilometers
         
    }
}
