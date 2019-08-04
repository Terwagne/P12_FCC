//
//  AgendaTableViewController.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 27/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Alamofire


class AgendaTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var movies: [Movies]?
    let apiServices = ApiServices()
    var apiMovieDetail: ApiMovieDetail?
    var apiMovies: ApiMovies?
    var mov: Movies?
//    var productionCountry: ProductionCountry?
 
    let decoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        tableView.dataSource = self
        tableView.delegate = self

        getMovies()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func getMovies() {
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let imageRef = storageRef.child("images")
        let db = Firestore.firestore()
        db.collection("movies").order(by: "id").getDocuments { (snapshot, error) in
            if error != nil {
                print ("error")
            }else{
                if let snapshot = snapshot {
                  
                     self.movies = try! snapshot.decoded()
                    
                    print(self.movies as Any)
                    
                }
    
                self.tableView.reloadData()

                }
            }
        }

//     MARK: Animation
    func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }

    func updateDetailAgenda(indexPath: IndexPath) {
        self.mov = movies?[indexPath.row]
        self.performSegue(withIdentifier: "movieDetail", sender: self)
    }
//     MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName = "movieDetail"
        if segue.identifier == segueName {
            let movieDetailVC = segue.destination as? DetailAgendaViewController
            movieDetailVC!.apiMovieDetail = apiMovieDetail
            movieDetailVC!.movies = movies
            movieDetailVC!.mov = mov
            movieDetailVC?.apiMovies = apiMovies
        }
    }
    
}
// MARK: - Table view data source
extension  AgendaTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else { return 0 }
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as? AgendaTableViewCell else {return UITableViewCell() }
        guard let movies = movies else { return UITableViewCell() }
       cell.mov = movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let id = movies![indexPath.row].tmdb
           print("requestSearchForMoviesWithID")
                toggleActivityIndicator(shown: true)
            apiServices.searchMovieDetail(id: id){ (success, apiMovieDetail) in
            if success {
                print("success")
                guard let apiMovieDetail = apiMovieDetail else {return}
                self.apiMovieDetail = apiMovieDetail
                print(apiMovieDetail)
//                self.performSegue(withIdentifier: "movieDetail", sender: apiMovieDetail)
                self.updateDetailAgenda(indexPath: indexPath)

            } else {
                let title = self.movies![indexPath.row].title
                print("requestSearchForMoviesWithTitle")
                self.toggleActivityIndicator(shown: true)
                self.apiServices.searchMovies(title: title){ (success, apiMovies) in
                    if success {
                        print("success")
                        guard let apiMovies = apiMovies else {return}
                        self.apiMovies = apiMovies
                        print(self.apiMovies as Any)
//                self.updateDetailAgenda(indexPath: indexPath)
                
                    }else{
                
                
                self.alert(message: "The search failed")
            }
        }
    }
}
    }
}
extension AgendaTableViewController {
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
