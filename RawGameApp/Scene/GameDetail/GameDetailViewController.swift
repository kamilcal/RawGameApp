//
//  GameDetailViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {
    
    //MARK: - Outlets and Variables

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
    
    var id: Int? {
        didSet {
            print("detail:\(id)")
            
        }
    }
    private let viewModel = DetailViewModel()
//    var dataManager: CoreDataManager = { return CoreDataManager() }()
    
    
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
//        activityIndicator.startAnimating()

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
            localNotificationManager.shared.scheduleNotification(title: "askdnja", body: "dmklasdlas")
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
    
//    private func addToFavouriteGame() {
//        guard let id = id else { return }
//        let name = viewModel.gameDetailResult?.name ?? ""
//        let releaseDate = viewModel.gameDetailResult?.released ?? ""
//        let description = viewModel.gameDetailResult?.gameDetailModelDescription ?? ""
//        let image = viewModel.gameDetailResult?.backgroundImage ?? ""
//        let added = viewModel.gameDetailResult?.added ?? 0
//        let reviewsCount = viewModel.gameDetailResult?.reviewsCount ?? 0
//        dataManager.addFavouriteGame(gameData: GameFavoriteModel(id: id,
//                                                                 name: name,
//                                                                 gameDetailModelDescription: description,
//                                                                 backgroundImage: image,
//                                                                 added: added,
//                                                                 released: releaseDate,
//                                                                 reviewsCount: reviewsCount)) {
//            DispatchQueue.main.async {
////                TODO: LOCAL NOT.
//            }
//        }
//    }
    
//    private func removeGameFavourite(_ idGame: Int) {
//        dataManager.deleteFavouriteGame(idGame)
//            DispatchQueue.main.async {
////                TODO: LOCAL NOT.
//            }
//        }
//    }
    
}
