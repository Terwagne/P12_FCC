//
//  AgendaTableViewController.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 27/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
//import Firebase

class AgendaTableViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    let firestoreService = FirebaseService()
    let apiServices = ApiServices()
    var apiMovieDetail: ApiMovieDetail?
    var mov: Movies?
    var movies: [Movies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        tableView.dataSource = self
        tableView.delegate = self
        getMovies()
        tableView.reloadData()
    }
    
    func getMovies() {
        self.toggleActivityIndicator(shown: true)
        firestoreService.getMovies() { movies in
            self.toggleActivityIndicator(shown: false)
            self.movies = movies
            print(self.movies as Any)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Animation
    func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }
    
    func updateDetailAgenda(indexPath: IndexPath) {
        self.mov = movies?[indexPath.row]
        self.performSegue(withIdentifier: "movieDetail", sender: self)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName = "movieDetail"
        if segue.identifier == segueName {
            let movieDetailVC = segue.destination as? DetailAgendaViewController
            movieDetailVC!.apiMovieDetail = apiMovieDetail
            movieDetailVC!.movies = movies
            movieDetailVC!.mov = mov
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
        apiServices.searchMovieDetail(id: id) { (success, apiMovieDetail) in
            if success {
                print("success")
                guard let apiMovieDetail = apiMovieDetail else {return}
                self.apiMovieDetail = apiMovieDetail
                print(apiMovieDetail)
                self.updateDetailAgenda(indexPath: indexPath)
            } else {
                self.alert(message: "The search failed")
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
