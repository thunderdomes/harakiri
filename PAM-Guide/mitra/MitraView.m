//
//  NasabahView.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "MitraView.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CekSaldo.h"
#import "CekTransaction.h"
#import "FundFactSheet.h"
#import "SimulasiBerkala.h"
#import "UnduhForm.h"
#import "TopUp.h"
#import "AutoDebet.h"
#import "NAVCell.h"
#import "MarketingSellingFee.h"

@interface MitraView ()

@end

@implementation MitraView
@synthesize username,password,cif,tanggalLahir,subv,sessionID,customerName,buttonHTTPRequest,responseString1,responseString2,tanggaltransaksi,listfund,amountnonusd,amountusd;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closefader)
                                                     name:@"closefader"
                                                   object:nil];
    }
    return self;
}

-(void)closefader {
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    fader.hidden = YES;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    fader.hidden = YES;
       
    
    _navfeed = [[NAVFeed alloc] initFromURLWithString:@"http://www.panin-am.co.id:800/json.aspx"
                                           completion:^(JSONModel *model, JSONModelError *err) {
                                               
                                               //hide the loader view
                                               [HUD hideUIBlockingIndicator];
                                               
                                               //json fetched
                                               //NSLog(@"NAV: %@", _navfeed.products);
                                               [self.navTable reloadData];
                                               
                                           }];
    
    NSString *user,*pass;
    user= [NSString stringWithFormat:@"%@", username];
    pass = [NSString stringWithFormat:@"%@", password];
    NSLog(@"Trying to sign in with user:%@ pass:%@",user,pass);

    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonLoginUserMarketing.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    // [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:user forKey:@"userName"];
    [request setPostValue:pass forKey:@"password"];
    
    [request setPostValue:@"submit" forKey:@"ctl00$MainContent$btnLogin"];
    
    [request setCompletionBlock:^{
        responseString1 = [request responseString];
        //[self checkIfBothRequestsComplete];
    }];
    request.userInfo = [NSDictionary dictionaryWithObject:@"loginuser" forKey:@"type"];

    
    NSString *eventValidation = @"wEWBwKd0eiaDwKvyZbqDgKMrfvLAgKOsPfSCQKRnIq9DwKw7JaFDQLqr4SbBoxruwSkUAtkZniSVbZNvoucEF8SeQll/Drp+mTBf6yH";
    [request setPostValue:eventValidation forKey:@"__EVENTVALIDATION"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];

    

    
}

- (IBAction)sellingFee:(id)sender{
    
    
    MarketingSellingFee *sellingFee = [[MarketingSellingFee alloc]initWithNibName:@"MarketingSellingFee" bundle:nil];
    self.subv = sellingFee;
    
    sellingFee.sessionID = sessionID;
    [self.view addSubview:subv.view];
    
}


-(IBAction)httpRequest:(id)sender

{
    [scroll removeFromSuperview];
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCustomerPortfolio.aspx"]];
    
    
    ASIFormDataRequest *request2 = [ASIFormDataRequest requestWithURL:url2];
    
    [request2 setPostValue:sessionID forKey:@"sessionid"];
    
    [request2 setRequestMethod:@"POST"];
    [request2 addRequestHeader:@"Accept" value:@"application/json"];
    [request2 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    
    [request2 setCompletionBlock:^{
        responseString2 = [request2 responseString];
        //[self checkIfBothRequestsComplete];
    }];
    [request2 setDelegate:self];
    request2.userInfo = [NSDictionary dictionaryWithObject:@"customerportfolio" forKey:@"type"];
    [request2 startAsynchronous];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)checkIfBothRequestsComplete
{
    if (self.responseString1 && self.responseString2) {
        
        ciftext = [json valueForKeyPath:@"ListCustomerPortfolio.CustomerNo"];
//        custodianid = [json valueForKeyPath:@"ListFundAccount.custodianId"];
//        bank = [json valueForKeyPath:@"ListCustAccount.Bank"];
//        labelNamaBank.text = [bank objectAtIndex:0];
        NSLog(@"label:%@",ciftext);
    }
    
}




- (void)requestFinished:(ASIFormDataRequest *)request
{
   
    [scroll removeFromSuperview];
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Loading Data"];
    
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    NSData *responseData = [request responseData];
    
    NSError* error;
    json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    

    
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"loginuser"]) {
        sessionID = [json valueForKeyPath:@"MarketingDetail.SessionID"];
    }

    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"customerportfolio"])
    {
    NSArray *list = [json objectForKey:@"ListCustomerPortfolio"]; //2
    NSLog(@"list :%d",list.count);
    
    int y =8;
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(20,360, 930, 300)];
    scroll.contentSize = CGSizeMake(200, 4000);
    [scroll setShowsVerticalScrollIndicator:NO];
    
    [self.view addSubview:scroll];
    
    UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 12.0 ];
    for (int i=0;i<list.count;i++){
    
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];

        NSDictionary *tempDict = [list objectAtIndex:i];
        
        
        NSString *cifstr = [tempDict objectForKey:@"CustomerNo"];
        UILabel *ciflabel =[[UILabel alloc] initWithFrame:CGRectMake(13,y,45,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        ciflabel.font = myFont;
        ciflabel.minimumFontSize = 12.0;
        ciflabel.adjustsFontSizeToFitWidth = YES;
        [ciflabel setBackgroundColor:[UIColor clearColor]];
        ciflabel.text = @" ";
        ciflabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        ciflabel.text = [NSString stringWithFormat:@"%@",cifstr];
        
        NSString *name = [tempDict objectForKey:@"CustomerName"];
        UILabel *namelabel =[[UILabel alloc] initWithFrame:CGRectMake(85,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        namelabel.font = myFont;
        namelabel.minimumFontSize = 12.0;
        namelabel.adjustsFontSizeToFitWidth = YES;
        [namelabel setBackgroundColor:[UIColor clearColor]];
        namelabel.text = @" ";
        namelabel.textAlignment = NSTextAlignmentLeft;
        namelabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        namelabel.text = [NSString stringWithFormat:@"%@",name];
        
        NSString *birthdate = [tempDict objectForKey:@"BirthDate"];
        UILabel *birthdatelabel =[[UILabel alloc] initWithFrame:CGRectMake(280,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        birthdatelabel.font = myFont;
        birthdatelabel.minimumFontSize = 12.0;
        birthdatelabel.adjustsFontSizeToFitWidth = YES;
        [birthdatelabel setBackgroundColor:[UIColor clearColor]];
        birthdatelabel.text = @" ";
        birthdatelabel.textAlignment = NSTextAlignmentLeft;
        birthdatelabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        
        if([birthdate hasPrefix:@"/"]){
            birthdatelabel.text = @" ";
        }else {
        birthdatelabel.text = [NSString stringWithFormat:@"%@",birthdate];
        }
        
        NSString *transdate = [tempDict objectForKey:@"LastTransDate"];
        UILabel *transdatelabel =[[UILabel alloc] initWithFrame:CGRectMake(420,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        transdatelabel.font = myFont;
        transdatelabel.minimumFontSize = 12.0;
        birthdatelabel.adjustsFontSizeToFitWidth = YES;
        [transdatelabel setBackgroundColor:[UIColor clearColor]];
        transdatelabel.text = @" ";
        transdatelabel.textAlignment = NSTextAlignmentLeft;
        transdatelabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        if([birthdate hasPrefix:@"/"]){
            birthdatelabel.text = @" ";
        }else {
            transdatelabel.text = [NSString stringWithFormat:@"%@",transdate];
        }
        
        NSString *fund = [tempDict objectForKey:@"Fund"];
        UILabel *fundlabel =[[UILabel alloc] initWithFrame:CGRectMake(550,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        fundlabel.font = myFont;
        fundlabel.minimumFontSize = 12.0;
        fundlabel.adjustsFontSizeToFitWidth = YES;
        [fundlabel setBackgroundColor:[UIColor clearColor]];
        fundlabel.text = @" ";
        fundlabel.textAlignment = NSTextAlignmentLeft;
        fundlabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        fundlabel.text = [NSString stringWithFormat:@"%@",fund];
        
        NSString *amountnonusd1 = [tempDict objectForKey:@"TotalAmountNonUSD"];
        UILabel *amountnodusdlabel =[[UILabel alloc] initWithFrame:CGRectMake(750,y,100,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        amountnodusdlabel.font = myFont;
        amountnodusdlabel.minimumFontSize = 12.0;
        amountnodusdlabel.adjustsFontSizeToFitWidth = YES;
        [amountnodusdlabel setBackgroundColor:[UIColor clearColor]];
        amountnodusdlabel.text = @" ";
        amountnodusdlabel.textAlignment = NSTextAlignmentLeft;
        amountnodusdlabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        
         amountnodusdlabel.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[amountnonusd1 floatValue]]];
       // amountnodusdlabel.text = [NSString stringWithFormat:@"%@",amountnonusd1];
        
        NSString *amountusd1 = [tempDict objectForKey:@"TotalAmountUSD"];
        UILabel *amountusdlabel =[[UILabel alloc] initWithFrame:CGRectMake(900,y,100,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        amountusdlabel.font = myFont;
        amountusdlabel.minimumFontSize = 12.0;
        amountusdlabel.adjustsFontSizeToFitWidth = YES;
        [amountusdlabel setBackgroundColor:[UIColor clearColor]];
        amountusdlabel.text = @" ";
        amountnodusdlabel.textAlignment = NSTextAlignmentLeft;
        amountusdlabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        amountusdlabel.text = [NSString stringWithFormat:@"%@",amountusd1];



        
        y = y+32;
        
        
        [scroll addSubview:ciflabel];
        [scroll addSubview:namelabel];
        [scroll addSubview:birthdatelabel];
        [scroll addSubview:transdatelabel];
        [scroll addSubview:fundlabel];
        [scroll addSubview:amountnodusdlabel];
        [scroll addSubview:amountusdlabel];

        
    }
        
  
    }
    [HUD hideUIBlockingIndicator];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:self];
    [self.view removeFromSuperview];
    
}


@end
