//
//  GarageViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "GarageViewController.h"

@implementation GarageViewController
- (id)init{
    self = [super init];
    if(self){
        uitbi = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"53-house.png"] tag:0 ];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    GarageView* gv = [[GarageView alloc] init];
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [gv setTabbarsize:tabBarSize];
    [self prefersStatusBarHidden];
    self.view = gv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
