//
//  PopupInfoHeaderView.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

final class PopupInfoHeaderView: UIView {

    // MARK: - Properties
    private weak var characterImageView: UIImageView!
    private weak var kidaImageView: UIImageView!


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension PopupInfoHeaderView {
    func setupViews() {
        self.characterImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "img_popup_info")
            addSubview($0)
        }

        self.kidaImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "img_logo_korean")
            addSubview($0)
        }
    }

    func setupLayoutConstraints() {
        characterImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }

        kidaImageView.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
}
