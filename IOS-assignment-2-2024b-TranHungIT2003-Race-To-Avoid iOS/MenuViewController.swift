//
//  GameViewController.swift
//  IOS-assignment-2-2024b-TranHungIT2003-Race-To-Avoid iOS
//
//  Created by MacBook Pro Của A Tú on 23/08/2024.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuViewController: UIViewController {
    private var textField: UITextField!
    private var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let scene = GameScene.newGameScene()
//
//        // Present the scene
//        let skView = self.view as! SKView
//        skView.presentScene(scene)
        setupLogo()
        setupMenuButtons()
//
//        skView.ignoresSiblingOrder = true
//        skView.showsFPS = true
//        skView.showsNodeCount = true
        }
    private func setupLogo() {
            let logoImageView = UIImageView(image: UIImage(named: "hm2"))
            logoImageView.contentMode = .scaleAspectFit
            logoImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 400)
            logoImageView.alpha = 0.8 // Điều chỉnh độ trong suốt của logo nếu cần
            view.addSubview(logoImageView)
        }
    
    private func setupMenuButtons() {
           let buttonHeight: CGFloat = 50
           let buttonWidth: CGFloat = view.bounds.width - 40
           let buttonSpacing: CGFloat = 20
           
           let startGameButton = createButton(title: "Start Game", color: .systemBlue, yPosition: 200)
           startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
           view.addSubview(startGameButton)
           
           let leaderboardButton = createButton(title: "Leaderboard", color: .systemGreen, yPosition: 200 + buttonHeight + buttonSpacing)
           leaderboardButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
           view.addSubview(leaderboardButton)
           
           let howToPlayButton = createButton(title: "How To Play", color: .systemOrange, yPosition: 200 + (buttonHeight + buttonSpacing) * 2)
           howToPlayButton.addTarget(self, action: #selector(showHowToPlay), for: .touchUpInside)
           view.addSubview(howToPlayButton)
           
           let gameSettingsButton = createButton(title: "Game Settings", color: .systemRed, yPosition: 200 + (buttonHeight + buttonSpacing) * 3)
           gameSettingsButton.addTarget(self, action: #selector(showGameSettings), for: .touchUpInside)
           view.addSubview(gameSettingsButton)
       }
       
       private func createButton(title: String, color: UIColor, yPosition: CGFloat) -> UIButton {
           let button = UIButton(type: .system)
           button.setTitle(title, for: .normal)
           button.backgroundColor = color
           button.setTitleColor(.white, for: .normal)
           button.frame = CGRect(x: 20, y: yPosition + 200, width: view.bounds.width - 40, height: 50)
           button.layer.cornerRadius = 10
           button.clipsToBounds = true
           return button
       }
       
       @objc private func startGame() {
//           let gameVC = GameViewController()
//           navigationController?.pushViewController(gameVC, animated: true)
           showStartGamePopup()
       }
       
       @objc private func showLeaderboard() {
           let leaderboardVC = LeaderboardViewController()
           navigationController?.pushViewController(leaderboardVC, animated: true)
       }
        
       @objc private func showHowToPlay() {
           let howToPlayVC = HowToPlayViewController()
           navigationController?.pushViewController(howToPlayVC, animated: true)
       }
       
       @objc private func showGameSettings() {
           let gameSettingsVC = GameSettingsViewController()
           navigationController?.pushViewController(gameSettingsVC, animated: true)
       }
    
    private func showStartGamePopup() {
           let alertController = UIAlertController(title: "Enter Your Name", message: nil, preferredStyle: .alert)
           
           alertController.addTextField { textField in
               textField.placeholder = "Enter your name"
               textField.autocapitalizationType = .words
           }
           
           let startAction = UIAlertAction(title: "Start", style: .default) { [weak self] _ in
               guard let textField = alertController.textFields?.first, let name = textField.text, !name.isEmpty else {
                   // Handle the case where no name was entered
                   let errorAlert = UIAlertController(title: "Error", message: "Please enter a name.", preferredStyle: .alert)
                   errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                   self?.present(errorAlert, animated: true)
                   return
               }
               
               // Proceed to the game with the entered name
               self?.startGameWithName(name)
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
           
           alertController.addAction(startAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true)
       }
       
       private func startGameWithName(_ name: String) {
           // Here you can pass the entered name to the game scene or wherever needed
           let gameVC = GameViewController()
           // Optionally pass the name to GameViewController
           gameVC.playerName = name
           navigationController?.pushViewController(gameVC, animated: true)
       }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
