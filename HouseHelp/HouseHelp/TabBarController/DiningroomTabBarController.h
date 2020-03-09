//
//  DiningTabBarController.h
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningroomViewDelegate.h"
#import "DiningroomViewController.h"
#import "DiningroomExitViewController.h"
@interface DiningroomTabBarController : UITabBarController <DiningroomViewDelegate>
- (id)init;
@end
