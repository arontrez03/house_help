//
//  TipsHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "TipsHandler.h"

@implementation TipsHandler
- (void) addTipID: (NSString*)tid{
    _tip_id = tid;
}
- (void) addTips: (NSString*)tname{
    _tip_name = tname;
}
@end
