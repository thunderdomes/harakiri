//
//  NewsCell.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/10/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAVCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *productName;
@property (nonatomic, strong) IBOutlet UILabel *NABValue;
@property (nonatomic, strong) IBOutlet UILabel *oneD;
@property (nonatomic, strong) IBOutlet UILabel *modifMonth;
@property (nonatomic, strong) IBOutlet UILabel *modifYear;
@property (nonatomic, strong) IBOutlet UIImageView *rating;
@property (nonatomic, strong) IBOutlet UIImageView *backIndex;

@end
