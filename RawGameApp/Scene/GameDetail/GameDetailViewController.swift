//
//  GameDetailViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var downloadLabel: UILabel!
    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    var idGame: Int?
    private let viewModel = DetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        getGameDetail()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func getGameDetail() {
        guard let getIdGame = idGame else { return }
        viewModel.fetchGamesData(idGame: getIdGame) { (result) in
            switch result {
            case .success(let data):
                self.scrollView.isHidden = false
                self.updateTableUI(data)
            case .failure(let error):
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
    private func updateTableUI(_ item: GameDetailModel) {
        guard let url = URL(string: item.backgroundImage ?? "" ) else { return }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        imageView.sd_setImage(with: url)
        backgroundView.sd_imageIndicator = SDWebImageActivityIndicator.large
        backgroundView.sd_setImage(with: url)
        titleLabel.text = item.name
        reviewsLabel.text = String(item.reviewsCount)
        releasedLabel.text = item.released
        downloadLabel.text = String(item.added)
        textView.text = item.gameDetailModelDescription
        
        imageView.layer.cornerRadius = 10
        
    }
}
