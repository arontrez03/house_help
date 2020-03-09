//
//  KitchenTabBarController.m
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "KitchenTabBarController.h"

@implementation KitchenTabBarController
- (id)init{
    self = [super init];
    if(self){
        NSMutableArray* nsma = [[NSMutableArray alloc]init];
        KitchenViewController* kvc = [[KitchenViewController alloc]init];
        KitchenBuddyViewController* ktvc = [[KitchenBuddyViewController alloc] init];
        ExitViewController* evc = [[ExitViewController alloc]init];
        evc.delegate = self;
        [nsma addObject:kvc];
        [nsma addObject:ktvc];
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
