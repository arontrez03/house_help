//
//  LivingroomTabBarController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "LivingroomTabBarController.h"

@interface LivingroomTabBarController ()

@end

@implementation LivingroomTabBarController

- (id)init{
    self = [super init];
    if(self){
        NSMutableArray* nsma = [[NSMutableArray alloc]init];
        LivingroomViewController* lrvc = [[LivingroomViewController alloc]init];
        //KitchenBuddyViewController* ktvc = [[KitchenBuddyViewController alloc] init];
        LivingroomExitViewController*lrevc = [[LivingroomExitViewController alloc]init];
        //MeasurementConverterViewController* mcvc = [[MeasurementConverterViewController alloc]init];
        
        lrevc.delegate = self;
        [nsma addObject:lrvc];
        //[nsma addObject:ktvc];
        //[nsma addObject:mcvc];
        [nsma addObject:lrevc];
        
        
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
