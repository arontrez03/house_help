//
//  AddRecipeViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 10/3/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "AddRecipeViewController.h"

@implementation AddRecipeViewController
- (id)init{
    self = [super init];
    if(self){

    }
    return(self);
}
- (void) loadView{
    AddRecipeView* arv = [[AddRecipeView alloc] init];
    arv.delegate = self;
    [self prefersStatusBarHidden];
    self.view = arv;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didTouchGoBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didTouchInsertRecipe: (NSString*) recipeName{
    [self dismissViewControllerAnimated:YES completion:nil];    
    [_delegate trigSuccess:recipeName];
}

@end
