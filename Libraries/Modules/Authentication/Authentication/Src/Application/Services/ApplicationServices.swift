//
//  ApplicationServices.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

protocol ApplicationServices {/* empty */}

extension ApplicationServices {

    var auth: AuthApplicationServices { return Assembler() }

}

private struct Assembler: AuthApplicationServices {/* empty */}
