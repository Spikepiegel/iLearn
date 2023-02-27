import UIKit
import SnapKit


final class SelectedThemeHeader: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.8
        view.backgroundColor = .clear
        view.alpha = 0.3
        
        return view
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer:CAGradientLayer = CAGradientLayer()

        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor.lightPurpleGradientColor.cgColor,
            UIColor.cyanGradientColor.cgColor
            ]
        gradientLayer.locations = [0.3, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        containerView.layer.insertSublayer(gradientLayer, at: 0)

        return gradientLayer
    }()
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
        return label
    }()
    
    lazy var themeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Fruits")
        return image
    }()
    
    private lazy var headerSegmentedControl: UISegmentedControl = {
        let items = ["Words", "Practice"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = CGRectGetHeight(segmentedControl.bounds) / 2
        segmentedControl.layer.borderWidth = 1
        
        return segmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViwes()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateTheme(theme: String) {
        themeLabel.text = theme
    }

}

extension SelectedThemeHeader {
    func setupViwes() {
        
        backgroundColor = .clear
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        addSubview(containerView)
        addSubview(themeLabel)
        addSubview(progressLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self).inset(20)
        }
        
        themeLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(30)
        }

        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(themeLabel).inset(100)
            make.left.equalTo(self).inset(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
        containerView.backgroundColor?.withAlphaComponent(0.4)
    }
    
    private func setupGradient() {
        gradientLayer.frame = containerView.bounds
    }
}
