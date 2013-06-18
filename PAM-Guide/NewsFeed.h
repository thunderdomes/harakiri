//
//  NewsFeed.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/22/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "JSONModel.h"
#import "NewsJSON.h"

@interface NewsFeed : JSONModel

@property (strong, nonatomic) NSArray<NewsJSON> *listNews;

@end
