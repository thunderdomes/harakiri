//
//  main.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ABCalendarPicker/ABCalendarPicker.h>

#import "AppDelegate.h"


int main(int argc, char *argv[])
{
    @autoreleasepool {
        [ABCalendarPicker class];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
