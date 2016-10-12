//
//  Usuario.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit

class Usuario: NSObject {
    var id:Int!
    var idade:Int!
    var email:String!
    var nome:String!
    var senha:String!
    var idFacebook:String!
    var foto:UIImage!
    var sexo:String!
    var medicamento = [Medicamento]()
    
    static let sharedInstance = Usuario()
    
    func convertStringToImage(str: String) -> UIImage{
        let imageData = NSData(base64EncodedString: str, options: .IgnoreUnknownCharacters)
        let imageConvertida = UIImage(data:imageData!)
        
        return imageConvertida!
    }
    
    func convertImageToString(image: UIImage) -> String{
        print("convertendo para base64")
        let image : NSData = UIImageJPEGRepresentation(image, 0.1)!
        
        let base64String = image.base64EncodedStringWithOptions([])
        return base64String
    }
    

}
