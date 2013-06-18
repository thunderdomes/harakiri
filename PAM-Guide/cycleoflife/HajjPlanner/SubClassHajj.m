//
//  SubClassHajj.m
//  PAM-Guide
//
//  Created by Dave Harry on 6/7/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "SubClassHajj.h"
#import "COFContainerHajj.h"

@interface SubClassHajj ()

@end

@implementation SubClassHajj

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goView:(id)sender
{
    subv = [[COFContainerHajj alloc] initWithNibName:@"COFContainerHajj" bundle:nil] ;
    [self.view addSubview:subv.view];

}

- (IBAction)back{
   
        [self.view removeFromSuperview];
    
}


@end
