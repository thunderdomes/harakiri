//
//  AppDelegate.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableString *fvalueGlobalString;
    NSString *fvalueString;
    NSArray *arrayCustodianID;
    NSString *custodianID;
     UINavigationController *navigationController ;
   
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) NSMutableString *fvalueGlobalString;
@property (strong, nonatomic) NSString *fvalueString;
@property (strong, nonatomic) NSArray *arrayCustodianID;
@property (strong, nonatomic) NSString *custodianID;
@property (nonatomic, assign) NSInteger index;



@end
