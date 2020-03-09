//
//  LivingroomViewController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "LivingroomViewController.h"

@interface LivingroomViewController ()

@end

@implementation LivingroomViewController

- (id)init{
    self = [super init];
    if(self){
        uitbi = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"53-house.png"] tag:0 ];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    LivingroomView* lrv = [[LivingroomView alloc] init];
    lrv.delegate = self;
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [lrv setTabbarsize:tabBarSize];
    [self prefersStatusBarHidden];
    self.view = lrv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didTouchHome{
    
}

@end
