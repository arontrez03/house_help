//
//  RecipeViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "RecipeViewController.h"

@implementation RecipeViewController
- (id)initWithRecipeName: (NSString*) recipe_name{
    self = [super init];
    if(self){
        _r_name = [[NSString alloc]init];
        _r_name = recipe_name;
        self.title = recipe_name;
    }
    return(self);
}
- (void)loadView{
    RecipesView* rv = [[RecipesView alloc]initWithRecipe:_r_name];
    [self prefersStatusBarHidden];
    rv.delegate = self;
    self.view = rv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didTouchGoBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
