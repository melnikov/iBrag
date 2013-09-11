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

- (void)shareViaFacebook
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (!delegate.session.isOpen)
    {
        if (!delegate.session || delegate.session.state != FBSessionStateCreated)
        {
            delegate.session = [[FBSession alloc] initWithAppID:nil permissions:[NSArray arrayWithObject:@"publish_stream"] urlSchemeSuffix:nil tokenCacheStrategy:nil];
        }
        
        [delegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [FBSession setActiveSession:delegate.session];
            [self postToFacebook];
        }];
    }
    else
    {
        [FBSession setActiveSession:delegate.session];
        [self postToFacebook];
    }
}

- (void)postToFacebook
{
    
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    [action setObject:@"https://apps.notrepro.net/fbsdktoolkit/objectds/book/Snow-Crash.html"forKey:@"book"];
    
    FBOpenGraphActionShareDialogParams* params = [[FBOpenGraphActionShareDialogParams alloc]init];
    params.actionType = @"books.reads";
    params.action = action;
    params.previewPropertyName = @"book";
    
    // Show the Share dialog if available
    if(0/*[FBDialogs canPresentShareDialogWithOpenGraphActionParams:params]*/) {
        
        [FBDialogs presentShareDialogWithOpenGraphAction:[params action]
                                              actionType:[params actionType]
                                     previewPropertyName:[params previewPropertyName]
                                                 handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                     // handle response or error
                                                 }];
        
    }
    // If the Facebook app isn't available, show the Feed dialog as a fallback
    else {
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
