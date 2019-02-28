//
//  ViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 11/02/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit
import AVKit

class MovieViewController: UIViewController {
    
    //MARK: Proprieties
    var movie: Movie?
    var trailer : String = ""
    var moviePlayer : AVPlayer?
    var moviePlayerController : AVPlayerViewController?
    
    //MARK: - Outlets
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbSumary: UITextView!
    @IBOutlet weak var lbRating: UILabel!
    
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = movie?.title {
            loadTrailer(title: title)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovie()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieRegisterViewController {
            vc.movie = movie
        }
    }
    
    //MARK: - Methods
    func getMovie(){
        if let movie = movie{
            ivPoster.image = movie.image as? UIImage
            lbTitle.text = movie.title
            lbCategory.text = movie.categories
            lbDuration.text = movie.duration
            lbRating.text = "⭐️ \(movie.rating)/10"
            lbSumary.text = movie.sumary
        }
    }
    
    func loadTrailer(title: String){
        API.loadTrailers(title: title) { (apiResult) in
            guard let results = apiResult?.results, let trailer = results.first
                else {return}
            self.trailer = trailer.previewUrl
            DispatchQueue.main.async {
                self.prepareVideo()
            }
            
        }
    }
    
    func prepareVideo(){
        guard let url = URL(string: trailer) else {return}
        moviePlayer = AVPlayer(url: url)
        moviePlayerController = AVPlayerViewController()
        moviePlayerController?.player = moviePlayer
        moviePlayerController?.showsPlaybackControls = true
        
    }
    
    //MARK: - Actions
    @IBAction func btnPlayMovieTrailer(_ sender: UIButton) {
        guard let moviePlayerController = moviePlayerController else {return}
        present(moviePlayerController, animated: true, completion: nil)
    }
    
}

