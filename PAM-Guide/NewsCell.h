//
//  NewsCell.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/10/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *shortDesc;
@property (nonatomic, strong) IBOutlet UILabel *modifDate;
@property (nonatomic, strong) IBOutlet UILabel *modifMonth;
@property (nonatomic, strong) IBOutlet UILabel *modifYear;

@end
