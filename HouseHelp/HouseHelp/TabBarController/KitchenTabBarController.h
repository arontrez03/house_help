//
//  KitchenTabBarController.h
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewController.h"
#import "KitchenBuddyViewController.h"
#import "ExitViewController.h"

@interface KitchenTabBarController : UITabBarController <KitchenViewDelegate>
- (id)init;
@end
