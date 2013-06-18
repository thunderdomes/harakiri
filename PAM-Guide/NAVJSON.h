//
//  NAVJSON.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/22/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "JSONModel.h"

@protocol NAVJSON @end
@interface NAVJSON : JSONModel

@property (strong, nonatomic) NSString *ProductName;
@property (strong, nonatomic) NSString *NABValue;
@property (strong, nonatomic) NSString *OneD;
@property (strong, nonatomic) NSString *Star;

@end
