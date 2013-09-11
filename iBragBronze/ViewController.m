//
//  ViewController.m
//  iBragBronze
//
//  Created by admin on 11.09.13.
//  Copyright (c) 2013 iBrag. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonFacebookPressed {
	
}

- (IBAction)buttonEmailPressed {
	if ([MFMailComposeViewController canSendMail]){
		NSString *message = @"\"Get Platinum Bragging Rights for yourself too!\"\n\nwith Platinum Bragging Rights hyperlinked to the App Store URL. I'm thinking about appending a screenshot of the app or the app icon at the end of the email too. Not sure which will look nicer.";
		
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		
		
		picker.mailComposeDelegate = self;
		[picker setToRecipients:[NSArray array]];
		[picker setSubject:@""];
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
	NSURL * url = [NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1salableAdamId=343200656productType=C&pricingParameter=STDQ"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonGoldPressed {
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/gold"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonPlatinumPressed {
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/platinum"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonSilverPressed {
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/silver"];
	
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)buttonBlackPressed {
	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/black"];
	
	[[UIApplication sharedApplication] openURL:url];
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
