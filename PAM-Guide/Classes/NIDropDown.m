//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "CekTransaction.h"
#include "AppDelegate.h"


@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imageList;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection,fvaluepass,tempfvaluepas;

- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction {
    btnSender = b;
    NSLog(@"Tag:%d",btnSender.tag);
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    if ([self.imageList count] == [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self hideDropDown:btnSender];
    
    //CekTransaction *cekView= [[CekTransaction alloc] init];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    //fvaluepass = [c.textLabel.text substringToIndex:2];
    
   tempfvaluepas = c.textLabel.text;
    
    if (btnSender.tag ==1 || btnSender.tag ==2)
    {
    if ([tempfvaluepas isEqualToString:@"5 Transaksi Terakhir"]) fvaluepass = @"5";
    if ([tempfvaluepas isEqualToString:@"10 Transaksi Terakhir"]) fvaluepass = @"10";
    if ([tempfvaluepas isEqualToString:@"15 Transaksi Terakhir"]) fvaluepass = @"15";
    if ([tempfvaluepas isEqualToString:@"6 bulan Terakhir"]) fvaluepass = @"1";
    if ([tempfvaluepas isEqualToString:@"1 Tahun Terakhir"]) fvaluepass = @"2";
    if ([tempfvaluepas isEqualToString:@"3 Tahun Terakhir"]) fvaluepass = @"3";
    if ([tempfvaluepas isEqualToString:@"Periode Tertentu"])
    {
        fvaluepass = @"4" ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showperiode" object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideperiode" object:self];
    }
    
    if ([tempfvaluepas isEqualToString: @"Panin Dana Maksima"]) fvaluepass = @"1";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Prima"]) fvaluepass = @"19";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Syariah Saham"]) fvaluepass = @"47";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Bersama Plus"]) fvaluepass = @"44";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Bersama"]) fvaluepass = @"27";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Unggulan"] || [tempfvaluepas isEqualToString:@"Reksadana Panin Dana Unggulan"]) fvaluepass = @"10";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Syariah Berimbang"]) fvaluepass = @"48";
    if ([tempfvaluepas isEqualToString: @"Panin Dana USD"]) fvaluepass = @"18";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Prioritas"]) fvaluepass = @"49";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Utama Plus 2"]) fvaluepass = @"15";
    if ([tempfvaluepas isEqualToString: @"Panin Gebyar Indonesia II"] || [tempfvaluepas isEqualToString: @"Reksadana Panin Gebyar Indonesia II"]) fvaluepass = @"23";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Likuid"]) fvaluepass = @"46";
        [appDelegate.fvalueGlobalString setString:fvaluepass];
        appDelegate.fvalueString = [[NSString alloc]initWithString:tempfvaluepas];
    }
    
    if (btnSender.tag ==55)
    {
    if ([tempfvaluepas isEqualToString: @"Panin Dana Maksima"]) custodianID = @"21648";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Prima"]) custodianID = @"1027816";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Syariah Saham"]) custodianID = @"21648";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Bersama Plus"]) custodianID = @"1027818";
    //if ([tempfvaluepas isEqualToString: @"Panin Dana Bersama"]) custodianID = @"27";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Unggulan"] || [tempfvaluepas isEqualToString:@"Reksadana Panin Dana Unggulan"]) custodianID = @"1027815";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Syariah Berimbang"]) custodianID = @"21648";
    //if ([tempfvaluepas isEqualToString: @"Panin Dana USD"]) custodianID = @"18";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Prioritas"]) custodianID = @"21648";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Utama Plus 2"]) custodianID = @"21648";
    if ([tempfvaluepas isEqualToString: @"Panin Gebyar Indonesia II"] || [tempfvaluepas isEqualToString: @"Reksadana Panin Gebyar Indonesia II"]) custodianID = @"1027817";
    if ([tempfvaluepas isEqualToString: @"Panin Dana Likuid"]) custodianID = @"1027814";
    
    
    

//    [appDelegate.fvalueGlobalString setString:fvaluepass];
//     appDelegate.fvalueString = [[NSString alloc]initWithString:tempfvaluepas];
    
//    NSIndexPath *path = [tableView indexPathForSelectedRow];
//    NSUInteger templastIndex = [path indexAtPosition:[path length] - 1];
//    NSLog(@"index selected:%d",templastIndex);
//    //NSUInteger lastIndex = templastIndex+1;

    //else if (btnSender.tag == 55) //button tag from top up.xib
    //{
    
        
        appDelegate.custodianID = [[NSString alloc]initWithString:custodianID];
        //labelNoRekening.text = appDelegate.custodianID;
        
        NSLog(@"app delegate:%@",appDelegate.custodianID);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updatecustodianlabel" object:self];
    }
    
  else if (btnSender.tag == 66) // button tag from topup.xib list bank account
    {
    NSIndexPath *path = [tableView indexPathForSelectedRow];
    NSUInteger templastIndex = [path indexAtPosition:[path length] - 1];
    appDelegate.index = templastIndex;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatelistbankaccount" object:self];
    }


    
    //[cekView setFvalue:one];
    
    
//    for (UIView *subview in btnSender.subviews) {
//        if ([subview isKindOfClass:[UIImageView class]]) {
//            [subview removeFromSuperview];
//        }
//    }
//    imgView.image = c.imageView.image;
//    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
//    imgView.frame = CGRectMake(5, 5, 25, 25);
//    [btnSender addSubview:imgView];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];
}

-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
