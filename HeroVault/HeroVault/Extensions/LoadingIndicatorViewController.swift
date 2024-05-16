//
//  LoadingIndicatorViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/15.
//

//import Foundation
//import UIKit
//
//class LoadingIndicatorViewController: UIViewController {
//    
//    @IBOutlet weak var loaderContainer: UIView!
//    @IBOutlet weak var loaderImageView: UIImageView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loaderContainer.layer.borderWidth = 1.0
//        loaderContainer.layer.borderColor = UIColor.clear.cgColor
//        loaderContainer.layer.cornerRadius = 4.0
//        loaderContainer.clipsToBounds = true
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        startAnimation()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        stopAnimation()
//    }
//    
//    init() {
//        super.init(nibName: "LoadingIndicatorViewController", bundle: Bundle(for: LoadingIndicatorViewController.self))
//        self.modalPresentationStyle = .overCurrentContext
//        self.modalTransitionStyle = .crossDissolve
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func startAnimation() {
//        let rotation = CABasicAnimation(keyPath: "transform.rotation")
//        rotation.fromValue = 0
//        rotation.toValue = 2 * Double.pi
//        rotation.duration = 1.0
//        rotation.repeatCount = .infinity
//        loaderImageView.layer.add(rotation, forKey: "spin")
//    }
//
//    private func stopAnimation() {
//        loaderImageView.layer.removeAllAnimations()
//    }
//}
////
////extension UIViewController {
////    func loader() -> UIAlertController {
////        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
////        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
////        loadingIndicator.hidesWhenStopped = true
////        loadingIndicator.style = UIActivityIndicatorView.Style.large
////        loadingIndicator.startAnimating()
////        alert.view.addSubview(loadingIndicator)
////        present(alert, animated: true, completion: nil)
////        return alert
////    }
////    func stopLoader(loader: UIAlertController) {
////        DispatchQueue.main.async {
////            loader.dismiss(animated: true, completion: nil)
////        }
////    }
////}
