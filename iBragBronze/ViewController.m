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
#import "LabelThin.h"

#define blackColor [UIColor blackColor]
#define bronzeColor RGB(234, 170, 61)
#define silverColor RGB(76, 91, 94)
#define platinumColor RGB(148, 148, 148)
#define goldColor RGB(255, 203, 67)

@interface ViewController ()
{
	IBOutlet LabelThin *labelVersionType;
	IBOutlet UIButton *buttonOne;
	IBOutlet UIButton *buttonTwo;
	IBOutlet UIButton *buttonThree;
	IBOutlet UIButton *buttonFour;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
#ifdef BLACK
	labelVersionType.text = @"Black";
	labelVersionType.textColor = blackColor;
	[buttonOne setTitle:@"Bronze" forState:UIControlStateNormal];
	[buttonOne setTitleColor:bronzeColor forState:UIControlStateNormal];
#elif BRONZE
	labelVersionType.text = @"Bronze";
	labelVersionType.textColor = bronzeColor;
#elif SILVER
	labelVersionType.text = @"Silver";
	labelVersionType.textColor = silverColor;
	[buttonFour setTitle:@"Bronze" forState:UIControlStateNormal];
	[buttonFour setTitleColor:bronzeColor forState:UIControlStateNormal];
#elif PLATINUM
	labelVersionType.text = @"Platinum";
	labelVersionType.textColor = platinumColor;
	[buttonTwo setTitle:@"Bronze" forState:UIControlStateNormal];
	[buttonTwo setTitleColor:bronzeColor forState:UIControlStateNormal];
#elif GOLD
	labelVersionType.text = @"Gold";
	labelVersionType.textColor = goldColor;
	[buttonThree setTitle:@"Bronze" forState:UIControlStateNormal];
	[buttonThree setTitleColor:bronzeColor forState:UIControlStateNormal];
#endif
}

- (IBAction)buttonFacebookPressed {
    
    [Flurry logEvent:[NSString stringWithFormat:@"Facebook button pressed in %@ version", labelVersionType.text]];
    
    [self postToFacebook];
	
}

- (IBAction)buttonEmailPressed {
    [Flurry logEvent:[NSString stringWithFormat:@"Email button pressed in %@ version", labelVersionType.text]];
	if ([MFMailComposeViewController canSendMail]){
		NSString *message = [NSString stringWithFormat:@"Get %@ Bragging Rights for yourself too!", labelVersionType.text];
		
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		
		
		picker.mailComposeDelegate = self;
		[picker setToRecipients:[NSArray array]];
		[picker setSubject:[NSString stringWithFormat:@"I just bought %@ Bragging Rights", labelVersionType.text]];
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
    [Flurry logEvent:[NSString stringWithFormat:@"Share button pressed in %@ version", labelVersionType.text]];
	NSURL * url = [NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard"];
	
	[[UIApplication sharedApplication] openURL:url];
}

//- (IBAction)buttonGoldPressed {
//    [Flurry logEvent:@"Gold button pressed in Bronze version"];
//	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/gold"];
//	
//	[[UIApplication sharedApplication] openURL:url];
//}
//
//- (IBAction)buttonPlatinumPressed {
//	[Flurry logEvent:@"Platinum button pressed in Bronze version"];
//    NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/platinum"];
//	
//	[[UIApplication sharedApplication] openURL:url];
//}
//
//- (IBAction)buttonSilverPressed {
//    [Flurry logEvent:@"Silver button pressed in Bronze version"];
//	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/silver"];
//	
//	[[UIApplication sharedApplication] openURL:url];
//}
//
//- (IBAction)buttonBlackPressed {
//    [Flurry logEvent:@"Black button pressed in Bronze version"];
//	NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/black"];
//	
//	[[UIApplication sharedApplication] openURL:url];
//}

- (IBAction)buttonBuyNewTypePressed:(UIButton *)sender {
	NSLog(@"%@ button pressed in %@ version", [sender titleForState:UIControlStateNormal], labelVersionType.text);
	[Flurry logEvent:[NSString stringWithFormat:@"%@ button pressed in %@ version", [sender titleForState:UIControlStateNormal], labelVersionType.text]];
	NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/%@", [[sender titleForState:UIControlStateNormal] lowercaseString]]];
	
	[[UIApplication sharedApplication] openURL:url];
}

#pragma mark - FB Sharing

- (void)postToFacebook
{
    NSDictionary* params = @{@"name": [NSString stringWithFormat:@"I just bought %@ Bragging Rights", labelVersionType.text],
                             @"caption": @"get one for yourself too",
                             //@"description": @"get one for yourself too",
                             @"link": [NSString stringWithFormat:@"https://itunes.apple.com/bogus-link/%@", [labelVersionType.text lowercaseString]]
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

- (void)viewDidUnload {
	labelVersionType = nil;
	buttonOne = nil;
	buttonTwo = nil;
	buttonThree = nil;
	buttonFour = nil;
	[super viewDidUnload];
}
@end
