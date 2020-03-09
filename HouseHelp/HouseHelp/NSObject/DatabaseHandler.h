//
//  DatabaseHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 9/25/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RecipeHandler.h"
#import "DistinctRecipesHandler.h"
#import "ProceduresHandler.h"
#import "TipsHandler.h"
@interface DatabaseHandler : NSObject
{
    NSString* dbPath;
}
+ (DatabaseHandler*)getSharedInstance;
- (BOOL)createDataBase;
- (void)getDatabasePath;
- (BOOL)insertRecipeName:(NSString*) recipeName recipeDescription:(NSString*) recipeDesc;
- (BOOL)insertIngredients:(NSString*) recipeName ingredientName:(NSString*) ingName ingredientMeasurement:(NSString*) ingMeasurement ingredientValue:(NSString*) ingValue;
- (BOOL)insertRecipeName:(NSString*) recipeName procSequence:(NSString*) pSequence proceduresData:(NSString*) procData;
- (NSMutableArray*)getRecipes:(NSString*) ingridients;
- (NSMutableArray*)getRecipeIngredients:(NSString*) recipeName;
- (NSMutableArray*)getRecipeProcedures:(NSString*) recipeName;
- (NSMutableArray*)getRecipes;
- (NSMutableArray*)getTips:(NSString*) categoryId;
- (NSMutableArray*)getAllRecipes;
@end
