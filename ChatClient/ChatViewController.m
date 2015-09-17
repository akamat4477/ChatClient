//
//  ChatViewController.m
//  ChatClient
//
//  Created by anjaneya kamat on 9/16/15.
//  Copyright (c) 2015 anjaneya kamat. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "MessageTableViewTableViewCell.h"

@interface ChatViewController (){
    NSArray *messages;
}

@end

@implementation ChatViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatTableView.dataSource = self;
    self.chatTableView.delegate = self;
    
     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(syncMessages) userInfo:nil repeats:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageTableViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.message.cell" forIndexPath:indexPath];
    PFObject* message = (PFObject*)messages[indexPath.row];
    cell.messageTextLabel.text = message[@"content"];

    return cell;
}


- (IBAction)sendMessage:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"GroupMessages"];
    message[@"groupName"] = @"WeChatGroupCenter";
    message[@"content"] = self.messageTextField.text;
    PFUser *currentUser = [PFUser currentUser];
    message[@"fromUserId"] = currentUser[@"username"];
    [message saveInBackground];
}

- (void) syncMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"GroupMessages"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            messages = objects;
            NSLog(@"Successfully retrieved %lu messages: %@", objects.count ,messages);
            [self.chatTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@ ", error, [error userInfo]);
        }
    }];
}




@end
