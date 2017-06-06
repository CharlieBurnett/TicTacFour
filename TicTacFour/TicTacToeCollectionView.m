//
//  TicTacToeCollectionView.m
//  TicTacFour
//
//  Created by Charles Burnett on 6/3/17.
//  Copyright © 2017 Charles Burnett. All rights reserved.
//

#import "TicTacToeCollectionView.h"

@implementation TicTacToeCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.boardState = [self createClearBoard];
    }
    return self;
}

- (void) clearBoard {
    _boardState = [self createClearBoard];
}

- (NSMutableArray *) createClearBoard{
    NSMutableArray * mutArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++){
        NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", nil];
        [mutArray addObject:array];
    }
    return mutArray;
}

- (void) printBoard {
    for (NSMutableArray *obj in _boardState) {
        for (NSString *str in obj)
        {
            NSLog(@"string: %@", str);
        }
    }
}

- (BOOL) checkWinCondition {
    
    if ([self checkDiagonals]){
        return YES;
    }
    
    else if ([self checkRows]){
        return YES;
    }
    
    else if ([self checkColumns])
    {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL) checkDiagonals {
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    NSMutableArray *revMutArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++)
    {
        [mutArray addObject:_boardState[i][i]];
        [revMutArray addObject:_boardState[3-i][i]];
    }
    
    if ([self allSquaresEqual:mutArray] || [self allSquaresEqual:revMutArray]){
        return YES;
    }
    
    else{
        return NO;
    }
}

- (BOOL) checkRows {
    for (NSMutableArray * row in _boardState) {
        if([self allSquaresEqual:row]){
            return YES;
        }
    }
    return NO;
}

- (BOOL) checkColumns {
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    
        for (int i = 0; i < 4; i++){
            
            [tempArray removeAllObjects];
            
            for (NSMutableArray * row in _boardState){
                [tempArray addObject:row[i]];
            }

            if ([self allSquaresEqual:tempArray]){
                    return YES;
            }
    }
    
    return NO;
}

- (BOOL) allSquaresEqual: (NSMutableArray *)array
{
    for (int i = 0; i < array.count - 1; i++) {
        if (![[array objectAtIndex: i] isEqual: [array lastObject]])
        {
            return NO;
        }
        else if ([[array objectAtIndex: i] isEqualToString:@""])
        {
            return NO;
        }
    }
    return YES;
}

@end
