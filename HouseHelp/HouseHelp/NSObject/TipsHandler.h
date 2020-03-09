//
//  TipsHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipsHandler : NSObject
@property (copy) NSString* tip_id;
@property (copy) NSString* tip_name;
- (void) addTipID: (NSString*)tid;
- (void) addTips: (NSString*)tname;
@end
