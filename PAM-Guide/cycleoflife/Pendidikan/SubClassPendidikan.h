//
//  SubClassHajj.h
//  PAM-Guide
//
//  Created by Dave Harry on 6/7/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"

@interface SubClassPendidikan : UIViewController
{
    UIViewController *subv;
    Form *Form;

}

- (IBAction)goView:(id)sender;

@end