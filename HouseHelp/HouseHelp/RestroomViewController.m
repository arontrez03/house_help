//
//  RestroomViewController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "RestroomViewController.h"

@interface RestroomViewController ()

@end

@implementation RestroomViewController

- (id)init{
    self = [super init];
    if(self){
        uitbi = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"53-house.png"] tag:0 ];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    RestroomView* rrv = [[RestroomView alloc] init];
    rrv.delegate = self;
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [rrv setTabbarsize:tabBarSize];
    [self prefersStatusBarHidden];
    self.view = rrv;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didTouchHome{
    
}
@end
