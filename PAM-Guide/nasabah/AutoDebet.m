//
//  FundFactSheet.m
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "AutoDebet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define kObserver @"vcRadioButtonItemFromGroupSelected"


@interface AutoDebet ()

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;


@end

@implementation AutoDebet


@synthesize sessionID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
      
    }
    return self;
}


- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
//{
//    [super addObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected" options:options context:context];
//    [observers setValue:observer forKey:keyPath];
//}
//
//- (void)removeObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath
//{
//    [super removeObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected"];
//    [observers removeObjectForKey:keyPath];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
 
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonProgramAutoDebet.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)downloadPDF:(id)sender{
    
    UIButton *button = (UIButton *)sender;

    NSURL *url;
    
    switch ([(UIButton*)sender tag]) {
        case 1: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/maksima_new_Maret/2013.pdf"];
            break;
        case 2: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/bersama_Maret%202013.pdf"];
            break;
    }
    
    if (url) {
        // Initialize Document Interaction Controller
        
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Present Open In Menu
        [self.documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];


    }
}


- (void)requestFinished:(ASIFormDataRequest *)request
{
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    NSData *responseData = [request responseData];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray *transaksi = [json objectForKey:@"AutoDebet"]; //2
    
    int y =8;
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10,110, 930, 600)];
    scroll.contentSize = CGSizeMake(200, 1000);
    [scroll setShowsVerticalScrollIndicator:NO];
    
    //[scroll removeFromSuperview];
    
    [self.view addSubview:scroll];
    
    UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 14.0 ];
    for (int i=0;i<transaksi.count;i++){
        
        
        NSDictionary *tempDict = [transaksi objectAtIndex:i];
        
        NSString *fundname = [tempDict objectForKey:@"FundName"];
        UILabel *fundnameLabel =[[UILabel alloc] initWithFrame:CGRectMake(13,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        fundnameLabel.font = myFont;
        fundnameLabel.minimumFontSize = 14.0;
        fundnameLabel.adjustsFontSizeToFitWidth = YES;
        [fundnameLabel setBackgroundColor:[UIColor clearColor]];
        fundnameLabel.text = @" ";
        fundnameLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        fundnameLabel.text = [NSString stringWithFormat:@"%@",fundname];
        
        NSString *everydate = [tempDict objectForKey:@"EveryDate"];
        UILabel *everydateLabel =[[UILabel alloc] initWithFrame:CGRectMake(240,y,50,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        everydateLabel.font = myFont;
        everydateLabel.minimumFontSize = 14.0;
        everydateLabel.adjustsFontSizeToFitWidth = YES;
        [everydateLabel setBackgroundColor:[UIColor clearColor]];
        everydateLabel.text = @" ";
        everydateLabel.textAlignment = NSTextAlignmentLeft;
        everydateLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        everydateLabel.text = [NSString stringWithFormat:@"%@",everydate];
        
        NSString *startmonth = [tempDict objectForKey:@"StartMonth"];
        UILabel *startmonthLabel =[[UILabel alloc] initWithFrame:CGRectMake(310,y,10,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        startmonthLabel.font = myFont;
        startmonthLabel.minimumFontSize = 14.0;
        startmonthLabel.adjustsFontSizeToFitWidth = YES;
        [startmonthLabel setBackgroundColor:[UIColor clearColor]];
        startmonthLabel.text = @" ";
        startmonthLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        startmonthLabel.text = [NSString stringWithFormat:@"%@",startmonth];
        
        NSString *startyear = [tempDict objectForKey:@"StartYear"];
        UILabel *startyearLabel =[[UILabel alloc] initWithFrame:CGRectMake(330,y,33,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        startyearLabel.font = myFont;
        startyearLabel.minimumFontSize = 14.0;
        startyearLabel.adjustsFontSizeToFitWidth = YES;
        [startyearLabel setBackgroundColor:[UIColor clearColor]];
        startyearLabel.text = @" ";
        startyearLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        startyearLabel.text = [NSString stringWithFormat:@"%@",startyear];
        
        NSString *endmonth = [tempDict objectForKey:@"EndMonth"];
        UILabel *endmonthLabel =[[UILabel alloc] initWithFrame:CGRectMake(405,y,10,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        endmonthLabel.font = myFont;
        endmonthLabel.minimumFontSize = 14.0;
        endmonthLabel.adjustsFontSizeToFitWidth = YES;
         [endmonthLabel setBackgroundColor:[UIColor clearColor]];
        endmonthLabel.text = @" ";
        endmonthLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        endmonthLabel.textAlignment = NSTextAlignmentCenter;
        endmonthLabel.text = [NSString stringWithFormat:@"%@",endmonth];
        
        NSString *endyear = [tempDict objectForKey:@"EndYear"];
        UILabel *endyearLabel =[[UILabel alloc] initWithFrame:CGRectMake(425,y,33,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        endyearLabel.font = myFont;
        endyearLabel.minimumFontSize = 14.0;
        endyearLabel.adjustsFontSizeToFitWidth = YES;
         [endyearLabel setBackgroundColor:[UIColor clearColor]];
        endyearLabel.text = @" ";
        endyearLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        endyearLabel.textAlignment = NSTextAlignmentCenter;
        endyearLabel.text = [NSString stringWithFormat:@"%@",endyear];
        
        NSString *nominal = [tempDict objectForKey:@"Nominal"];
        UILabel *nominalLabel =[[UILabel alloc] initWithFrame:CGRectMake(480,y,90,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        nominalLabel.font = myFont;
        nominalLabel.minimumFontSize = 14.0;
        nominalLabel.adjustsFontSizeToFitWidth = YES;
         [nominalLabel setBackgroundColor:[UIColor clearColor]];
        nominalLabel.text = @" ";
        nominalLabel.textAlignment = NSTextAlignmentRight;
        nominalLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        nominalLabel.text = [NSString stringWithFormat:@"%@",nominal];
        
        NSString *fee = [tempDict objectForKey:@"Fee"];
        UILabel *feeLabel =[[UILabel alloc] initWithFrame:CGRectMake(600,y,68,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        feeLabel.font = myFont;
        feeLabel.minimumFontSize = 14.0;
        feeLabel.adjustsFontSizeToFitWidth = YES;
         [feeLabel setBackgroundColor:[UIColor clearColor]];
        feeLabel.text = @" ";
        feeLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        feeLabel.text = [NSString stringWithFormat:@"%@",fee];
        
        
        NSString *unitbalance = [tempDict objectForKey:@"unitBalance"];
        UILabel *unitbalanceLabel =[[UILabel alloc] initWithFrame:CGRectMake(630,y,70,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        unitbalanceLabel.font = myFont;
        unitbalanceLabel.minimumFontSize = 14.0;
        unitbalanceLabel.adjustsFontSizeToFitWidth = YES;
         [unitbalanceLabel setBackgroundColor:[UIColor clearColor]];
        unitbalanceLabel.text = @" ";
        unitbalanceLabel.textAlignment = NSTextAlignmentRight;
        unitbalanceLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        unitbalanceLabel.text = [NSString stringWithFormat:@"%@",@"1000000"];
        
        NSString *bankname = [tempDict objectForKey:@"BankName"];
        UILabel *bankNameLabel =[[UILabel alloc] initWithFrame:CGRectMake(750,y,70,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        bankNameLabel.font = myFont;
        bankNameLabel.minimumFontSize = 14.0;
        bankNameLabel.adjustsFontSizeToFitWidth = YES;
         [bankNameLabel setBackgroundColor:[UIColor clearColor]];
        bankNameLabel.text = @" ";
        bankNameLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        bankNameLabel.text = [NSString stringWithFormat:@"%@",bankname];
        
        NSString *productname = [tempDict objectForKey:@"ProductName"];
        UILabel *productnameLabel =[[UILabel alloc] initWithFrame:CGRectMake(8820,y,70,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        productnameLabel.font = myFont;
        productnameLabel.minimumFontSize = 14.0;
        productnameLabel.adjustsFontSizeToFitWidth = YES;
         [productnameLabel setBackgroundColor:[UIColor clearColor]];
        productnameLabel.text = @" ";
        productnameLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        productnameLabel.text = [NSString stringWithFormat:@"%@",productname];

        
        
        y = y+32;
        
        
        [scroll addSubview:fundnameLabel];
        [scroll addSubview:everydateLabel];
        [scroll addSubview:feeLabel];
        [scroll addSubview:startmonthLabel];
        [scroll addSubview:startyearLabel];
        [scroll addSubview:endmonthLabel];
        [scroll addSubview:endyearLabel];
        [scroll addSubview:nominalLabel];
        [scroll addSubview:bankNameLabel];
        [scroll addSubview:productnameLabel];
        [scroll addSubview:unitbalanceLabel];
        
        
    }


}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}


- (IBAction)back:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}
@end
