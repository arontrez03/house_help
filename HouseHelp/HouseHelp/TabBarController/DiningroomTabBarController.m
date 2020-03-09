//
//  DiningTabBarController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "DiningroomTabBarController.h"

@interface DiningroomTabBarController ()

@end

@implementation DiningroomTabBarController


- (id)init{
    self = [super init];
    if(self){
        NSMutableArray* nsma = [[NSMutableArray alloc]init];
        DiningroomViewController* drvc = [[DiningroomViewController alloc]init];
        DiningroomExitViewController* drevc = [[DiningroomExitViewController alloc]init];
        drevc.delegate = self;
        [nsma addObject:drvc];
        [nsma addObject:drevc];
        
        
        self.tabBar.tintColor = [UIColor brownColor];
        self.tabBar.backgroundColor = [UIColor brownColor];
        [self setViewControllers:nsma];
    }
    return(self);
}

- (void)didTouchHome{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didTouchAddRecipe{
    
}

@end
