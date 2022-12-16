//
//  Abarrotes.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 15/12/22.
//  Copyright © 2020 ASNK. All rights reserved.
//

import UIKit
import CoreData
class Abarrotes: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
//Variables
    var lista = [Lista]()
    var filtroLista = [Lista]()
//Tablas
    @IBOutlet weak var Tabla: UITableView!
//SearchBar Controller
    var searchController = UISearchController(searchResultsController: nil)
//Contexto
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//Propiedades searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        Tabla.tableHeaderView = searchController.searchBar
// Base de datos
        if let filePath = Bundle.main.path(forResource: "Abarrotes", ofType: "txt"){
            do{
               let contenido = try! String(contentsOfFile: filePath)
               let fila = contenido.components(separatedBy: "\n")
                for i in 1..<fila.count {
                    
                    let datosArchivo = fila[i].components(separatedBy: "\t")
                    let campos = Lista(Art: datosArchivo[0], Price: datosArchivo[1])
                    self.lista.append(campos)
                }
            }
        }
    }
//Alerta al seleccionar
    func selectAlert (){
        let alerta = UIAlertController(title: "UP! Store", message: "Se agrego al carrito", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Entendido", style: .default, handler: nil)
        alerta.addAction(accion)
        if let presentedVC = presentedViewController{
            presentedVC.present(alerta, animated: true, completion: nil)
        }else{
            present(alerta, animated: true, completion: nil)
        }
    }
///TableView
// Seleccionar celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cart = Tabla.indexPathForSelectedRow {
            let fila : Lista
            var productoAdd : String?
            var precioAdd : String?
            let contexto = conexion()
            if searchController.isActive && searchController.searchBar.text != ""{
                 fila = filtroLista[cart.row]
            }else{
                 fila = lista[cart.row]
            }
            productoAdd = fila.articulo
            precioAdd = fila.costo
            print(productoAdd!, precioAdd!)
            let entidadCarrito = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: contexto) as! Cart
            entidadCarrito.producto = productoAdd
            entidadCarrito.precio = Int16(precioAdd!)!
            do {
                try contexto.save()
                selectAlert()
                print("Se agrego al carrito\(entidadCarrito.producto!), \(entidadCarrito.precio)")
                
            } catch let error as NSError {
                print("Error al agregar al carrito", error.localizedDescription)
            }
        }
    }
//Numero de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtroLista.count
        }
            return lista.count
    }
//Llenar tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list : Lista
        if searchController.isActive && searchController.searchBar.text != ""{
            list = filtroLista[indexPath.row]
        }else{
            list = lista[indexPath.row]
        }
        cell.textLabel?.text = list.articulo
        cell.detailTextLabel?.text = ("$ \(list.costo)")
        return cell
    }
//SearchBar
    func updateSearchResults(for searchController: UISearchController) {
        filtroContenido(Busqueda: self.searchController.searchBar.text!)
    }
    func filtroContenido(Busqueda : String){
        self.filtroLista = lista.filter{Articulo in
            let articulos = Articulo.articulo
            return (articulos.lowercased().contains(Busqueda.lowercased()))
        }
        Tabla.reloadData()
    }
    @IBAction func Back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
