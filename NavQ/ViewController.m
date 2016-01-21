//
//  ViewController.m
//  NavQ
//
//  Created by qzp on 16/1/21.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "ViewController.h"
#import "TableViewHeaderFooterView.h"
#import "TestViewController.h"
#define  kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define TOPIMAGEVIEW_HEIGHT 260 //头部图片视图高度
#define TABLEHEADHEIGHT 44 //

#define TOPCOLOR [UIColor colorWithRed:0.182 green:0.6943 blue:0.5302 alpha:1.0]


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIImageView* topView;

@property (nonatomic, strong) UIView * navBarView;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeUserInterface];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
       self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
      self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
   
}
- (void) initializeUserInterface {
    

    
    _tableView = ({
        UITableView * tb = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight) style: UITableViewStylePlain];
        [self.view addSubview: tb];
        tb.delegate = self;
        tb.dataSource = self;
        tb.rowHeight = 50;
        tb.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, kScreenHeight, TOPIMAGEVIEW_HEIGHT - 40)]; //高度为顶部图片的高度
        
        tb;
    });
    
    [_tableView registerClass: [TableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier: NSStringFromClass([TableViewHeaderFooterView class])];
    
    _topView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apic16896.jpg"]];
        imageView.frame = CGRectMake(0, -40, kScreenWidth, TOPIMAGEVIEW_HEIGHT);
        [self.view addSubview: imageView];
        imageView;
                                
    });
    
    _navBarView = ({
        UIView * nv = [[UIView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, 64)];
        nv.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
        [self.view addSubview: nv];
        nv;
    });

    _titleLabel = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.attributedText = [[NSAttributedString alloc] initWithString:@"这是标题"
                                                             attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [lab sizeToFit];
        [lab setCenter:CGPointMake(kScreenWidth/2, 38)];
        [self.view addSubview:lab];
        lab;
    });

}

#pragma mark -UITableViewDataSource-
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return  3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return  10;
    }
    
    return 20;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return  cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  CGFLOAT_MIN;
    }
    return  TABLEHEADHEIGHT;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  CGFLOAT_MIN;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  nil;
    }
    
    TableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: NSStringFromClass([TableViewHeaderFooterView class])];
    headerView.contentView.backgroundColor = TOPCOLOR;
    NSString * str = [NSString stringWithFormat:@"第%d个",section];
    headerView.textLabel.attributedText = [[NSAttributedString alloc] initWithString: str  attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        CGRect frame = self.navBarView.frame;
        frame.size.height = 64;
        self.navBarView.frame = frame;
        self.titleLabel.alpha = 1;
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        CGRect frame = self.navBarView.frame; //20
        frame.size.height =  64 - TABLEHEADHEIGHT;
        self.navBarView.frame = frame;
        self.titleLabel.alpha = 0;
    }
}

#pragma mark -UITableViewDelagate-

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.tableView) {
        CGFloat offSetY = scrollView.contentOffset.y;
     
        
        if (offSetY <= 0 && offSetY >= -80) {
            self.topView.frame = CGRectMake(0, -40 - offSetY/2,  kScreenWidth,  TOPIMAGEVIEW_HEIGHT - offSetY / 2);
            self.navBarView.backgroundColor = [UIColor clearColor];
        }
        
        else if (offSetY < -80) {
            self.tableView.contentOffset = CGPointMake(0, -80);
        }
        
        else if (offSetY <= 300) {
               NSLog(@"%.2f",offSetY);
            self.topView.frame = CGRectMake(0, -40 - offSetY, kScreenWidth, TOPIMAGEVIEW_HEIGHT);
            self.navBarView.backgroundColor = [UIColor colorWithRed:0.182 green:0.6943 blue:0.5302 alpha: offSetY/(220 - 64)];
           
        }
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    [self.navigationController pushViewController: [TestViewController new] animated: YES];
}
@end
