//
//  ViewController.m
//  TicTacFour
//
//  Created by Charles Burnett on 6/1/17.
//  Copyright © 2017 Charles Burnett. All rights reserved.
//

#import "ViewController.h"
#import "BoardCollectionViewCell.h"
#import "TicTacToeCollectionView.h"
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

//IBOutlets
@property (strong, nonatomic) IBOutlet TicTacToeCollectionView *ticTacToeBoard;
@property (strong, nonatomic) IBOutlet UILabel *playerLabel;

@property BOOL isGameOver;
@property BOOL isXTurn;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isXTurn = YES;
    _isGameOver = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newGame:(id)sender {
    [_ticTacToeBoard clearBoard];
    [_ticTacToeBoard reloadData];
}

#pragma UICollectionViewCell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BoardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *cellValue = _ticTacToeBoard.boardState[indexPath.section][indexPath.row];
    [cell.label setText:cellValue];
    
    if (_isGameOver){
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_ticTacToeBoard.boardState[indexPath.section][indexPath.row] isEqualToString:@""])
    {
        NSString * cellValue;
        NSString * playerLabelPrefix = @"Current Player: ";
        
        if (_isXTurn) {
            cellValue = @"X";
            _playerLabel.text = [NSString stringWithFormat:@"%@%@", playerLabelPrefix, @"O"];
        }
        else
        {
            cellValue = @"O";
            _playerLabel.text = [NSString stringWithFormat:@"%@%@", playerLabelPrefix, @"X"];
        }
        
        _ticTacToeBoard.boardState[indexPath.section][indexPath.row] = cellValue;
        [self.ticTacToeBoard reloadData];
        
        if ([_ticTacToeBoard checkWinCondition]) {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Game Over"
                                         message:[NSString stringWithFormat:@"%@ wins!", cellValue]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* okayButton = [UIAlertAction
                                        actionWithTitle:@"Okay"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            
            [alert addAction:okayButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            _isGameOver = YES;
        }
        [self.ticTacToeBoard reloadData];
        _isXTurn = !_isXTurn;
    }
}

@end
