//
//  GarageTabBarController.m
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "GarageTabBarController.h"

@implementation GarageTabBarController

- (id)init{
    self = [super init];
    if(self){
        NSMutableArray* nsma = [[NSMutableArray alloc]init];
        ExitViewController* evc = [[ExitViewController alloc]init];
        GarageViewController* gvc = [[GarageViewController alloc] init];
        evc.delegate = self;
        [nsma addObject:gvc];
        [nsma addObject:evc];
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
