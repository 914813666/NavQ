//
//  TableViewHeaderFooterView.m
//  NavQ
//
//  Created by qzp on 16/1/21.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "TableViewHeaderFooterView.h"

@implementation TableViewHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.center.y);
}

@end
