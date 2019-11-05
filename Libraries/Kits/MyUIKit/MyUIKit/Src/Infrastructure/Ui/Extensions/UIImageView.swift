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

    func load(string: String) {
        guard let url = URL(string: string) else { return }
        load(url: url)
    }

    func load(url: URL) {
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
