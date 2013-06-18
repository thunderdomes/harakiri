//
//  NewsJSON.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/22/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "JSONModel.h"

@protocol NewsJSON @end
@interface NewsJSON : JSONModel

@property (strong, nonatomic) NSString *modifiedDate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *shortDesc;
@property (strong, nonatomic) NSString *newsLink;


@end
