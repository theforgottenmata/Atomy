//
// Created by Samuel Kodytek on 29/09/2019.
// Copyright (c) 2019 Educanet. All rights reserved.
//
import Darwin
import Foundation

class UnstableAtomsGame: UnstableAtoms {

    private(set) var winner: Player = .none

    private(set) var playerOnMove: Player = .red

    private(set) var fields: [[Field]] = []

    private (set) var rows: Int
    
    private (set) var columns: Int
        
    
    // true = cervena
    // flase = mod

  
    init(rows: Int, columns: Int) {
        fields = Array(repeating: Array(repeating: Field(owner: .none, amountOfAtoms: 0), count: rows), count: columns)
        self.rows = rows
        self.columns = columns
    }
    
    func makeMove(coordinate: Coordinate) {
        
            if playerOnMove == .red {
                    playerOnMove = .blue
                    changePlayers(x: coordinate.x, y: coordinate.y, player: .red)

            } else if playerOnMove == .blue{
                    playerOnMove = .red
                    changePlayers(x: coordinate.x, y: coordinate.y, player: .blue)
                    
            }
        win()
    }
    
    private func addAtom(x: Int, y: Int, player: Player) {
             var pocet = fields[x][y].amountOfAtoms;
        

             if(pocet == 3){ //jestli jsou tri tak nasledujici je rozdeli pomocu metody divideAtoms
                 fields[x][y] = Field(owner: Player.none,amountOfAtoms: 0)
                 divideAtoms(x: x, y: y, player: player)
             } else {
                 pocet = pocet+1
                 fields[x][y] = Field(owner: player,amountOfAtoms: pocet)
             }
         }
    
    //checkovani zdali jsou v poli a zaroven deleni atomu
    func divideAtoms(x: Int, y: Int, player: Player) {
        
        if (x>0 && x<5 && y>0 && y<8) {
            addAtom(x: x + 1, y: y, player: player)
            addAtom(x: x - 1, y: y, player: player)
            addAtom(x: x, y: y - 1, player: player)
            addAtom(x: x, y: y + 1, player: player)
        }
    }
    
    func changePlayers(x: Int, y: Int, player: Player) {
        
        if fields[x][y].owner == player || fields[x][y].owner == Player.none {
                   addAtom(x: x, y: y, player: player)
               }else {
                   if playerOnMove == .red {
                       playerOnMove = .blue
                   } else if playerOnMove == .blue {
                       playerOnMove = .red
                   }
            }
        }
    
        
    func win(){
        
        var red : Int = 0
        var blue: Int = 0
        
        for x in 0...5 {
            for y in 0...7 {
                if (fields[x][y].owner == Player.red){
                    red = red+1
                } else if (fields[x][y].owner == Player.blue) {
                    blue = blue+1
                }
            }
        }

        if red >= 2 || blue >= 2{
            
            if red == 0 {
                print("~~~ Game is over ~~~")
                print("** BLUE IS WINNER **")
                winner = .blue

            }else if blue == 0 {
                print("~~~ Game is over ~~~")
                print("** RED IS WINNER **")
                winner = .red

            }
            playerOnMove = .none

        }
    }
}





    

    

