//
//  NewsCell.m
//  PAM-Guide
//
//  Created by Dave Harry on 5/10/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "NAVCell.h"

@implementation NAVCell
@synthesize productName,NABValue,oneD,rating,backIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
