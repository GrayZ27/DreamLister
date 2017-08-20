//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Gray Zhen on 8/18/17.
//  Copyright © 2017 GrayStudio. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemTOEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        /*
        let store1 = Store(context: context)
        store1.name = "Amazon"
        let store2 = Store(context: context)
        store2.name = "Apple"
        let store3 = Store(context: context)
        store3.name = "Best Buy"
        let store4 = Store(context: context)
        store4.name = "Kmart"
        let store5 = Store(context: context)
        store5.name = "Walmart"
        let store6 = Store(context: context)
        store6.name = "Wish"
        AD.saveContext()
        */
        
        getStore()
        
        if itemTOEdit != nil {
            loadItemData()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
    }
    
    func getStore(){
    
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        }catch(let err as NSError){
            
            print(err)
            
        }
        
    }
    
    @IBAction func saveItem(_ sender: UIButton) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemTOEdit == nil {
            
            item = Item(context: context)
            
            
        }else{
            
            item = itemTOEdit
            
        }
        
        if let title = titleField.text {
            
            item.title = title
            
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
            
        }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        
        item.toImage = picture
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        AD.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData() {
        
        if let item = itemTOEdit {
            
            titleField.text = item.title
            priceField.text = String(item.price)
            detailsField.text = item.details
            
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat{
                    
                    let s = stores[index]
                    
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
        }
        
    }
    
    @IBAction func itemDelete(_ sender: UIBarButtonItem) {
        
        if itemTOEdit != nil {
            context.delete(itemTOEdit!)
            AD.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}
