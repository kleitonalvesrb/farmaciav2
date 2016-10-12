//
//  Medicamento.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit

class Medicamento: NSObject {
    var fotoMedicamento: UIImage!
    var codBarras:String!
    var nome:String!
    var principioAtivo:String!
    var apresentacao:String!
    var laboratorio:String!
    var classeTerapeutica:String!
    var dosagemMedicamento: DosagemMedicamento!
}
