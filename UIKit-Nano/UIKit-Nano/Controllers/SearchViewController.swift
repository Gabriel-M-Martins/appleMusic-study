//
//  SearchViewController.swift
//  UIKit-Nano
//
//  Created by Eduardo Brum on 23/06/23.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    var collections: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BigCardTableViewCell", bundle: nil), forCellReuseIdentifier: "BigCardCell")
        
        searchController.searchBar.placeholder = "Artists, Songs, Lyrics, and More"
        navigationItem.searchController = searchController
        
        collections = MusicService.shared.loadLibrary()
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BigCardCell", for: indexPath) as! BigCardTableViewCell
        
        let collectionId = collections[indexPath.row].id
        
        cell.imageCover.image = MusicService.shared.getCoverImage(forItemIded: collectionId)
        cell.title.text = MusicService.shared.getCollection(id: collectionId)?.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toOpenedCollection", sender: collections[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOpenedCollection" {
            guard let vc = segue.destination as? OpenedCollectionViewController else { return }
            
            guard let collection = sender as? MusicCollection else { return }
            
            vc.collection = collection
        }
    }
}
