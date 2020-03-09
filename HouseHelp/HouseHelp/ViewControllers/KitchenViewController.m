//
//  KitchenViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 9/22/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "KitchenViewController.h"

@implementation KitchenViewController

- (id)init{
    self = [super init];
    if(self){
        uitbi = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"53-house.png"] tag:0 ];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    KitchenView* kv = [[KitchenView alloc] init];
    kv.delegate = self;
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [kv setTabbarsize:tabBarSize];
    [self prefersStatusBarHidden];
    self.view = kv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didTouchHome{
    
}

- (void)didTouchAddRecipe{
    AddRecipeViewController* arvc = [[AddRecipeViewController alloc] init];
    [self presentViewController:arvc animated:NO completion:nil];
}
@end
