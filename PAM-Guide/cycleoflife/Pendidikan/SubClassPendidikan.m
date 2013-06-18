//
//  SubClassHajj.m
//  PAM-Guide
//
//  Created by Dave Harry on 6/7/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "SubClassPendidikan.h"
#import "COF_ContainerPendidikan.h"

@interface SubClassPendidikan ()

@end

@implementation SubClassPendidikan

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
    subv = [[COF_ContainerPendidikan alloc] initWithNibName:@"COF_ContainerPendidikan" bundle:nil] ;
    [self.view addSubview:subv.view];

}

- (IBAction)back{
   
        [self.view removeFromSuperview];
    
}


@end
