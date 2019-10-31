//
//  ApplicationServices.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol ApplicationServices {/* empty */}

extension ApplicationServices {

    var guests: GuestsApplicationServices { return Assembler() }

}

private struct Assembler: GuestsApplicationServices {/* empty */}
