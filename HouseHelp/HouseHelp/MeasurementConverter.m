//
//  MeasurementConverter.m
//  AppVantage
//
//  Created by macuser on 9/30/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import "MeasurementConverter.h"
#import "Icons.h"
@implementation MeasurementConverter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        header = [[MeasurementConverterHeader alloc] initWithFrame:frame myText:@"Measurement Converter"];
        units = [[UIView alloc] init];
        body = [[UIView alloc] init];
        footer = [[UIView alloc] init];
        
        liquid = [[Icons alloc]initWithButton:frame myImage:@"liquid.jpg" myTxt:@"liquid"];
        solid = [[Icons alloc]initWithButton:frame myImage:@"teaspoon.jpg" myTxt:@"solid"];
        temperature = [[Icons alloc]initWithButton:frame myImage:@"temp.jpg" myTxt:@"temp"];
        weight = [[Icons alloc]initWithButton:frame myImage:@"weight.jpg" myTxt:@"weight"];
    
        //header.backgroundColor = [UIColor yellowColor];
        //units.backgroundColor = [UIColor blueColor];
        body.backgroundColor = [UIColor greenColor];
        footer.backgroundColor = [UIColor redColor];
        liquid.backgroundColor = [UIColor blackColor];
        solid.backgroundColor = [UIColor whiteColor];
        temperature.backgroundColor = [UIColor whiteColor];
        weight.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:header];
        [self addSubview:units];
        [self addSubview:body];
        [self addSubview:footer];
        [self addSubview:liquid];
        [self addSubview:solid];
        [self addSubview:temperature];
        [self addSubview:weight];
        
        percentHeader = .15;
        percentUnits = .25;
        percentBody = .5;
        percentFooter = .1;

    }
    return self;
}


- (void)layoutSubviews{
    parentHeight = self.bounds.size.height;
    parentWidth = self.bounds.size.width;
    
    //Set Font Size
    if(parentHeight>parentWidth){
        fontSize = parentHeight *.03;
    }else{
        fontSize = parentWidth *.03;
    }
    
    //Units of Measurement for convertion
    unitsHeight = parentHeight*percentUnits;
    unitsWidth = parentWidth;
    customUnitsHeight = unitsHeight*.35;;
    customUnitsWidth = unitsWidth *.35;
    unitsXMargin = unitsWidth*.1;
    unitsYMargin = unitsHeight*.1;
    H = unitsHeight/2;
    W = unitsWidth/2;
    
    liquid.frame = CGRectMake(unitsXMargin,(parentHeight*percentHeader)+unitsYMargin,customUnitsWidth,customUnitsHeight);
    solid.frame = CGRectMake((int)(W+(unitsXMargin/2)),(parentHeight*percentHeader)+unitsYMargin,customUnitsWidth,customUnitsHeight);
    temperature.frame = CGRectMake(unitsXMargin,(parentHeight*percentHeader)+(int)(H+(unitsYMargin/2)),customUnitsWidth,customUnitsHeight);
    weight.frame = CGRectMake((int)(W+(unitsXMargin/2)),(parentHeight*percentHeader)+(int)(H+(unitsYMargin/2)),customUnitsWidth,customUnitsHeight);

    
    //Add Frames
    header.frame = CGRectMake(0,0,parentWidth,parentHeight*percentHeader);
    units.frame  = CGRectMake(0,parentHeight*percentHeader,parentWidth,parentHeight*percentUnits);
    body.frame   = CGRectMake(0,parentHeight*(percentHeader+percentUnits),parentWidth,parentHeight*percentBody);
    footer.frame = CGRectMake(0,parentHeight*(percentHeader+percentUnits+percentBody),parentWidth,parentHeight*percentFooter);

    


}

- (void) showLiquid{
    liquid.backgroundColor = [UIColor blackColor];
    solid.backgroundColor = [UIColor whiteColor];
    temperature.backgroundColor = [UIColor whiteColor];
    weight.backgroundColor = [UIColor whiteColor];
    body.backgroundColor = [UIColor greenColor];
}

- (void) showSolid{
    liquid.backgroundColor = [UIColor whiteColor];
    solid.backgroundColor = [UIColor blackColor];
    temperature.backgroundColor = [UIColor whiteColor];
    weight.backgroundColor = [UIColor whiteColor];
    body.backgroundColor = [UIColor whiteColor];
}

- (void) showTemparature{
    liquid.backgroundColor = [UIColor whiteColor];
    solid.backgroundColor = [UIColor whiteColor];
    temperature.backgroundColor = [UIColor blackColor];
    weight.backgroundColor = [UIColor whiteColor];
    body.backgroundColor = [UIColor brownColor];
}

- (void) showMeasurement{
    liquid.backgroundColor = [UIColor whiteColor];
    solid.backgroundColor = [UIColor whiteColor];
    temperature.backgroundColor = [UIColor whiteColor];
    weight.backgroundColor = [UIColor blackColor];
    body.backgroundColor = [UIColor orangeColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //NSLog([touch view]);
    
    [UIView animateWithDuration:1.0 animations:^{
        if([touch view] == liquid || [touch view] == liquid.myLabel) {
            [self showLiquid];
        }
        else if([touch view] == solid || [touch view] == solid.myLabel) {
            [self showSolid];
            
        }
        else if([touch view] == temperature || [touch view] == temperature.myLabel) {
            [self showTemparature];
        }
        else if([touch view] == weight || [touch view] == weight.myLabel) {
            [self showMeasurement];        }
            }];
}



@end
