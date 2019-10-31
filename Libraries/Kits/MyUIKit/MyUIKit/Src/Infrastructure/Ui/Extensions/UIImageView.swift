//
//  UIImageView.swift
//  MyUIKit
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Kingfisher
import UIKit

public extension UIImageView {

    func load(url: String) {
        guard let url = URL(string: url) else { return }

        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }

}
