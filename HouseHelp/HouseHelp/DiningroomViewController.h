//
//  DiningroomViewController.h
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningroomView.h"
@interface DiningroomViewController : UIViewController <LivingroomViewDelegate>
{
    UITabBarItem* uitbi;
}
- (id)init;
- (void)loadView;
@end