//
//  ViewController.swift
//  teamProjectCafeHooligan
//
//  Created by 단예진 on 7/3/24.
//

import UIKit

class ViewController: UIViewController {
    //컬렉션뷰 생성
    let menuCollectionView: UICollectionView = UICollectionView()
    
    let modeToggleButton = UIButton(type: .system)
    // B. 시스템모드에 따른 토글 아이콘 사이즈
    let sunImage = UIImage(systemName: "sun.max.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16))
    let moonImage = UIImage(systemName: "moon.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //배경화면
        view.backgroundColor = .systemBackground
        
        
        // B. 로고 이미지
        let logoImageView = UIImageView(image: UIImage(named: "logo_dark"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 8
        
        // B. 로고명 레이블
        let logoLabel = UILabel()
        logoLabel.text = "Café Hooligan"
        logoLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        logoLabel.textColor = .label
        
        // B. 다크 모드/라이트 모드 전환 버튼
        modeToggleButton.addTarget(self, action: #selector(toggleMode), for: .touchUpInside)
        
        // 아이콘 설정
        let sunImage = UIImage(systemName: "sun.max.fill")
        let tintedSunImage = sunImage?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        modeToggleButton.setImage(tintedSunImage, for: .normal)
        modeToggleButton.layer.cornerRadius = 8
        
        // B. 토글 버튼 초기 이미지 설정
        updateButtonImage()
        
        // B. horizontalStackView 생성
        let horizontalStackView = UIStackView(arrangedSubviews: [logoImageView, logoLabel, modeToggleButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        
        // B. horizontalStackView를 뷰에 추가
        view.addSubview(horizontalStackView)
        
        // B. containerView 생성
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        
        // B. containerView에 horizontalView 추가
        containerView.addSubview(horizontalStackView)
        
        // B. ContainerView를 뷰에 추가
        view.addSubview(containerView)
        
        // B. Auto Layout 설정
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Container View 제약 설정
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            // Horizontal Stack View 제약 설정
            horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
            horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -21),
            horizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            
            // B. Logo Image 제약 설정
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            modeToggleButton.widthAnchor.constraint(equalToConstant: 40),
            modeToggleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func toggleMode() {
        // B. 다크 모드/라이트 모드 전환 코드
        if traitCollection.userInterfaceStyle == .light {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    // 사용자 인터페이스 색상 모드 변화 감지, 이전 색상 모드와 현재 색상 모드가 다를 경우에만 실행
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // 현재 인터페이스 스타일에 따라 버튼 이미지 업데이트
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateButtonImage()
        }
    }
    
    func updateButtonImage () {
        // 현재 모드에 따라 배경 색 및 이미지 업데이트
        if traitCollection.userInterfaceStyle == .light {
            modeToggleButton.backgroundColor = .systemFill
            modeToggleButton.setImage(UIImage(systemName: "moon.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)

        } else if traitCollection.userInterfaceStyle == .dark {
            modeToggleButton.backgroundColor = UIColor(red: 0.182, green: 0.219, blue: 0.261, alpha: 1)
            modeToggleButton.setImage(UIImage(systemName: "sun.max.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    
}
