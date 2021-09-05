
//  Created by Henry.
//  Copyright © 2021 . All rights reserved.
//

#import "ItemsCell.h"

@interface ItemsCell()

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation ItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_iconImageView setImage:[UIImage imageNamed:@"item"]];
}

// MARK: - Statics
+ (NSString*)identifier {
    return NSStringFromClass([ItemsCell class]);
}

// MARK: - Object
- (void)updateWithItem:(NSString *)_itemId
                Quanlity:(NSString *)_quanlity{
    
    _idLabel.text = [NSString stringWithFormat:@"ID: %@", _itemId];
    _detailLabel.text =  [NSString stringWithFormat:@"Quanlity: %@",_quanlity];
    
    [_iconImageView setImage:[UIImage imageNamed:@"item"]];
}

- (void)updateWithInvoice:(NSString *)_invoiceNumber
                   Status:(NSString *)_receiveStatus{
    
    _idLabel.text = [NSString stringWithFormat:@"Invoice Number: %@", _invoiceNumber];
    _detailLabel.text =  [NSString stringWithFormat:@"Received Status: %@",_receiveStatus];
    
    [_iconImageView setImage:[UIImage imageNamed:@"invoice"]];
    
}

// MARK: - Helper
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _borderView.layer.borderWidth = 0.5;
    _borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _borderView.layer.cornerRadius = 4;
}



@end
