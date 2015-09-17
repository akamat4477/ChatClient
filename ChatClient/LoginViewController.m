//
//  LoginViewController.m
//  ChatClient
//
//  Created by anjaneya kamat on 9/16/15.
//  Copyright (c) 2015 anjaneya kamat. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ChatViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.statusLabel setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)signinClick:(id)sender {
     [self.statusLabel setHidden:true];
    NSString* name = self.emailTextView.text;
    NSString* password = self.passwordTextView.text;

    [PFUser logInWithUsernameInBackground:name password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self loginSuccessful];
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            self.statusLabel.text = errorString;
                                            [self.statusLabel setHidden:false];
                                        }
                                    }];
}

- (IBAction)signupClick:(id)sender {
    PFUser *user = [PFUser user];
    user.username = @"anjaneyakamat";
    user.password = @"password123";
    user.email = @"anjaneyakamat@gmail.com";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.statusLabel.text = @"Sign in succeeded. Please sign in now.";
            [self.statusLabel setHidden:false];

        } else {   NSString *errorString = [error userInfo][@"error"];   
            self.statusLabel.text = errorString;
            [self.statusLabel setHidden:false];
        }
    }];
}

- (void) loginSuccessful {
    self.statusLabel.text = @"Sign in succeeded. Please sign in now.";
    [self.statusLabel setHidden:false];
    
    [self performSegueWithIdentifier:@"com.yahoo.anjaneya" sender:self];
    
}


@end
