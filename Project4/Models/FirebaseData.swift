//
//  FirebaseData.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import Firebase
import FirebaseFirestore

let dbCollection = Firestore.firestore().collection("dbtest")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    @Published var data = [ThreadDataType]()
    
    init() {
        readData()
    }
    
    func createData(msg1:String, msg2:String) {
        // To create or overwrite a single document
        dbCollection.document().setData(["id" : dbCollection.document().documentID, "userID" : "user1", "title":msg1, "sentence":msg2]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("create data success")
            }
        }
    }
    
    func readData() {
        dbCollection.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read data success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = ThreadDataType(id: diff.document.documentID,
                                                 userID: diff.document.get("userID") as! String,
                                                 title: diff.document.get("title") as! String,
                                                 sentence: diff.document.get("sentence") as! String)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> ThreadDataType in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.userID = diff.document.get("userID") as! String
                            data.title = diff.document.get("title") as! String
                            data.sentence = diff.document.get("sentence") as! String
                            return data
                        }else {
                            return eachData
                        }
                    }
                }
            }
        }
    }
    
    func deleteData(datas: FirebaseData ,index: IndexSet) {
        let id = datas.data[index.first!].id
        dbCollection.document(id).delete { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("delete data success")
            }
            datas.data.remove(atOffsets:index)
        }
    }
    
    func updateData(id: String, txt: String) {
        dbCollection.document(id).updateData(["content":txt]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("update data success")
            }
        }
    }
}
