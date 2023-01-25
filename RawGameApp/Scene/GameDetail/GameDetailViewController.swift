//
//  GameDetailViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {
    
    @IBOutlet var reviews: UILabel!{
        didSet{
            reviews.text = NSLocalizedString("reviewsLabel", comment: "Reviews")
        }
    }
    @IBOutlet var released: UILabel!{
        didSet{
            released.text = NSLocalizedString("releasedLabel", comment: "Released")
        }
    }
    @IBOutlet var download: UILabel!{
        didSet{
            download.text = NSLocalizedString("downloadLabel", comment: "Download")
    }
}
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
    @IBOutlet var favButton: UIButton!
    @IBOutlet var overviewLabel: UILabel!
    
    
    var id: Int? {
        didSet {
        }
    }
    private let viewModel = DetailViewModel()
    
    
    //MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.hidesBackButton = true
        getGameDetail()
        isGameFavourited()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }

//MARK: - Fetch

    private func getGameDetail() {
        self.showActivityIndicator()
        guard let getIdGame = id else { return }
        viewModel.fetchGamesData(id: getIdGame) { (result) in
            switch result {
            case .success(let data):
                self.scrollView.isHidden = false
                self.updateUI(data)
                self.removeActivityIndicator()
            case .failure(let error):
                print("Error on: \(error.localizedDescription)")
                self.removeActivityIndicator()
            }
        }
    }
//MARK: - Actions

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func favButtonTapped(_ sender: Any) {
        if viewModel.isFavourited {
            guard let id = id else { return }
            viewModel.removeToGame(id: id)
        } else {
            viewModel.addToFavorite(id: id)
            localNotificationManager.shared.scheduleNotification(title: NSLocalizedString("NotificationTitle", comment: "You Have Games On Your Favorite List"), body: NSLocalizedString("NotificationBody", comment: "Watch It Now Right Now!"))
        }
        viewModel.isFavourited = !viewModel.isFavourited
        setIconFavourite()
    }
    
// MARK: - UpdateUI
    
    private func updateUI(_ item: GameDetailModel) {
        guard let url = URL(string: item.backgroundImage ?? "" ) else { return }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        imageView.sd_setImage(with: url)
        backgroundView.sd_imageIndicator = SDWebImageActivityIndicator.large
        backgroundView.sd_setImage(with: url)
        titleLabel.text = item.name
        reviewsLabel.text = String(item.reviewsCount)
        releasedLabel.text = item.released?.changeDateFormat() ?? "-"
        downloadLabel.text = String(item.added)
        textView.text = item.gameDetailModelDescription
        
        imageView.layer.cornerRadius = 10
        
    }
    
// MARK: - CoreDataManager
    
    // TODO: viewmodel'a aktar.
    private func isGameFavourited() {
        guard let id = id else { return }
        CoreDataManager.shared.isFavoritedGame(id) { (isGameAsFavourite) in
            self.viewModel.isFavourited = isGameAsFavourite
            DispatchQueue.main.async { self.setIconFavourite() }
        }
    }
    
    private func setIconFavourite() {
        if viewModel.isFavourited {
            favButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            
        }
    }
    
}
