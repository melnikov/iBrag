//
//  ViewController.m
//  iBragBronze
//
//  Created by admin on 11.09.13.
//  Copyright (c) 2013 iBrag. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FacebookSDK/FacebookSDK.h"
#import "Flurry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonFacebookPressed {
    
    [Flurry logEvent:@"Facebook button pressed in Bronze version"];
    
    [self postToFacebook];
	
}

- (IBAction)buttonEmailPressed {
    [Flurry logEvent:@"Email button pressed in Bronze version"];
	if ([MFMailComposeViewController canSendMail]){
		NSString *message = @"Get Bronze Bragging Rights for yourself too!";
		
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		
		
		picker.mailComposeDelegate = self;
		[picker setToRecipients:[NSArray array]];
		[picker setSubject:@"I just bought Bronze Bragging Rights"];
		[picker setMessageBody:message isHTML:NO];
		picker.modalPresentationStyle = UIModalPresentationFormSheet;
		picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:picker animated:YES];
	}
	else
	{
		[[[UIAlertView alloc] initWithTitle:@"Error" message:@"No configured mail services on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}
}

- (IBAction)buttonBuyPressed {
    [Flurry logEvent:@"Share button pressed in Bronze version"];
	NSURL * url = [NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonGoldPressed {
    [Flurry logEvent:@"Gold button pressed in Bronze version"];
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/gold"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonPlatinumPressed {
	[Flurry logEvent:@"Platinum button pressed in Bronze version"];
    NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/platinum"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonSilverPressed {
    [Flurry logEvent:@"Silver button pressed in Bronze version"];
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/silver"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonBlackPressed {
    [Flurry logEvent:@"Black button pressed in Bronze version"];
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/black"];
	
	[[UIApplication sharedApplication] openURL:url];
}


#pragma mark - FB Sharing

- (void)postToFacebook
{
    NSDictionary* params = @{@"name": @"I just bought Bronze Bragging Rights",
                             @"caption": @"get one for yourself too",
                             //@"description": @"get one for yourself too",
                             @"link": @"https://itunes.apple.com/bogus-link/bronze"
                             };
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  // handle response or error
                                              }];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
