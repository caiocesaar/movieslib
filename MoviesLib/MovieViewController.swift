//
//  ViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 11/02/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit


class MovieViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbSumary: UITextView!
    @IBOutlet weak var lbRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            //ivPoster.image = UIImage(named: movie.image)
            lbTitle.text = movie.title
            lbCategory.text = movie.categories
            lbDuration.text = movie.duration
            lbRating.text = "⭐️ \(movie.rating)/10"
            lbSumary.text = movie.sumary
        }
    }

    
}

