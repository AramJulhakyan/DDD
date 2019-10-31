//
//  MUKImageCollectionViewCell.swift
//  MyUIKit
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import SnapKit
import UIKit

public final class MUKImageCollectionViewCell: UICollectionViewCell, MUKReusableView {

    // MARK: - Interface

    public lazy var imageView: UIImageView = { .init() }()

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
