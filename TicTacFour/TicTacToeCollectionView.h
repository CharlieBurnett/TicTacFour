//
//  TicTacToeCollectionView.h
//  TicTacFour
//
//  Created by Charles Burnett on 6/3/17.
//  Copyright © 2017 Charles Burnett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicTacToeCollectionView : UICollectionView

@property (strong, nonatomic) NSMutableArray *boardState;

-(void) clearBoard;
-(void) printBoard;

- (BOOL) checkWinCondition;

@end
