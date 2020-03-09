//
//  LivingroomExitViewController.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "LivingroomExitViewController.h"

@interface LivingroomExitViewController ()

@end

@implementation LivingroomExitViewController
- (id)init
{
    self = [super init];
    if(self)
    {
        UITabBarItem* uitbi = [[UITabBarItem alloc] initWithTitle:@"Exit" image:[UIImage imageNamed:@"102-walk.png"] tag:1];
        [self setTabBarItem: uitbi];
    }
    return(self);
}
- (void) loadView{
    [_delegate didTouchHome];
}

@end
