import UIKit
import SpriteKit
import GameplayKit

class GameSettingsViewController: UIViewController {
    weak var viewController: GameViewController?
    
    let changeLanguageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Language", for: .normal)
        button.addTarget(self, action: #selector(changeLanguageTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(changeLanguageButton)
           setupButtonConstraints()
        // Thiết lập giao diện cài đặt trò chơi tại đây
    }
    
    func setupButtonConstraints() {
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLanguageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeLanguageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
