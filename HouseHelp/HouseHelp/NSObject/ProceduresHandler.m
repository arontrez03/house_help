//
//  ProceduresHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 10/2/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "ProceduresHandler.h"

@implementation ProceduresHandler
- (id) init{
    self = [super init];
    if(self){
        _procHolder = [[NSMutableDictionary alloc] init];
    }
    return(self);
}
- (void) addSequence: (NSString*) seq{
    [_procHolder setObject:seq forKey:@"sequence_number"];
}
- (void) addRecipeProcedure: (NSString*) rec_procedure{
    [_procHolder setObject:rec_procedure forKey:@"recipe_procedure"];
}
- (NSString*) getSequence{
    return([_procHolder objectForKey:@"sequence_number"]);
}
- (NSString*) getRecipeProcedure{
    return([_procHolder objectForKey:@"recipe_procedure"]);
}
@end
