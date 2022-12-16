//
//  CheckVenta.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 15/12/22.
//  Copyright © 2020 ASNK. All rights reserved.
//

import UIKit
import CoreData
class CheckVenta: UIViewController,UITableViewDataSource, UITableViewDelegate {
//Variables
    var clienteVenta : Clientes!
    var articulosCarrito = [Cart]()
// Elementos de interface
    @IBOutlet weak var Datos: UILabel!
    @IBOutlet weak var totalFinal: UILabel!
    @IBOutlet weak var numeroArticulos: UILabel!
    @IBOutlet weak var Tabla: UITableView!
//Contexto
    func Conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        monstrar()
        Datos.text = """
        Nombre: \(clienteVenta.nombre!) \(clienteVenta.apellidopaterno!) \(clienteVenta.apellidomaterno!)
        Direccion: \(clienteVenta.calle!) \(clienteVenta.numero!), \(clienteVenta.colonia!), \(clienteVenta.ciudad!)
        Numero: \(clienteVenta.numerocontacto!)
        Referencia: \(clienteVenta.referencia!)
        """
    }
    func suma(){
        var suma  = 0
        for item in articulosCarrito{
            suma += Int(item.precio)
            totalFinal.text = "$ \(suma)"
        }
    }
    func monstrar (){
      let contexto = Conexion()
        let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            articulosCarrito = try contexto.fetch(fetchRequest)
            let articulos = try contexto.fetch(fetchRequest)
            numeroArticulos.text = "\(articulos.count) articulos"
        } catch let error as NSError {
            print("Error al mostrar articulos", error.localizedDescription)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suma()
        return articulosCarrito.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let carroVenta = articulosCarrito[indexPath.row]
        cell.textLabel?.text = carroVenta.producto
        cell.detailTextLabel?.text = "$ \( carroVenta.precio)"
        return cell
    }
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func AlertEnviado(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Pedido enviado", message: "Recibimos tu pedido", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Entendido", style: .default, handler: nil)
        alerta.addAction(accion)
        present(alerta, animated: true, completion: nil)
    }
}
