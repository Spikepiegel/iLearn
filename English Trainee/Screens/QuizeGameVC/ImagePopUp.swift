//
//  ImagePopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 18.05.2023.
//

import Foundation
import SnapKit
import UIKit


class ImagePopUp: UIViewController {
    
    var imageUrl: String?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var yandexImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        return image
    }()
    

    
    lazy var closePopUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Got it!", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonPressed(sender: UIButton!) {
        dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        dowloadImage()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(yandexImage)
        containerView.addSubview(closePopUpButton)
    }
    
    
    func setupConstraints() {
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.height.equalTo(450)
            make.center.equalTo(view)
        }
        yandexImage.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(20)
            make.left.right.equalTo(containerView).inset(5)
            make.height.equalTo(350)
        }
        closePopUpButton.snp.makeConstraints { make in
            make.top.equalTo(yandexImage.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(60)
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView).inset(15)
        }
    }
    
    func dowloadImage() {
        if let imageUrl = imageUrl, let imageURL = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Ошибка загрузки изображения: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.yandexImage.image = image
                    }
                } else {
                    print("Невозможно создать изображение из загруженных данных.")
                }
            }.resume()
        }
    }
    
}
