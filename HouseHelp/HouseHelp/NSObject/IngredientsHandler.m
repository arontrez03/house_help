//
//  IngridientsHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 10/4/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "IngredientsHandler.h"

@implementation IngredientsHandler
- (id)init{
    self = [super init];
    if(self){
        _ingredient_name = [[NSString alloc] init];
        _ingredient_measurement = [[NSString alloc] init];
        _ingredient_value = [[NSString alloc] init];
    }
    return(self);
}
- (void) addIngredientName: (NSString*) i_name{
    _ingredient_name = i_name;
}
- (void) addIngredientMeasurement: (NSString*) i_measurement{
    _ingredient_measurement = i_measurement;
}
- (void) addIngredientValue: (NSString*) i_value{
    _ingredient_value = i_value;
}
@end
