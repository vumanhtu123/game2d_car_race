/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Tran Duy Hung
  ID: s3928533
  Created date: 12/08/2024
  Last modified: 01/09/2024
  Acknowledgement:
*/
import UIKit
import SpriteKit
import GameplayKit

class GameSettingsViewController: UIViewController {
    weak var viewController: GameViewController?
    var isDarkMode: Bool = false

    
    let changeLanguageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Language", for: .normal)
        button.addTarget(self, action: #selector(changeLanguageTapped), for: .touchUpInside)
        return button
    }()
    
    let buttonChange: UIButton = {
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Chuyển chế độ", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleDarkMode), for: .touchUpInside)
        return toggleButton
    }()

    
    @objc func toggleDarkMode() {
        isDarkMode.toggle() // Đổi trạng thái
        updateUI() // Cập nhật giao diện
    }
    
    func updateUI() {
        if isDarkMode {
            // Cập nhật giao diện cho chế độ tối
            view.backgroundColor = UIColor.black
            // Thay đổi các tài nguyên khác cho chế độ tối
        } else {
            // Cập nhật giao diện cho chế độ sáng
            view.backgroundColor = UIColor.white
            // Thay đổi các tài nguyên khác cho chế độ sáng
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(changeLanguageButton)
        view.addSubview(buttonChange)
        updateUI()
        setupButtonConstraints()
        // Thiết lập giao diện cài đặt trò chơi tại đây
    }
    
    func setupButtonConstraints() {
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLanguageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeLanguageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        buttonChange.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonChange.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonChange.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
    
    @objc func changeLanguageTapped() {
        // Hiện một action sheet cho phép chọn ngôn ngữ
        let alertController = UIAlertController(title: "Choose Language", message: nil, preferredStyle: .actionSheet)
        
        let englishAction = UIAlertAction(title: "English", style: .default) { _ in
            self.setLanguage(language: "en")
        }
        
        let vietnameseAction = UIAlertAction(title: "Tiếng Việt", style: .default) { _ in
            self.setLanguage(language: "vi")
        }
        
        alertController.addAction(englishAction)
        alertController.addAction(vietnameseAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }

    func setLanguage(language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // Reload the app interface
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        UIApplication.shared.windows.first?.rootViewController = storyboard.instantiateInitialViewController()
        viewController?.navigationController?.popViewController(animated: true)
    }

}
