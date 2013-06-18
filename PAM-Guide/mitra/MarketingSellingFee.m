//
//  MarketingSellingFee.m
//  PAM-Guide
//
//  Created by Dave Harry on 6/7/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "MarketingSellingFee.h"
#import "CKCalendarView.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@interface MarketingSellingFee ()

@end

@implementation MarketingSellingFee
@synthesize tanggal,fromLabel,toLabel,strTanggalFrom,strTanggalTo,responseString1,sessionID,scroll;

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

- (IBAction)cekTransaksi:(id)sender{
    

    
    
   // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonMarketingSellingFee.aspx"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonMarketingSellingFee.aspx"]];

    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:strTanggalFrom forKey:@"startdate"];
    [request setPostValue:strTanggalTo forKey:@"enddate"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    [request setCompletionBlock:^{
        responseString1 = [request responseString];
        //[self checkIfBothRequestsComplete];
    }];
    request.userInfo = [NSDictionary dictionaryWithObject:@"cektransaction" forKey:@"type"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    [scroll removeFromSuperview];
    
}

- (void)requestFinished:(ASIFormDataRequest *)request
{
    [scroll removeFromSuperview];
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Loading Data"];
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response:%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
    //NSLog(@"headers: %@", [request responseHeaders]);
    //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
    //// NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"useThisJSONString(%@)", responseString]];
    ////    NSLog (@"1. result: %@", result);
    //
    //    NSURL *urlforWebView= [NSURL URLWithString:[json objectForKey:@"fundName"]];
    //    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlforWebView];
    //    [webView loadRequest:urlRequest];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          
                          error:&error];
    
    NSArray *saldo = [json objectForKey:@"ListSellingFee"]; //2
    NSLog(@"Saldo :%d",saldo.count);
    
    int y =10;
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 200, 1000, 500)];
    scroll.contentSize = CGSizeMake(200, 3300);
    [scroll setShowsVerticalScrollIndicator:NO];
    
  
    
    [self.view addSubview:scroll];
    
    UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 12.0 ];
    
    for (int i=0;i<saldo.count;i++){
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];

        
        
        NSString *s = [tempDict objectForKey:@"VoucherSts"];
        UILabel *transdateLabel =[[UILabel alloc] initWithFrame:CGRectMake(20,y,20,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        transdateLabel.font = myFont;
        transdateLabel.minimumFontSize = 12.0;
        transdateLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        transdateLabel.adjustsFontSizeToFitWidth = YES;
        transdateLabel.text = @" ";
        transdateLabel.text = [NSString stringWithFormat:@"%@",s];
        
        NSString *transDate = [tempDict objectForKey:@"TransDate"];
        UILabel *descriptionLabel =[[UILabel alloc] initWithFrame:CGRectMake(80,y,90,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        descriptionLabel.font = myFont;
        descriptionLabel.minimumFontSize = 12.0;
        descriptionLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        descriptionLabel.adjustsFontSizeToFitWidth = YES;
        descriptionLabel.text = @" ";
        descriptionLabel.text = [NSString stringWithFormat:@"%@",transDate];
        
        NSString *cust = [tempDict objectForKey:@"Customer"];
        UILabel *testLabel =[[UILabel alloc] initWithFrame:CGRectMake(205,y,300,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        testLabel.font = myFont;
        testLabel.minimumFontSize = 12.0;
        testLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        testLabel.adjustsFontSizeToFitWidth = YES;
        testLabel.text = @" ";
        testLabel.text = [NSString stringWithFormat:@"%@",cust];
        
        
        
        NSString *netamount = [tempDict objectForKey:@"NetAmount"];
        UILabel *feepercentLabel =[[UILabel alloc] initWithFrame:CGRectMake(700,y,100,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        feepercentLabel.font = myFont;
        feepercentLabel.minimumFontSize = 12.0;
        feepercentLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        feepercentLabel.adjustsFontSizeToFitWidth = YES;
        feepercentLabel.text = @" ";
        [feepercentLabel setBackgroundColor:[UIColor clearColor]];
        //feepercentLabel.text = [NSString stringWithFormat:@"%@",netamount];
        feepercentLabel.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[netamount floatValue]]];
        
        NSString *percent = [tempDict objectForKey:@"SellingFeePercent"];
        UILabel *grossammountLabel =[[UILabel alloc] initWithFrame:CGRectMake(870,y,30,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        grossammountLabel.font = myFont;
        grossammountLabel.minimumFontSize = 12.0;
        grossammountLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        grossammountLabel.adjustsFontSizeToFitWidth = YES;
        grossammountLabel.text = @" ";
        grossammountLabel.textAlignment = NSTextAlignmentRight;
        [grossammountLabel setBackgroundColor:[UIColor clearColor]];
        grossammountLabel.text = [NSString stringWithFormat:@"%@",percent];
        
        NSString *amount = [tempDict objectForKey:@"SellingFeeAmount"];
        UILabel *navLabel =[[UILabel alloc] initWithFrame:CGRectMake(950,y,60,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        navLabel.font = myFont;
        navLabel.minimumFontSize = 12.0;
        navLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        navLabel.adjustsFontSizeToFitWidth = YES;
        navLabel.text = @" ";
        [navLabel setBackgroundColor:[UIColor clearColor]];
        //navLabel.text = [NSString stringWithFormat:@"%@",amount];
        navLabel.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[amount floatValue]]];
        
                y = y+25;
        
        [scroll addSubview:testLabel];
        [scroll addSubview:transdateLabel];
        [scroll addSubview:descriptionLabel];
        [scroll addSubview:feepercentLabel];
        [scroll addSubview:grossammountLabel];
        [scroll addSubview:navLabel];
      
        
        
    }
    [HUD hideUIBlockingIndicator];
    
}


- (IBAction)pickDate:(id)sender{
    
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    //[self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"2012-09-12"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"2013-01-05"],
                           [self.dateFormatter dateFromString:@"2013-01-06"],
                           [self.dateFormatter dateFromString:@"2013-01-06"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    switch ([(UIButton*)sender tag]) {
        case 1:  calendar.tag = 1;
            break;
        case 2: calendar.tag = 2;
            break;
    }
    
    
    calendar.frame = CGRectMake(450,230, 280, 300);
    [self.view addSubview:calendar];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    
}


- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    tanggal = [self.dateFormatter stringFromDate:date];
    NSLog(@"Date:%@",tanggal);
    
    if(calendar.tag == 1) {
        
        fromLabel.text = tanggal;
        strTanggalFrom = tanggal;
        NSLog(@"strtanggal:%@",strTanggalFrom);
    }
    if(calendar.tag == 2) {
        
        toLabel.text = tanggal;
        strTanggalTo = tanggal;
    }
    
    [calendar removeFromSuperview];
    
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}

- (IBAction)back{
    [self.view removeFromSuperview];
    
}

@end
