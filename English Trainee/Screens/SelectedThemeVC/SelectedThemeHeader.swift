import UIKit
import SnapKit

protocol SelectedThemeHeaderProtocol {
    func updateProgress()
}

class SelectedThemeHeader: UIView {
    
    var delegate: SelectedThemeVCProtocol?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0
        view.backgroundColor = .clear
        view.alpha = 0.3
        
        return view
    }()
    
    ///Label with name of the selected Category
    lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.numberOfLines = 2
        return label
    }()
    
    ///This label is need to monitor how many words user has learned
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
        return label
    }()
    
    ///Button which opens new screen with quize game of the learned words from the current category
    lazy var practiceLearnedWordsButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitle("Practice the learned words", for: .normal)
        button.addTarget(self, action: #selector(openFirstGameVC), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func openFirstGameVC(sender: UIButton!) {
            
        guard let gameType = sender.titleLabel?.text else { return }

        
            self.delegate?.openQuizeGameVC(gameType)
            delegate?.openQuizeGameVC(gameType)
    }
    
    ///Button which opens new screen with quize game of the whole words from the current category
    lazy var practiceAllWordsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.setTitle("Practice all words", for: .normal)
        button.addTarget(self, action: #selector(openSecondGameVC), for: .touchUpInside)
        return button
    }()
    
    @objc func openSecondGameVC(sender: UIButton!) {
        
        guard let gameType = sender.titleLabel?.text else { return }
        
        self.delegate?.openQuizeGameVC(gameType)
        delegate?.openQuizeGameVC(gameType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViwes()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    //MARK: Updates label with theme. This method is used in viewDidLoad method of SelectedThemeVC class
    func updateTheme(theme: String) {
        themeLabel.text = theme
    }
    
    func updateProgress() {
        progressLabel.text = "123"
    }
    
}

extension SelectedThemeHeader {
    func setupViwes() {
        
        backgroundColor = .clear
        addSubview(containerView)
        addSubview(themeLabel)
        addSubview(progressLabel)
        addSubview(practiceLearnedWordsButton)
        addSubview(practiceAllWordsButton)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview() 
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(self).inset(130)
        }
        
        themeLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(30)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(themeLabel).inset(100)
            make.left.equalTo(self).inset(30)
        }
        practiceLearnedWordsButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp_bottomMargin).offset(25)
            make.left.right.equalTo(self).inset(15)
            make.bottom.equalTo(containerView.snp_bottomMargin).offset(75)
        }
        practiceAllWordsButton.snp.makeConstraints { make in
            make.top.equalTo(practiceLearnedWordsButton.snp_bottomMargin).offset(15)
            make.left.right.equalTo(self).inset(15)
            make.bottom.equalTo(practiceLearnedWordsButton.snp_bottomMargin).offset(65)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientVC()
    }
}

///Gradient Settings
extension SelectedThemeHeader {
    func setupGradientVC() {
        let colorLeft =  UIColor.leftAppBackgroundColor.cgColor
        let colorRight = UIColor.blue.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.locations = [0.1, 1.0]
        gradientLayer.frame = containerView.bounds
        containerView.layer.insertSublayer(gradientLayer, at:0)
    }
    
}
