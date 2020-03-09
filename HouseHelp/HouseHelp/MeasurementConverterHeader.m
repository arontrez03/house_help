//
//  MeasurementConverterHeader.m
//  AppVantage
//
//  Created by macuser on 10/1/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import "MeasurementConverterHeader.h"

@implementation MeasurementConverterHeader

- (id)initWithFrame:(CGRect)frame myText:(NSString*) myStr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //MEASUREMENT CONVERTER
        myLabel = [[UILabel alloc] init];
        [myLabel setUserInteractionEnabled: YES];
        myLabel.backgroundColor = [UIColor whiteColor];
        myLabel.text = myStr;
        [self addSubview:myLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    // Drawing code
    int parentHeight = self.bounds.size.height;
    int parentWidth = self.bounds.size.width;

    myFontSize = parentHeight *.4;
    
    [myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:myFontSize]];
    [myLabel sizeToFit];
    int myLabelWidth = myLabel.bounds.size.width;
    int myLabelHeight = myLabel.bounds.size.height;
    
     myLabel.frame  = CGRectMake((int)((parentWidth-myLabelWidth)/2),(int)((parentHeight-myLabelHeight)/2),myLabelWidth,myLabelHeight);

}



@end
