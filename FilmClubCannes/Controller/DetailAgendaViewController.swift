//
//  DetailAgendaViewController.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 23/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Alamofire
import EventKit
import EventKitUI


class DetailAgendaViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var anneeLabel: UILabel!
    @IBOutlet weak var dureeLabel: UILabel!
    
    
    @IBOutlet weak var synopsisTextView: UITextView!
    
    @IBOutlet weak var heureLabel: UILabel!
    
    
    //    MARK: Properties
    var apiServices = ApiServices()
    var apiMovieDetail: ApiMovieDetail?
    var apiMovies: ApiMovies?
    var movies: [Movies]?
    var mov: Movies?
    var newDate: Date?
    
    override func viewDidLoad() {
        super .viewDidLoad()
//        displayMovie()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayMovie()
    }
    
    func displayMovie() {
        print(mov as Any)
        
        guard let mov = mov else {return}
        titleLabel.text = mov.title
        dateLabel.text = mov.date
        heureLabel.text = mov.heure
        placeLabel.text = mov.place
        directorLabel.text = "Réal. " + mov.director
        
        
        guard let movieDetail = apiMovieDetail else {return}
      
        let time = movieDetail.runtime.convertIntToTime
        dureeLabel.text = time
        
        
        synopsisTextView.text = movieDetail.overview
    
        guard let productionCountry = movieDetail.productionCountries.first?.name else {return}
        countryLabel.text = productionCountry
        
   
        anneeLabel.text = movieDetail.releaseDate
  
        let image = movieDetail.posterPath
        let stringUrl = "https://image.tmdb.org/t/p/w500/\(image)"
        guard let url = URL(string: stringUrl) else {return}
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(data: data! as Data)
            }
        }

    }

    
    func convertStringDateToDate(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE dd MMM yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.timeZone = TimeZone(abbreviation: "CET")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateFormatted: Date = formatter.date(from: stringDate)!
        return dateFormatted
    }
    
    
    
    
    
    @IBAction func calendarButton(_ sender: UIButton) {
        guard let mov = mov else {return}
        newDate = convertStringDateToDate(stringDate: (mov.date))
        print(newDate as Any)
        if let newDate = newDate {
        addEventToCalendar(title: (mov.title), description: mov.place, startDate: newDate, endDate: newDate)
    }
}
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        DispatchQueue.main.async { () -> Void in
            
//            DispatchQueue.global(qos: .background).async { () -> Void in
            let eventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = self.mov?.title
                    event.startDate = self.newDate
                    event.endDate = self.newDate
                    event.location = self.mov?.place
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let e as NSError {
                        completion?(false, e)
                        print("error")
                        return
                    }
                    completion?(true, nil)
                    print("saveEvent")
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    print(self.newDate as Any)
                } else {
                    completion?(false, error as NSError?)
                }
            })
        }
    }
    
    
    @IBAction func getInformations(_ sender: Any) {
        
    }

    @IBAction func getLocation(_ sender: UIButton) {
    
//self.performSegue(withIdentifier: "location", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName = "location"
        if segue.identifier == segueName {
            let movieDetailVC = segue.destination as? LocationViewController
            movieDetailVC!.movies = movies
            movieDetailVC!.mov = mov
    }
}
}
extension DetailAgendaViewController: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


