//
//  Util.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit

class Util: NSObject {
    func isVazio(txt : String) -> Bool{
        return txt == ""
    }
    /**
     Configura label de informação que será apresentada no momento que o usuario interagir com o app
     */
    func configuraLabelInformacao(label: UILabel, comInvisibilidade visibilidadeLabel:Bool, comIndicador indicador:UIActivityIndicatorView, comInvisibilidade visibilidadeIndicator:Bool, comAnimacao animacao:Bool){
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.hidden = visibilidadeLabel
        indicador.hidden = visibilidadeIndicator
        if animacao {
            indicador.startAnimating()
        }else{
            indicador.stopAnimating()
        }
        
    }
    /**
     Converte uma string base64 em uma imagem
     */
    func convertStringToImage(str: String) -> UIImage{
        let imageData = NSData(base64EncodedString: str, options: .IgnoreUnknownCharacters)
        let imageConvertida = UIImage(data:imageData!)
        
        return imageConvertida!
    }
    /**
     Converte uma imagem em String de base 64
     */
    func convertImageToString(image: UIImage) -> String{
        print("convertendo para base64")
        let image : NSData = UIImageJPEGRepresentation(image, 0.1)!
        
        let base64String = image.base64EncodedStringWithOptions([])
        return base64String
    }
    /**
     Retorna o valor real em ML
     */
    func valorQuantidadeDoseMlAndGotas(qtd: String) -> Double{
        return Double(qtd.componentsSeparatedByString(" ")[0])!
    }
    /**
     Retorna o valor de dias em inteiro, retornará 1000 dias caso seja necessario tomar todos os dias
     */
    func valorTempoDias(qtd: String) -> Int{
        if qtd == "Todos os Dias"{
            print("todos os dias <----")
            return 1000
        }
        return Int(qtd.componentsSeparatedByString(" ")[0])!
    }
    /**
     Retornar o intervalo de horas
     */
    func valorIntervalo(qtd: String) -> Int{
        return Int(qtd.componentsSeparatedByString(" ")[0])!
    }
    
    /**
     Retornar o valor real dos comprimido
     */
    func valorQuantidadeDoseComprimido(qtd: String) -> Double{
        var valorReal:Double;
        switch qtd {
        case "1/4":
            valorReal = 1/4
            break
        case "1/3":
            valorReal = 1/3
            break
        case "1/2":
            valorReal = 1/2
            break
        case "1":
            valorReal = 1
            break
        case "1 1/4":
            valorReal = 1 + 1/4
            break
        case "1 1/3":
            valorReal = 1 + 1/3
            break
        case "1 1/2":
            valorReal = 1 + 1/2
            break
        case "2":
            valorReal = 2
            break
        case "2 1/4":
            valorReal = 2 + 1/4
            break
        case  "2 1/3":
            valorReal = 2 + 1/3
            break
        case "2 1/2":
            valorReal = 2 + 1/2
            break
        case "3":
            valorReal = 3
            break
        case "3 1/4":
            valorReal = 3 + 1/4
            break
        case "3 /1/3":
            valorReal = 3 + 1/3
            break
        case "3 1/2":
            valorReal = 3 + 1/2
            break
        case "4":
            valorReal = 4
            
        default:
            valorReal = 0
        }
        return valorReal
    }
    

}
