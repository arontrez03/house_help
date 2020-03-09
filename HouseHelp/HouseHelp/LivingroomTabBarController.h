//
//  LivingroomTabBarController.h
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivingroomViewDelegate.h"
#import "LivingroomViewController.h"
#import "LivingroomExitViewController.h"
@interface LivingroomTabBarController : UITabBarController <LivingroomViewDelegate>
- (id)init;
@end
