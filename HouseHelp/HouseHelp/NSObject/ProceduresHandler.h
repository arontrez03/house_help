//
//  ProceduresHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 10/2/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProceduresHandler : NSObject
@property (copy) NSMutableDictionary* procHolder;
- (id) init;
- (void) addSequence: (NSString*) seq;
- (void) addRecipeProcedure: (NSString*) rec_procedure;
- (NSString*) getSequence;
- (NSString*) getRecipeProcedure;
@end
