//
//  DiningroomViewController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "DiningroomViewController.h"

@interface DiningroomViewController ()

@end

@implementation DiningroomViewController

- (id)init{
    self = [super init];
    if(self){
        uitbi = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"53-house.png"] tag:0 ];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    DiningroomView* drv = [[DiningroomView alloc] init];
    drv.delegate = self;
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [drv setTabbarsize:tabBarSize];
    [self prefersStatusBarHidden];
    self.view = drv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didTouchHome{
    
}
@end
