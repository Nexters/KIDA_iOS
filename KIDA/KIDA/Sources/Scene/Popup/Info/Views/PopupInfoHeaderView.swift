//
//  PopupInfoHeaderView.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

final class PopupInfoHeaderView: UIView {

    // MARK: - Properties
    private weak var imageView: UIImageView!
    private weak var titleLabel: UILabel!


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
        self.imageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "img_popup_info")
            addSubview($0)
        }

        self.titleLabel = UILabel().then {
            $0.text = KIDA_String.Popup.Info.title
            $0.font = .systemFont(ofSize: 30, weight: .bold)
            $0.textColor = .KIDA_orange()
            addSubview($0)
        }
    }

    func setupLayoutConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
}
