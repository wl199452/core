//
//  DBManager.swift
//  swift_coreData
//
//  Created by 王林 on 2018/2/7.
//  Copyright © 2018年 edon. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {

    static let sharedManager = DBManager()
    fileprivate let managedObectContext = AppDelegate().persistentContainer.viewContext

  // MARK:- ****************************************查***********************************************

    func fetchAll() -> [NSManagedObject] {

        //步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        //步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                return results
            }

        } catch  {
            fatalError("获取失败")
        }
        return [NSManagedObject]()
    }

  // MARK:- ****************************************增***********************************************
    func add(name:String) -> Bool{
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedObectContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        //        步骤三：保存
        person.setValue(name, forKey: "name")
        person.setValue(10, forKey: "age")
        do {
            try managedObectContext.save()
            return true
        } catch  {
            fatalError("无法保存")
        }
        //        步骤五：保存到数组中，更新UI
        return false
    }

    // MARK:- ****************************************删***********************************************
    func delete() -> Bool {
        //步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        let predic = NSPredicate(format: "age=%d", 10)
        fetchRequest.predicate = predic

        let results =  try! managedObectContext.fetch(fetchRequest)

        if results.count > 0 {   //删除操作
            for obj in (results.enumerated()){
                managedObectContext.delete(obj.element as! NSManagedObject)
                }
        }
        do {
            try managedObectContext.save()
            return true
        } catch  {
            fatalError("无法保存")
        }
        return false
    }

    // MARK:- ****************************************改***********************************************
    func updata() -> Bool {
        //步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        //多条件并存
        let predic = NSPredicate(format: "name=%@ || name=%@", "张三","mumu")
        fetchRequest.predicate = predic
        let results =  try! managedObectContext.fetch(fetchRequest)

        if results.count > 0 {   //删除操作
            for obj in (results.enumerated()){
                let orginData = obj.element as! NSManagedObject
//                var oidName = orginData.value(forKey: "name") as? String
                orginData.setValue("mumu", forKey: "name")
            }
        }
        do {
            try managedObectContext.save()
            return true
        } catch  {
            fatalError("无法保存")
        }
        return false


    }


}
