//
//  ViewController.m
//  RunLoopSource
//
//  Created by etiantian on 2019/10/30.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * reusedCellId = @"reusedCellId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusedCellId];
    [self.view addSubview:self.tableView];
    
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//    [self.view addGestureRecognizer:tapGes];
    
    
    //[self performSelectorOnMainThread:@selector(handleSource0) withObject:nil waitUntilDone:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    [cell.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"ok.jpg"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
    return cell;
}

- (void)tapAction {
    NSLog(@"tap action");
}

//- (IBAction)click:(UIButton *)sender {
//    NSLog(@"click button");
//}

- (void)handleSource0 {
    NSLog(@"performSelector:OnThread");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行任务A");
        [self performSelector:@selector(tapAction) withObject:nil afterDelay:1.0];
        NSLog(@"执行任务C");
        [[NSRunLoop currentRunLoop]addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
    });
}


@end
