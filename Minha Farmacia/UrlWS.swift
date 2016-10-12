//
//  UrlWS.swift
//  Minha Farmacia
//
//  Created by Kleiton Batista on 12/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit

class UrlWS: NSObject {
    private let host = "minhafarmacia-env.us-west-2.elasticbeanstalk.com"
    //private let host = "192.168.15.6"
    // private let porta = "8080/WebService"
    private let porta = "80"
    private let rota = "/cliente/"
    private let rotaMedicamento = "/medicamento/"
    /**
     url para atualizar dados do usuario
     
     */
    func urlInsereMedicamentoUsuario(email: String) -> String{
        
        return "http://\(host):\(porta)\(rotaMedicamento)atualizar/\(email)"
    }
    /**
     http://localhost:8080/WebService/medicamento/busca-medicamento/user-email/kleiton@gmail.com
     */
    func urlBuscaMedicamentoUsuario(email: String) -> String{
        return "http://\(host):\(porta)\(rotaMedicamento)busca-medicamento/email-user/\(email)"
    }
    
    /**
     //"http://192.168.0.12:8080/WebService/cliente/login/\(email)-\(senha)
     */
    func urlRealizaLogin(email: String, senha: String) -> String{
        return "http://\(host):\(porta)\(rota)login/\(email)-\(senha)"
    }
    
    /**
     "http://localhost:8080/WebService/cliente/recupera-senha/\(emailText.text!)"
     */
    func urlRecuperarSenha(email: String) -> String{
        return "http://\(host):\(porta)\(rota)recupera-senha/\(email)"
    }
    
    /**
     minhafarmacia-env.us-west-2.elasticbeanstalk.com:80/cliente/consulta-email/kleiton.a.batista@gmail.com
     http://192.168.0.12:8080/WebService/cliente/consulta-email/\(email)
     */
    func urlConsultaDisponibilidadeEmail(email: String) ->String{
        return "http://\(host):\(porta)\(rota)consulta-email/\(email)"
    }
    /**
     "http://192.168.0.12:8080/WebService/cliente/inserir"
     */
    func urlCadastrarUsuario()->String{
        return "http://\(host):\(porta)\(rota)inserir"
    }

}
