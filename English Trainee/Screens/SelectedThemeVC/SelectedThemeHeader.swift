import UIKit
import SnapKit

final class SelectedThemeView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
      

        return view
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer:CAGradientLayer = CAGradientLayer()

        gradientLayer.colors = [UIColor.systemPink.cgColor,UIColor.white.withAlphaComponent(0).cgColor] //Or any colors
        containerView.layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Fruits"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
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
}

extension SelectedThemeView {
    func setupViwes() {
        
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(themeLabel)
        containerView.addSubview(progressLabel)
        //containerView.addSubview(headerSegmentedControl)
        
       
        
       
        
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self).inset(20)
        }
        
        themeLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(30)
        }

        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(themeLabel).inset(50)
            make.left.equalTo(self).inset(30)
        }

//        headerSegmentedControl.snp.makeConstraints { make in
//            make.left.right.equalTo(containerView)
//            make.bottom.equalTo(containerView)
//            make.height.equalTo(60)
//        }
        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.frame = containerView.bounds
        print(gradientLayer.frame, containerView.bounds)

    }
    
   

}
