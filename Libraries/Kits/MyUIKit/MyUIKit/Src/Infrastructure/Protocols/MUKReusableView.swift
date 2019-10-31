//
//  MUKReusableView.swift
//  MyUIKit
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import UIKit

public protocol MUKReusableView: class {/* empty */}

extension MUKReusableView where Self: UIView {

    static var identifier: String { return String(describing: self) }

}
