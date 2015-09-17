//
//  LoginViewController.h
//  ChatClient
//
//  Created by anjaneya kamat on 9/16/15.
//  Copyright (c) 2015 anjaneya kamat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)signinClick:(id)sender;
- (IBAction)signupClick:(id)sender;
@end


