//
//  InformationsViewController.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 04/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit

class InformationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func getAdhesionUrl(_ sender: Any) {
        let urlAdhesionSource = "https://www.helloasso.com/associations/film-club-de-cannes/adhesions/adhesion-au-film-club-de-cannes-saison-2019-2020"
        print("source : \(urlAdhesionSource)")
        guard let url = URL(string: urlAdhesionSource) else {return}
        UIApplication.shared.open(url)
    }
    @IBAction func getWebsiteUrl(_ sender: Any) {
        let urlSiteSource = "https://filmclubcannes.net/"
        print("source : \(urlSiteSource)")
        guard let url = URL(string: urlSiteSource) else {return}
        UIApplication.shared.open(url)
    }
}
