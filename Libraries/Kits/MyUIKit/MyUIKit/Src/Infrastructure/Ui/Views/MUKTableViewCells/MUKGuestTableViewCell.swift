//
//  MUKGuestTableViewCell.swift
//  MyUIKit
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import SnapKit
import UIKit

public final class MUKGuestTableViewCell: UITableViewCell, MUKReusableView {

    public lazy var titleLabel: UILabel = {
        let instance        = UILabel()
        instance.textColor  = .darkText
        instance.font       = .systemFont(ofSize: 16, weight: .bold)

        return instance
    }()

    public lazy var subtitleLabel: UILabel = {
        let instance        = UILabel()
        instance.textColor  = .darkGray
        instance.font       = .systemFont(ofSize: 14, weight: .light)

        return instance
    }()

    lazy var contentStackView: UIStackView = {
        let instance        = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        instance.axis       = .vertical
        instance.alignment  = .fill
        instance.spacing    = 8.0

        return instance
    }()

    // MARK: - Constructors

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        addSubview(contentStackView)

        contentStackView.snp.makeConstraints { make in
            let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            make.top.left.right.equalToSuperview().inset(inset)
            make.bottom.lessThanOrEqualToSuperview().inset(inset)
        }
    }

}
