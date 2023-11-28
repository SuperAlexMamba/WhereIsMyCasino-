import UIKit

class ContentViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
       
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: imageName)
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var descriptionTextLabel: UILabel = {
       
        let label = UILabel()
        
        label.text = descriptionText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var pageIndex = 0
    var imageName = "Onboarding(1)"
    var descriptionText = "The excitement awaits! Embark on Your Casino Journey, it begins now!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(descriptionTextLabel)
        setupConstraints()

        
    }
    
    private func setupConstraints() {
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 61),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -61),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 67),
            
            descriptionTextLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            descriptionTextLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            descriptionTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -145)
        
        
        
        ])
        
    }
    
}
