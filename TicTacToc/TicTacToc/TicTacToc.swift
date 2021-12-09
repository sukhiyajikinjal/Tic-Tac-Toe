//
//  TicTacToc.swift
//  TicTacToc
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToc: UIViewController {
    
    private var state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
    private let winningCombinations = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    private var zeroFlag = false
    public var p1=0,p2=0
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 140, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        //collectionView.backgroundColor = .white
         collectionView.backgroundColor = UIColor(patternImage: UIImage(named:"t1")!)
        return collectionView
    }()
    private let P1 : UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 1"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        
        return myLabel
    }()
    private let VS:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "VS"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        return myLabel
    }()
    
    private let P2:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 2"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        return myLabel
    }()
    
    private let p1_score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isEditable = false
        textView.font = .boldSystemFont(ofSize: 18)
        return textView
    }()
    
    private let p2_score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = .boldSystemFont(ofSize: 18)
        textView.textColor = .white
        
        return textView
    }()
    private let label :UILabel = {
        let label = UILabel()
        let font : UIFont = UIFont.boldSystemFont(ofSize: 30)
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Lets play TicTacToc"
        label.textAlignment = .center
        label.font = font
        label.textColor = .white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCollectionView)
        view.addSubview(label)
        view.addSubview(P1)
        view.addSubview(VS)
        view.addSubview(P2)
        p1_score.text = String(p1)
        p2_score.text = String(p2)
        view.addSubview(p1_score)
        view.addSubview(p2_score)
        setupCollection()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        P1.frame = CGRect(x: 20, y: 10, width: 100, height: 50)
        VS.frame = CGRect(x: 180, y: 10, width: 30, height: 50)
        P2.frame = CGRect(x: 260, y: 10, width: 100, height: 50)
        p1_score.frame = CGRect(x: 20, y: P1.bottom + 5, width: 100, height: 50)
        p2_score.frame = CGRect(x: 260, y: P2.bottom + 5, width: 100, height: 50)
        myCollectionView.frame = view.bounds
        label.frame = CGRect(x: 10, y: 100, width: view.width - 40, height: 40)
    }
    
}
extension TicTacToc: UICollectionViewDataSource, UICollectionViewDelegate{
    private func setupCollection(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier:"T3Cell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "T3Cell", for: indexPath) as! T3Cell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1{
            state.remove(at: indexPath.row)
            if zeroFlag{
                state.insert(0, at: indexPath.row)
            }else{
                state.insert(1, at: indexPath.row)
            }
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
            
        }
    }
    private func checkWinner(){
        if !state.contains(2){
            let alert = UIAlertController(title: "Game Over", message: "Draw", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            for i in winningCombinations{
                if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2{
                    announcewinner(player: state[i[0]] == 0 ? "0" : "X")
//                    resetState()
//                    print("\(state[ i[0] ]) won")
//                    let alert = UIAlertController(title: "Alert", message: "you win", preferredStyle : UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "click", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                    break
                }
            }
        }
    }
    private func announcewinner(player:String){
        if player == "X"
        {
            p1+=1
            p1_score.text = String(p1)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 1 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            p2+=1
            p2_score.text = String(p2)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 2 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    private func resetState(){
        state=[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadData()
    }
   
}
