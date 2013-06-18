//
//  CekSaldo.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/27/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "CekSaldo.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CKCalendarView.h"

@interface CekSaldo () <CKCalendarDelegate>

@end

@implementation CekSaldo
@synthesize sessionID,label,tanggal,tanggaldipilih,date;

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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *currentDate = [NSDate date];
    date = [formatter stringFromDate:currentDate];
    [self loadData:date];
    
}

- (void)loadData:(NSString*)tanggalSend

{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    
//    NSDate *currentDate = [NSDate date];
//    date = [formatter stringFromDate:currentDate];
    
    //NSString *date;
    //date = [NSString stringWithFormat:@"2013-04-27"];
    //NSLog(@"Trying to sign in with sessionid:%@ date:%@",sessionID,date);
   // NSLog(@"Trying to sign in with sessionid:%@ date:%@",sessionID,tanggalSend);
    //tanggaldipilih.text = date;
    tanggaldipilih.text = tanggalSend;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCheckBalance.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:tanggalSend forKey:@"date"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];

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
    
    NSArray *saldo = [json objectForKey:@"Balance"]; //2
    
    
    //trial
    NSArray *innerString = [json valueForKey:@"Balance"];
    //NSString *namaCurrency = (NSString *) [[json valueForKey:@"Balance"] valueForKey:@"Currency"];
    //NSLog(@"innerstring count:%d",innerString.count);
    
//    for (NSDictionary *content in innerString)
//    {
//        NSString *type = [content objectForKey:@"Currency"];
//        if ([type isEqualToString:@"USD"])
//        {
    for (int i=0;saldo.count;i++){
        
        
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        [numberFormatter setCurrencySymbol:@""];
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        
        percentFormatter = [[NSNumberFormatter alloc] init];
        [percentFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [percentFormatter setCurrencySymbol:@""];
        [percentFormatter setMaximumFractionDigits:2];
        [percentFormatter setMinimumFractionDigits:0];
        [percentFormatter setAlwaysShowsDecimalSeparator:YES];


        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *fundName = [tempDict objectForKey:@"fundName"];
        label = (UILabel *)[self.view viewWithTag:i+1];
        label.text = [NSString stringWithFormat:@"%@",fundName];
        //NSLog(@"fundname:%@",fundName);;
    }
    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *unit = [tempDict objectForKey:@"unit"];
        label = (UILabel *)[self.view viewWithTag:i+12];
        //NSString *unit = [numberFormatter stringFromNumber:
        //label.text = [NSString stringWithFormat:@"%@",unit];
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[unit floatValue]]];
        //NSLog(@"unit:%@",unit);;
}


    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *average = [tempDict objectForKey:@"averageNAv"];
        label = (UILabel *)[self.view viewWithTag:i+23];
        //label.text = [NSString stringWithFormat:@"%@",average];
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[average floatValue]]];
        //NSLog(@"average:%@",average);;
    }
    
    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *closing = [tempDict objectForKey:@"closingNAV"];
        label = (UILabel *)[self.view viewWithTag:i+34];
        //label.text = [NSString stringWithFormat:@"%@",closing];
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[closing floatValue]]];
        //NSLog(@"closing:%@",closing);;
    }

    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *fundvalue = [tempDict objectForKey:@"fundValue"];
        label = (UILabel *)[self.view viewWithTag:i+45];
        //label.text = [NSString stringWithFormat:@"%@",fundvalue];
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[fundvalue floatValue]]];

        //NSLog(@"fundvalue:%@",fundvalue);;
    }
    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *marketvalue = [tempDict objectForKey:@"marketValue"];
        label = (UILabel *)[self.view viewWithTag:i+56];
        //label.text = [NSString stringWithFormat:@"%@",marketvalue];
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[marketvalue floatValue]]];

       
    }

    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *gainorlost = [tempDict objectForKey:@"gainOrLost"];
        label = (UILabel *)[self.view viewWithTag:i+67];
        //label.text = [NSString stringWithFormat:@"%@",gainorlost];
        label.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlost floatValue]]];

     
    }

    for (int i=0;i<saldo.count;i++){
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *gainorlostpercent = [tempDict objectForKey:@"gainOrLostPercentage"];
        label = (UILabel *)[self.view viewWithTag:i+78];
        //label.text = [NSString stringWithFormat:@"%@",gainorlostpercent];
        label.text = [NSString stringWithFormat:@" %@ %%",[percentFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlostpercent floatValue]]]];

        
    }
//        }
//    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickDate:(id)sender{
    
//    UINavigationController *navigation = [[UINavigationController alloc] init];
//	CalendarViewController *controller = [[CalendarViewController alloc] init];
//	[navigation pushViewController:controller animated:NO];
//	[controller setCalendarViewControllerDelegate:self];
//	
//    [self.view addSubview:navigation.view];

    
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
    
    calendar.frame = CGRectMake(450,230, 280, 300);
    [self.view addSubview:calendar];
    
    //self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //[self.view addSubview:self.dateLabel];
    
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
    tanggaldipilih.text = tanggal;
    [self loadData:tanggal];
    [self.calendar removeFromSuperview];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}

- (IBAction)back:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}

@end
