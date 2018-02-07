//
//  ViewController.swift
//  swift_coreData
//
//  Created by 王林 on 2018/2/7.
//  Copyright © 2018年 edon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func ADD(_ sender: UIButton) {
        let res =  DBManager.sharedManager.add(name: "张三")
        let errStr = res ? "增加成功" : "增加失败"
        print(errStr)

    }

    @IBAction func Search(_ sender: UIButton) {
        let objS = DBManager.sharedManager.fetchAll()

        for info in objS.enumerated() {
            let fo = info.element
            let name = fo.value(forKey: "name")
            let age = fo.value(forKey: "age")


            print("%@----%d",name,age)
        }


    }

    @IBAction func DELETED(_ sender: UIButton) {
      let res =  DBManager.sharedManager.delete()
        let errStr = res ? "删除成功" : "删除失败"
        print(errStr)
    }

    @IBAction func Mutify(_ sender: UIButton) {
        let res =  DBManager.sharedManager.updata()
        let errStr = res ? "修改成功" : "修改失败"
        print(errStr)
    }


}

