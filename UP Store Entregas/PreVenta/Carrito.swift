//
//  Carrito.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 15/12/22.
//  Copyright © 2020 ASNK. All rights reserved.
//

import UIKit
import CoreData
class Carrito: UIViewController,UITableViewDelegate, UITableViewDataSource {
// Variables
var cart = [Cart]()
//Elementos del viewController
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var Tabla: UITableView!
// Contexto
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarDatos()
        cambioEstado()
        total.text = "$ 0"
    }
//Funciones
    func cambioEstado(){
        if cart.count != 0{
            estado.text = "Lista de compras"
        }else{
            estado.text = "El carrito esta vacio"
        }
    }
    func mostrarDatos(){
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Cart>  = Cart.fetchRequest()
        do {
            cart = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error al mostrar el carrito", error.localizedDescription)
        }
    }
    func sumaTotal(){
        var sum = 0
               for item in cart{
                       sum += Int(item.precio)
                       total.text = "$ \(sum)"
               }
    }
//Botones
    @IBAction func borrar(_ sender: Any) {
        let context = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(borrar)
        } catch let error as NSError {
            print("Error al borrar", error.localizedDescription)
        }
        mostrarDatos()
        Tabla.reloadData()
        cambioEstado()
        let alerta = UIAlertController(title: "Carrito de compras", message: "Se eliminaron todos lo elementos", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Entendido", style: .default, handler: nil)
        alerta.addAction(accion)
        present(alerta, animated: true, completion: nil)
        total.text = "$ 0"
    }
    @IBAction func continuar(_ sender: Any) {
        if cart.count != 0{
            performSegue(withIdentifier: "irUsuarios", sender: nil)
        }else{
            let alerta = UIAlertController(title: "Carrito", message: "No tienes articulos agregados", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
        }
       
    }
//TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sumaTotal()
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let carrito = cart[indexPath.row]
        cell.textLabel?.text = carrito.producto
        cell.detailTextLabel?.text = ("$ \(carrito.precio)")
        return cell
    }
// Borrar articulo por celda
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         let contexto = conexion()
         let carrito = cart[indexPath.row]
         if editingStyle == .delete {
             contexto.delete(carrito)
             do{
                 try contexto.save()
                sumaTotal()
             }catch let error as NSError {
                 print("Hubo un error al eliminar", error.localizedDescription)
             }
         }
         mostrarDatos()
         Tabla.reloadData()
         cambioEstado()
     }
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
