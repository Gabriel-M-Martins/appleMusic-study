//
//  LibraryViewController.swift
//  UIKit-Nano
//
//  Created by Eduardo Filot Brum on 19/06/23.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var musicCollectionTypeTableView: UITableView!
    
    var collectionTypes: [MusicCollectionType] = MusicCollectionType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicCollectionTypeTableView.dataSource = self
        musicCollectionTypeTableView.delegate = self
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicCollectionTypeTableView.dequeueReusableCell(withIdentifier: "MusicCollectionTypeCell", for: indexPath) as! MusicCollectionTypeTableViewCell
        
        let collectionType = collectionTypes[indexPath.row]
        
        cell.iconImage.image = UIImage(systemName: collectionType.icon)
        cell.descriptionLabel.text = collectionType.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: collectionTypes[indexPath.row].segueIdentifier, sender: collectionTypes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCollections" {
            guard let vc = segue.destination as? CollectionsViewController else { return }
            guard let info = sender as? MusicCollectionType else { return }
            
            vc.collectionType = info
            return
        }
    }
    
    //TODO: Add func prepare for segue
    
    //TODO: Add line below row
}
