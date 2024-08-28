import UIKit

class HowToPlayViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        setupInstructions()
        // Thiết lập giao diện hướng dẫn cách chơi tại đây
    }
    
    func setupInstructions() {
            // Tạo UILabel cho tiêu đề
            let titleLabel = UILabel()
            titleLabel.text = "How to Play"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
            
            // Tạo UILabel cho hướng dẫn chơi
            let instructionsLabel = UILabel()
            instructionsLabel.text = """
            1. Swipe left or right to move your car.
            
            2. Avoid hitting the obstacles (other cars).
            
            3. The longer you avoid obstacles, the higher your score.
            
            4. Collect power-ups along the way to enhance your abilities.
            
            5. The game ends if you crash into an obstacle.
            """
            instructionsLabel.font = UIFont.systemFont(ofSize: 18)
            instructionsLabel.numberOfLines = 0
            instructionsLabel.textAlignment = .left
            instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(instructionsLabel)
            
//            // Tạo nút trở lại menu
//            let backButton = UIButton(type: .system)
//            backButton.setTitle("Back to Menu", for: .normal)
//            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//            backButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
//            backButton.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(backButton)
            
            // Áp dụng layout constraints
            NSLayoutConstraint.activate([
                // Constraints cho titleLabel
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                // Constraints cho instructionsLabel
                instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
            ])
        }
        
        @objc func backToMenu() {
            dismiss(animated: true, completion: nil)
        }
}
