//
//  DatabaseHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 9/25/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "DatabaseHandler.h"
static DatabaseHandler* sharedInstance = nil;
static sqlite3* database = nil;
static sqlite3_stmt* statement = nil;

@implementation DatabaseHandler

+ (DatabaseHandler*)getSharedInstance{
    if(!sharedInstance){
        sharedInstance = [[super allocWithZone:nil]init];
        [sharedInstance createDataBase];
    }
    return sharedInstance;
}

- (BOOL)createDataBase{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    BOOL ret_val;
    char* errMsg;
    [self getDatabasePath];
    ret_val = YES;
    if([fileMgr fileExistsAtPath:dbPath] == NO){
        if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
            const char* enabled_pragma =
            "PRAGMA foreign_keys = ON;";
            if(sqlite3_exec(database,enabled_pragma,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to enable pragma %s",errMsg);
            }
            const char* create_detailed_kitchen =
            "create table if not exists det_kitchen_recipes (recipe_id integer not null, recipe_name text not null, ingredient_name text not null, ingredient_measurement text, ingredient_value real, foreign key(recipe_id) references det_reference_kitchen(recipe_id))";
            if(sqlite3_exec(database,create_detailed_kitchen,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to create table %s",errMsg);
            }
            const char* create_reference_kitchen =
            "create table if not exists det_reference_kitchen (recipe_id integer primary key autoincrement not null, recipe_name text, recipe_description text)";
            if(sqlite3_exec(database,create_reference_kitchen,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to create table %s",errMsg);
            }
            const char* create_detailed_procedures =
            "create table if not exists det_procedures_kitchen (recipe_id integer not null, sequence_number integer, recipe_procedure text, foreign key(recipe_id) references det_reference_kitchen(recipe_id))";
            if(sqlite3_exec(database,create_detailed_procedures,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to create table %s",errMsg);
            }
            const char* create_reference_category =
            "create table if not exists category (category_id integer primary key not null, category_name text)";
            if(sqlite3_exec(database,create_reference_category,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to create table %s",errMsg);
            }
            const char* create_det_tips =
            "create table if not exists tips (category_id integer not null, tip_id integer not null, tips text)";
            if(sqlite3_exec(database,create_det_tips,NULL,NULL,&errMsg) != SQLITE_OK){
                ret_val = NO;
                NSLog(@"[ ERR ] Unable to create table %s",errMsg);
            }
            [self tempInsert];
            [self tempInsert2];
            [self tempInsert3];
            sqlite3_close(database);
            return ret_val;
        }
        else{
            ret_val = NO;
            NSLog(@"[ ERR ] Unable to create / open database");
        }
    }
    return ret_val;
}

- (void)getDatabasePath{
    NSString* docsDir;
    NSArray* dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    dbPath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/house_help.db"]];
}

- (BOOL)insertRecipeName:(NSString*) recipeName recipeDescription:(NSString*) recipeDesc{
    char* errMsg;
    BOOL ret_val = YES;
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* insertRecipeSql = [NSString stringWithFormat:@"insert into det_reference_kitchen\
                                  (recipe_name, recipe_description) \
                                  values('%@','%@');",recipeName,recipeDesc];
        if(sqlite3_exec(database,[insertRecipeSql UTF8String],NULL,NULL,&errMsg) != SQLITE_OK){
            ret_val = NO;
            NSLog(@"Unable to insert det_reference_kitchen");
        }
    }
    else{
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    return ret_val;
}
- (BOOL)insertIngredients:(NSString*) recipeName ingredientName:(NSString*) ingName ingredientMeasurement:(NSString*) ingMeasurement ingredientValue:(NSString*) ingValue{
    char* errMsg;
    BOOL ret_val = YES;
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* insertRecipeSql = [NSString stringWithFormat:@"insert into det_kitchen_recipes\
                                     (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) \
                                     values((select recipe_id from det_reference_kitchen where recipe_name like '%@'),\
                                     '%@','%@','%@',%@);",recipeName,recipeName,ingName,ingMeasurement,ingValue];
        if(sqlite3_exec(database,[insertRecipeSql UTF8String],NULL,NULL,&errMsg) != SQLITE_OK){
            ret_val = NO;
            NSLog(@"Unable to insert det_kitchen_recipes");
        }
    }
    else{
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    return ret_val;
}
- (BOOL)insertRecipeName:(NSString*) recipeName procSequence:(NSString*) pSequence proceduresData:(NSString*) procData{
    char* errMsg;
    BOOL ret_val = YES;
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* insertRecipeSql = [NSString stringWithFormat:@"insert into det_procedures_kitchen\
                                     (recipe_id, sequence_number, recipe_procedure) \
                                     values((select recipe_id from det_reference_kitchen where recipe_name like '%@'),%@,'%@');",recipeName,pSequence,procData];
        if(sqlite3_exec(database,[insertRecipeSql UTF8String],NULL,NULL,&errMsg) != SQLITE_OK){
            ret_val = NO;
            NSLog(@"Unable to insert det_procedures_kitchen");
        }
    }
    else{
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    return ret_val;
}
- (NSMutableArray*)getAllRecipes{
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getRecipesSql = [NSString stringWithFormat:@"select distinct recipe_name \
                                   from det_kitchen_recipes "];
        if(sqlite3_prepare(database, [getRecipesSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc] init];
                [drh addRecipes:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 0)]];
                [arrayOfRecipes addObject:drh];
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }


    return(arrayOfRecipes);
}
- (NSMutableArray*)getRecipes:(NSString*) ingredients{
    NSMutableDictionary* contentsOfRecipes = [[NSMutableDictionary alloc] init];
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    NSArray* ingredients_tokens = [ingredients componentsSeparatedByString:@","];
    NSMutableString* conditional_statement = [[NSMutableString alloc] init];
    BOOL flag = YES;
    for(NSString* ing in ingredients_tokens){
        NSString* trimmed_ing = [ing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(flag){
            [conditional_statement appendString:[NSString stringWithFormat:@"ingredient_name like \'%%%@%%\' ",trimmed_ing]];
            flag = NO;
        }
        else{
            [conditional_statement appendString:[NSString stringWithFormat:@"OR ingredient_name like \'%%%@%%\' ",trimmed_ing]];
        }
    }
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getRecipesSql = [NSString stringWithFormat:@"select distinct recipe_name, \
                                   ingredient_name \
                                   from det_kitchen_recipes \
                                   where %@",conditional_statement];
        if(sqlite3_prepare(database, [getRecipesSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                
                for(NSString* ing in ingredients_tokens){
                    NSString* trimmed_ing = [ing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

                    if([trimmed_ing caseInsensitiveCompare:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)]] == NSOrderedSame){
                        NSString* temp = [contentsOfRecipes objectForKey:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,0)]];
                        int i = [temp intValue];
                        i++;
                        [contentsOfRecipes setObject:[NSString stringWithFormat:@"%d",i] forKey:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,0)]];
                    }
                }
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    for(NSString* key in contentsOfRecipes){
        NSString* temp = [contentsOfRecipes objectForKey:key];
        if([temp intValue] == [ingredients_tokens count])
        {
            DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc] init];
            [drh addRecipes:key];
            [arrayOfRecipes addObject:drh];
        }
    }
    return(arrayOfRecipes);
}

- (NSMutableArray*)getTips:(NSString*) categoryId{
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getTipsSql = [NSString stringWithFormat:@"select tips, \
                                  tip_id \
                                  from tips \
                                  where category_id = %@",categoryId];
        if(sqlite3_prepare(database, [getTipsSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                TipsHandler* th = [[TipsHandler alloc] init];
                int tip_id = 0;
                [th addTips:[[NSString alloc] initWithUTF8String: (const char*) sqlite3_column_text(statement,0)]];
                tip_id = sqlite3_column_int(statement,1);
                [th addTipID:[NSString stringWithFormat:@"%d",tip_id]];
                [arrayOfRecipes addObject:th];
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    
    return arrayOfRecipes;
}

- (NSMutableArray*)getRecipeIngredients:(NSString*) recipeName{
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getRecipeSql = [NSString stringWithFormat:@"select recipe_name, \
                                  ingredient_name, \
                                  ingredient_measurement, \
                                  ingredient_value \
                                  from det_kitchen_recipes \
                                  where recipe_name like \"%@\"",recipeName];
        if(sqlite3_prepare(database, [getRecipeSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                RecipeHandler* rh = [[RecipeHandler alloc] init];
                int ingredient_value = 0;
                [rh addRecipeName:[[NSString alloc] initWithUTF8String: (const char*) sqlite3_column_text(statement,0)]];
                [rh addIngredientName:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,1)]];
                [rh addIngredientMeasurement:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,2)]];
                ingredient_value = sqlite3_column_int(statement,3);
                [rh addIngredientValue:[NSString stringWithFormat:@"%d",ingredient_value]];
                [arrayOfRecipes addObject:rh];
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    
    return arrayOfRecipes;
}

- (NSMutableArray*)getRecipeProcedures:(NSString*) recipeName{
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getProceduresSql = [NSString stringWithFormat:@"select sequence_number,\
                                        recipe_procedure \
                                        from det_procedures_kitchen \
                                        where recipe_id = (select recipe_id from det_reference_kitchen where recipe_name like \"%@\")",recipeName];
        if(sqlite3_prepare(database, [getProceduresSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                ProceduresHandler* ph = [[ProceduresHandler alloc] init];
                int seq_no;
                seq_no = sqlite3_column_int(statement,0);
                [ph addSequence:[NSString stringWithFormat:@"%d",seq_no]];
                [ph addRecipeProcedure:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,1)]];
                [arrayOfRecipes addObject:ph];
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    return arrayOfRecipes;
}

- (NSMutableArray*)getRecipes{
    NSMutableArray* arrayOfRecipes = [[NSMutableArray alloc] init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
        NSString* getRecipesSql = [NSString stringWithFormat:@"select recipe_name,\
                                      recipe_description \
                                      from det_reference_kitchen"];
        if(sqlite3_prepare(database, [getRecipesSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc] init];
                [drh addRecipes:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,0)]];
                [drh addRecipeDescription:[[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement,1)]];
                [arrayOfRecipes addObject:drh];
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"[ ERR ] Failed to trigger query");
        }
    }
    else{
        NSLog(@"[ ERR ] Unable to create / open database");
    }
    return arrayOfRecipes;
}

- (BOOL)tempInsert{
    BOOL ret_val;
    char* errMsg;
    ret_val = YES;
    const char* insert_temp =
    "insert into det_reference_kitchen (recipe_name, recipe_description) values('Chicken and Pork Adobo','Garlic Adobo');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','soy sauce','ml',60);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','white vinegar','ml',375);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','oil','ml',125);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','water','ml',375);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','chicken livers','grams',500);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','bay leaf','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','pork belly','grams',500);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','chicken','whole',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),'Chicken and Pork Adobo','garlic','head',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),1,'Combine pork and chicken in a casserole. Sprinkle garlic on top. In a bowl, mix vinegar and 250 ml (1 cup) of the water. Pour over the pork and chicken then add the bay leaf. Bring to the boil without stirring. When the mixture boils, lower heat and simmer until pork and chicken are tender, about 30 minutes. Remove pork and chicken and set aside, reserve the liquid.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),2,'Meanwhile, simmer chicken livers in remaining water until tender, about 10 minutes. Remove chicken livers from water and pound lightly. Return pounded livers to the water and mix well.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Chicken and Pork Adobo'),3,'Heat the oil in a wok and fry the cooked pork and chicken until brown. Stir in the reserved liquid and the chicken liver mixture to thicken the sauce. Blend in soy sauce and simmer for about 5 minutes. Remove the bay lef. Serve with rice or pan de sal or any type of bread desired. Bread is good for sopping up the sauce. Either serve immediately or set aside and reheat before serving.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Inasal na Manok','Inasal na Manok is a grilled chicken, marinated in coco vinegar, lemon grass, garlic, ginger and turmeric.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','whole chicken','kg',1.4);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','garlic','head',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','ginger','tbsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','turmeric','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','brown sugar','tbsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','lemon grass','stalk',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','annatto powder','pack',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','sea salt','tbsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','ground pepper','tbsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),'Inasal na Manok','cooking oil','cup',0.25);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),1,'Cut the chicken into 4 pieces.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),2,'Grind the garlic, ginger, turmeric, and lemongrass to a paste, using a mortar and pestle or a food processor.t');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),3,'Mix with brown sugar, sea salt, crushed black pepper, 1 pack of annatto powder, oil and coco vinegar.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),4,'Cover the container and marinate the chicken for at least an hour.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Inasal na Manok'),5,'Grill the chicken, turn and cook for 10-15 minutes per sides, basting with annatto oil.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Halo-Halo Ginataan','Halo halong Ginataan na minatamis');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Halo-Halo Ginataan'),'Halo-Halo Ginataan','sugar','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Halo-Halo Ginataan'),'Halo-Halo Ginataan','water','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Halo-Halo Ginataan'),'Halo-Halo Ginataan','ice','cup',1.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Halo-Halo Ginataan'),'Halo-Halo Ginataan','garlic','head',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Halo-Halo Ginataan'),1,'Boil the tapioca');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Leche Flan','Something sweet');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','brown sugar','grams',150);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','water','ml',60);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','eggs','pcs',6);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','egg yolk','pcs',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','white granulated sugar','grams',300);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),'Leche Flan','zest of lemon','pcs',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),1,'To make the caramel base, combine brown sugar and water in a saucepan. Allow sugar to melt over low heat until a syrup forms. Pour immediately into two llaneras or one loaf tin. Tilt pan(s) to make sure syrup coats bottoms of pans evenly. Set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),2,'Lightly beat the whole eggs and extra egg yolks in a mixing bowl. Add sugar and evaporated milk and stir to mix. Strain into prepared pan(s), then stir in the lemon zest');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),3,'Cover pan(s) with foil and place in a steamer and cook for 50 minutes to 1 hour or until Leche Flan is firm to the touch. Let it cool. Chill 3 to 4 hours or refrigerate overnight before serving.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Leche Flan'),4,'To serve, run a spatula or knife along the edge of the pan to loosen the flan. Turn out onto a serving platter.');";
    if(sqlite3_exec(database,insert_temp,NULL,NULL,&errMsg) != SQLITE_OK){
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to insert to table %s",errMsg);
    }
    return(ret_val);
}
- (BOOL)tempInsert2{
    BOOL ret_val;
    char* errMsg;
    ret_val = YES;
    const char* insert_temp =
    "insert into det_reference_kitchen (recipe_name, recipe_description) values('Mitsado','This recipe was named mitsado, because of the (mitsa) or wicked of pork fat inserted in the beef.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','beef','lbs',1.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','onions, peeled and quartered','cloves',4);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','medium potatoes, quartered','pcs',5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','medium sized carrot, sliced in 1/2? sections','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','Red bell pepper, sliced','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','beef stock','cups',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','bay leaves (laurel leaves)','pcs',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','vinegar','cup',0.25);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','tomato sauce','cups',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','canned diced tomatoes','cups',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','soy sauce','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),'Mitsado','pepper','tsp',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),1,'Cut an incision on the beef and insert a pork strip and in the middle.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),2,'In a casserole, combine the beef , bay leaves, onions and diced tomatoes, tomato sauce, soya sauce and beef stock.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),3,'Bring to a boil and simmer until the beef is almost tender.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),4,'Add the vinegar and let boil for a minute or two.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),5,'Add the potatoes, carrot, and bell pepper.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Mitsado'),6,'Let simmer until potatoes and carrots are cooked – occasionally stir to thicken sauce.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Bistek Tagalog','Local version of western cooking “Beef Steak”. A Philippine dish where-in the beef was marinated and cook in soya sauce, lemon juice onion and other spices. Easy to prepare and doesn’t require much ingredients.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','beef sirloin','lb',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','calamansi or 1 pc lemon ','pcs',8);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','soy sauce','cup',0.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','cooking oil','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','garlic','cloves',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','large onion cut into rings','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),'Bistek Tagalog','ground pepper','tsp',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),1,'Cut the beef into a slices.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),2,'Marinate in Calamansi and soy sauce, for at least an hour.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),3,'Saute minced garlic in hot oil, until golden brown. Remove and set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),4,'Next is the onion rings, sautee until onions are transparent. Remove and set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),5,'Fry the beef, add the garlic and marinate.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Bistek Tagalog'),6,'Bring to boil. Serve garnished with onion.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Corned Beef Guisado','Canned Corned Beef cooked in garlic and onion, can be done with potato and green peas for an added taste.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),'Corned Beef Guisado','Corned Beef','can',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),'Corned Beef Guisado','medium onion, cut into onion rings and chopped','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),'Corned Beef Guisado','crushed garlic','cloves',6);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),'Corned Beef Guisado','cooking oil','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),'Corned Beef Guisado','fish sauce','tbsp',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),1,'Heat up a pan with some cooking oil.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),2,'Fry the onion rings, set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),3,'Saute the garlic and chopped onion.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),4,'Add the corned beef and let it cook..');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),5,'Drizzle fish sauce and add pepper to taste.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),6,'Cook for about for 2-3 minutes, garnish with the onion rings.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Corned Beef Guisado'),7,'Serve with steamed or garlic rice.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Crispy Pata','A fried pork hock or knuckles, crispy on the outside and fork tender on the inside. A good side dish for a bottle of beer, served with soya sauce and vinegar dip.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','pork hock or knuckle','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','large onion','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','garlic','cloves',5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','stalks of lemon grass','pc',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','salt(1/2 tbsp for pork rub)','tbsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','crushed peppercorn( 1 tbsp for pork rub)','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),'Crispy Pata','to 8 cups of water','cup',6);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),1,'Pour water in a deep casserole, add lemon grass, garlic, onion, pepper and pepper.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),2,'Add the pork knuckle, simmer until the leg become tender (about 1 1/2 hours).');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),3,'Remove the tender meat and place in a container, let it cool.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),4,'Rub the meat with salt and pepper,  let it stand for 10 minutes to absorb.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),5,'Heat oil in high to medium heat, put the pork hock. Set in low heat, until the pata starts to turn to golden brown.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Crispy Pata'),6,'For Dipping Sauce: Mix soya sauce, sugar, lemon, garlic onion and chili to vinegar, mix according to your taste.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Lechon Paksiw','Traditional way of re-cooking left-over roast pig, lechon kawali or deep fried pork belly can also be used. Chopped roast pork are cooked in vinegar, soya sauce and liver sauce, makes as good as the original meal.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','roast pig','lb',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','lechon liver sauce','cup',1.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','vinegar','cup',0.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','soy sauce','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','brown sugar','cup',0.25);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','dried oregano','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','garlic','cloves',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','salt','tsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','peppercorn','tsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),'Lechon Paksiw','water','cup',0.5);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),1,'In a deep pan or pot mix the liver sauce with vinegar, salt, soya sauce and a cup of water.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),2,'Add the peppercorn, crushed garlic, and dried oregano');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Lechon Paksiw'),3,'Layered the roast pork on the top, cover and cook at low medium high for half hour.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Batchoy','Mix of pork meat and innards, spleen, hearts and liver cook in  a rich pork-based broth filled with Chinese vermicelli noodles and topped with fried pork, and green cut slice green onions.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','pork','lb',0.25);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','pork fats','cup',0.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','spleen','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','liver','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','heart','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','garlic','cloves',4);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','thumbsize ginger','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','rice water','cups',5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','fish sauce','tbsp',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','medium-sized onion','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','stalks spring onions','pcs',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),'Batchoy','misua','pack',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),1,'Put pork fat into a cooking pan and add small amount water.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),2,'When oil render, remove the fat and set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),3,'On the same pan sauté the ginger, garlic and onion in pork fats.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),4,'Add the liver, heart, spleen, pork meat and brown slightly.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),5,'When pork is slightly brown, sauté for a few minutes.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),6,'Seasoned with fish sauce, stirring and let it boil.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),7,'Add a small amount of water, cover and simmer.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),8,'When meats are tender, add the rice water and spring onion.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),9,'Cover and let it boil for another minutes.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),10,'Add misua and cook for another 2 minutes.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Batchoy'),11,'Top with brown pork fats and sprinkle with chopped spring onions.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Binagoongang Baboy sa Gata','A combination of Binagoongang Baboy and Bicol Express, A dish from the Southern part of the Philippines. It is normally served with loads of chillies and coconut milk, being famous among the popular dishes of the Philippines.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','pork belly','lb',0.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','shrimp paste','cup',0.25);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','green long chilli','cup',0.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','finger chilli (siling labuyo)','pcs',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','coconut milk','cup',1.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','garlic','cloves',4);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),'Binagoongang Baboy sa Gata','small onion','pc',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),1,'Saute garlic and onion.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),2,'Add pork and saute until the pork edges turns light brown.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),3,'Stir-in shrimp paste and saute for 1-2 minutes.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),4,'Add chilli and coconut milk, stir and let it boil.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Binagoongang Baboy sa Gata'),5,'Cover and cook in medium heat, until the coconut  render fats and pork are tender.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Sarciadong Isda','Deep fried fish in stewed tomato sauce is an easy and convenient way of fish preparation that brings together the delightful flavors of fish and tomato sauce.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','Fish Fillet or whole fish','pcs',5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','eggs, beaten','pcs',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','medium size onion, thinly slice','pc',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','medium tomatoes, chopped','pcs',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','garlic, chopped','cloves',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','Water','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','stalk green onions, cut into small pieces','pcs',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','flour','tbsp',3);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','cooking oil','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),'Sarciadong Isda','salt','tbsp',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),1,'Season each pieces of mahi fillet with salt and pepper, cover and set aside.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),2,'Coat the fish with all purpose flour on both side.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),3,'Fry the fish  on both side and place them in a paper towel covered plate.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),4,'Heat oil in a medium frying pan, sauté garlic and onion.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),5,'Add the tomatoes and cook until totally wilted');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),6,'Season with fish sauce, salt and pepper.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),7,'Add water and bring to a boil.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),8,'Add the beaten eggs, do not stir and let the eggs cook thoroughly.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Sarciadong Isda'),9,'Sprinkle with cut of spring onions.');\
    insert into det_reference_kitchen (recipe_name, recipe_description) values('Spicy Sweet Dilis','A popular street foods and delicious treat as a snack item or as an appetizer, made out of dried anchovies in a sweet and spicy coating. A very authentic snack not only for its sweet and spicy taste but for its color and garnishes.');\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','dried anchovy','lbs',1.5);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','tomato ketchup','cup',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','sugar','cup',0.75);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','chilli powder','tbsp',2);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','vegetable oil','tsp',1);\
    insert into det_kitchen_recipes (recipe_id, recipe_name, ingredient_name, ingredient_measurement, ingredient_value) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),'Spicy Sweet Dilis','Dried chilli for garnish','tbsp',1);\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),1,'In a pan, add oil then cook dried anchovies in medium heat for 2-3 minutes..');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),2,'Pour the tomato ketchup in a sauce pan, add vegetable oil, sugar and chilli powder and nitre powder (or salitre is optional).');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),3,'Mix and stir until sugar and other ingredients are well dissolve.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),4,'Put the heat to medium heat and let the mixture boil, stirring continuously until the sauce has thickened');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),5,'Turn the heat to low and add the fried anchovy, continue stirring until the sauce has been absorbed.');\
    insert into det_procedures_kitchen (recipe_id, sequence_number, recipe_procedure) values((select recipe_id from det_reference_kitchen where recipe_name like 'Spicy Sweet Dilis'),6,'Sprinkle dried chilli on and serve hot or cold.');";
    if(sqlite3_exec(database,insert_temp,NULL,NULL,&errMsg) != SQLITE_OK){
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to insert to table %s",errMsg);
    }
    return(ret_val);
}
- (BOOL)tempInsert3{
    BOOL ret_val;
    char* errMsg;
    ret_val = YES;
    const char* insert_temp =
    "insert into category (category_id, category_name) values (1, 'Kitchen');\
    insert into category (category_id, category_name) values (2, 'Dining Room');\
    insert into category (category_id, category_name) values (3, 'Living Room');\
    insert into category (category_id, category_name) values (4, 'Bathroom');\
    insert into category (category_id, category_name) values (5, 'Garage');\
    insert into tips (tip_id, category_id, tips) values (1,1,'Buffing a marble tabletop with car polish leaves a thin,invisible film that helps reduce the risk of stains.');\
    insert into tips (tip_id, category_id, tips) values (2,1,'To pick up small fragments of broken glass, press pieces of bread onto the affected area.');\
    insert into tips (tip_id, category_id, tips) values (3,1,'To stop ants entering your house, draw a chalk line on the ground where you want them to stop. If you live in a rainy area where ants are a problem, you must re-draw the chalk lines each time it rains.');\
    insert into tips (tip_id, category_id, tips) values (4,1,'To get blood out of fabrics, use hydrogen peroxide. Apply it directly to the stain and then launder in the washing machine.');\
    insert into tips (tip_id, category_id, tips) values (5,1,'Use leftover styrofoam peanuts as great drainage in the bottom of a pot.');\
    insert into tips (tip_id, category_id, tips) values (6,1,'To mask unpleasant odors, put some coffee beans in a saucepan and burn them. The smell of coffee will overpower the other nasty odors.');\
    insert into tips (tip_id, category_id, tips) values (7,1,'To get rid of the smell of garlic from your hands, rub against stainless steel – your sink is ideal. Then wash hands with soap or detergent.');\
    insert into tips (tip_id, category_id, tips) values (8,1,'To clean a microwave oven, add four tablespoons of lemon juice to one cup of water in a microwave-safe bowl. Boil for five minutes in the microwave, allowing the steam to condense on the inside walls of the oven. Then wipe them with a soft cloth.');\
    insert into tips (tip_id, category_id, tips) values (9,1,'To clean a stainless-steel sink, put the stopper in the sink with two denture-cleaning tablets and half fill with water; leave for several hours or overnight and the next day it should be sparkling. Then use the water to clean the draining board, too.');\
    insert into tips (tip_id, category_id, tips) values (10,1,'To remove fingerprints from stainless-steel appliances, place a small amount of baby oil on a napkin and wipe the affected areas. The fingerprints will just wipe away.');\
    insert into tips (tip_id, category_id, tips) values (11,3,'To remove furniture indentations from pure wool carpet place a tea towel over the area and then press with a warm iron. The heat will lift the fibres. Do not attempt this with synthetic or a wool/synthetic mix carpet.');\
    insert into tips (tip_id, category_id, tips) values (12,3,'To remove oil from silk clothing, gently rub cornflour into the area and lightly brush off. Cover the oil mark completely with more cornflour and leave to sit for a few hours. Shake clothing free of flour and then hand wash, or use a gentle machine cycle, using soap suitable for delicates.');\
    insert into tips (tip_id, category_id, tips) values (13,3,'To prevent buttons from becoming loose or undone, dab a little clear nail varnish on the top thread or onto the stem of the thread and leave to dry.');\
    insert into tips (tip_id, category_id, tips) values (14,3,'To remove pollen from the stamen of flowers, take a piece of sticky tape about five centimetres long, gently press the sticky side to the pollen mark and lift off. Repeat with clean sticky tape as required. Do not try to brush it off.');\
    insert into tips (tip_id, category_id, tips) values (15,3,'If you have an aquarium, save the water each time you change it and water your house plants with it. It’s full of nutrients and makes a great fertiliser.');\
    insert into tips (tip_id, category_id, tips) values (16,3,'To deter silverfish, place whole cloves in wardrobes and drawers.');\
    insert into tips (tip_id, category_id, tips) values (17,3,'To revive a vase of wilted flowers, add a teaspoon of mild detergent.');\
    insert into tips (tip_id, category_id, tips) values (18,3,'To stop drawers from sticking, rub a bar of soap across the runners to make them glide smoothly.');\
    insert into tips (tip_id, category_id, tips) values (19,3,'To prevent ash from flying everywhere when cleaning out a fireplace, use a spray bottle filled with water to cover the ashes with a light mist.');\
    insert into tips (tip_id, category_id, tips) values (20,3,'To leave a room smelling fresh after you have vacuumed, place a few drops of your favourite essential oil (such as lavender or peppermint) near the vent where the hot air is released. The air warms the oil and blows it into the room.');\
    insert into tips (tip_id, category_id, tips) values (21,3,'Vacuuming a mattress, particularly along piping and crevices, removes dead skin cells that attract dust mites.');\
    insert into tips (tip_id, category_id, tips) values (22,3,'Use a vacuum cleaner with a brush attachment to clean the tops and creases of Roman blinds.');\
    insert into tips (tip_id, category_id, tips) values (23,4,'Light a match and let it burn a few seconds to remove toilet smells.');\
    insert into tips (tip_id, category_id, tips) values (24,4,'To stop bathroom mirrors steaming up, regularly rub a dry bar of soap over the surface and rub in with a clean cloth.');\
    insert into tips (tip_id, category_id, tips) values (25,4,'Stop clothes with thin straps falling off hangers by sticking small felt furniture pads onto the hanger just beyond where the straps sit.');\
    insert into tips (tip_id, category_id, tips) values (26,4,'To reuse the bits of soap that are always left over, combine them with glycerine and some warm water. Pour into a bottle for a handmade liquid soap.');\
    insert into tips (tip_id, category_id, tips) values (27,4,'To restore toilet bowls back to their shiny best, clean with old, flat Coke or Pepsi. To dissolve limescale, leave the soda overnight to soak.');\
    insert into tips (tip_id, category_id, tips) values (28,4,'To clean your shower curtain, wash it in the washing machine with about one cup each of vinegar and bleach, some white towels and a normal amount of washing powder. Adding fabric softener will help keep the curtain clean. When the load is done, return the curtains to their place in the bathroom to drip dry. The wrinkles will disappear in a day or so. (Check your washing machine manual to ensure it’s okay to use bleach).');\
    insert into tips (tip_id, category_id, tips) values (29,5,'Eucalyptus oil removes the gummy residue left by shop stickers.');\
    insert into tips (tip_id, category_id, tips) values (30,5,'To keep spiders or any other nasty surprises out of shoes you keep outside, (such as your gardening shoes or work boots), place old stockings over the top of them. Make sure the stockings don’t have holes in them, and if they don’t fit snugly over the top, use an elastic band to secure them.');\
    insert into tips (tip_id, category_id, tips) values (31,5,'To make candles last longer, cover with a plastic bag and place in the freezer for 24 hours before lighting.');\
    insert into tips (tip_id, category_id, tips) values (32,5,'To keep your car windows ice and frost free when left outside overnight in the wintertime, mix three parts vinegar to one part water, put it in a spray bottle and spray on the windows as needed.');\
    insert into tips (tip_id, category_id, tips) values (33,5,'To remove body oil stains from collars and cuffs of coloured shirts and blouses, rub hair shampoo directly on the stains. Rinse out the shampoo, then wash the clothes as usual.');\
    insert into tips (tip_id, category_id, tips) values (34,5,'To clean the bottom of the iron, sprinkle salt on the ironing board and iron back and forth.');\
    insert into tips (tip_id, category_id, tips) values (35,5,'To locate light switches in the dark, put a dot of luminous paint on tape and stick to the switches.');\
    insert into tips (tip_id, category_id, tips) values (36,5,'To keep pinking shears or scissors sharp, cut through a sheet of folded aluminium foil or coarse sandpaper.');\
    insert into tips (tip_id, category_id, tips) values (37,5,'Clove oil (sold in chemists for toothaches) kills mould spores. Mix three drops in one litre of water and then use to wipe down areas susceptible to mould.');\
    insert into tips (tip_id, category_id, tips) values (38,5,'To clean glass windows, add about one tablespoon of cornstarch to about one litre of lukewarm water. Wet and a rag or squeegee, remove excessive water and wipe down glass as if using regular glass cleaner. Dry with either a soft cloth or paper.');\
    insert into tips (tip_id, category_id, tips) values (40,2,'For carpets and upholstery, only use products formulated for cleaning those surfaces. Other cleaning products can discolor the fabric.');\
    insert into tips (tip_id, category_id, tips) values (41,2,'Silver items that are displayed instead of stored, such as candlesticks or coffee and tea services, will need polishing. Rinse the item first to remove excess dust that can abrade silver. Using a soft clothe or sponge, apply polish and gently rub up and down rather than circularly. Rinse and dry with clean, soft cloth.');\
    insert into tips (tip_id, category_id, tips) values (39,5,'To remove marker pen off hard surfaces, spray on hair spray and then wipe it off.');";
    if(sqlite3_exec(database,insert_temp,NULL,NULL,&errMsg) != SQLITE_OK){
        ret_val = NO;
        NSLog(@"[ ERR ] Unable to insert to table %s",errMsg);
    }
    return(ret_val);
}
@end
