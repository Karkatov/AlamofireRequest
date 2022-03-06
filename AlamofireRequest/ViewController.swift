//
//  ViewController.swift
//  AlamofireRequest
//
//  Created by Duxxless on 05.03.2022.
//


import UIKit
import Alamofire

class ViewController: UIViewController {
    let imageView =  UIImageView()
    let completedLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let progressView = UIProgressView()
    var repeatButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        completedLabel.frame = CGRect(x: view.center.x - 200, y: 100, width: 400, height: 50)
        view.addSubview(completedLabel)
        
        progressView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 40)
        view.addSubview(progressView)
        
        repeatButton = UIButton(type: .system)
        repeatButton.setTitle("Дальше", for: .normal)
        repeatButton.backgroundColor = .systemBlue
        repeatButton.layer.cornerRadius = 20
        repeatButton.tintColor = .white
        repeatButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        repeatButton.frame = CGRect(x: view.frame.size.width/2 - 50, y: 700, width: 100, height: 50)
        view.addSubview(repeatButton)
        repeatButton.addTarget(self, action: #selector(nextImage), for: .touchUpInside)
        
        showImage()
    }
    
    func showImage() {
        
        let urlString =  "https://loremflickr.com/3840/2160"
        guard let url = URL(string: urlString) else { return }
        AF.download(url)
        
            .validate()
        
        // progress %
            .downloadProgress { (progress) in
                //self.completedLabel.text = progress.localizedDescription
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
        // response
            .responseData { (response) in
                if let data = response.value {
                    let imageData = UIImage(data: data)
                    self.imageView.image = imageData
                    
                } else {
                    self.completedLabel.text = "Ошибка загрузки"
                }
            }
    }
    
    @objc func nextImage() {
        showImage()
    }
}
