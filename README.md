# NavQ
表格下拉头

![image](https://github.com/914813666/NavQ/blob/master/imginfo/Untitled7.gif)

#
头部UIView * navBarView 图片控件UIImageView* topView; 标题控件 UILabel * titleLabel; 表格控件UITableView * tableView;

初始化表格
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
        });
        
        
        
  设置高度 
  - (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  CGFLOAT_MIN;
    }
    return  TABLEHEADHEIGHT;
}
//头部效果
//将要展示headview
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
  
####滚动效果的实现
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




