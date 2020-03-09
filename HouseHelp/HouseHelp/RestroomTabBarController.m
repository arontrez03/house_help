//
//  RestroomTabBarController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "RestroomTabBarController.h"

@interface RestroomTabBarController ()

@end

@implementation RestroomTabBarController

- (id)init{
    self = [super init];
    if(self){
        NSMutableArray* nsma = [[NSMutableArray alloc]init];
        RestroomViewController* rrvc = [[RestroomViewController alloc]init];
        RestroomExitViewController* rrevc = [[RestroomExitViewController alloc]init];
        rrevc.delegate = self;
        [nsma addObject:rrvc];
        [nsma addObject:rrevc];
        
        
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
