//
//  FacultyDetailsViewController.swift
//  Faculty Locations
//
//  Created by Giyu Tomioka on 8/17/24.
//

import UIKit

class FacultyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var faculties: [AUPlace] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadFacultyData()
    }

    func loadFacultyData() {
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(LocationsModal.self, from: data)
            self.faculties = decoded.Places
            tableView.reloadData()
        } catch {
            print("Error: \(error)")
        }
    }
}

extension FacultyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faculties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacultyCell", for: indexPath) as! FacultyCell
        let faculty = faculties[indexPath.row]
        cell.set(faculty: faculty)
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let faculty = faculties[indexPath.row]
//        let alert = UIAlertController(title: faculty.facultyName, message: "Abbreviation: \(faculty.abbreviation)\nLatitude: \(faculty.locationLat)\nLongitude: \(faculty.locationLong)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
}
