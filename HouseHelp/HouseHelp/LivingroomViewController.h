//
//  LivingroomViewController.h
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivingroomView.h"
@interface LivingroomViewController : UIViewController <LivingroomViewDelegate>
{
    UITabBarItem* uitbi;
}
- (id)init;
- (void)loadView;
@end
