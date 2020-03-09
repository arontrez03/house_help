//
//  DiningroomExitViewController.h
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningroomView.h"
#import "DiningroomViewDelegate.h"
@interface DiningroomExitViewController : UIViewController
- (id)init;
@property id <DiningroomViewDelegate> delegate;
@end