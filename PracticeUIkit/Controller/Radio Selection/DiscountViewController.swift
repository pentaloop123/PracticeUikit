//
//  DiscountViewController.swift
//  PracticeUIkit
//
//  Created by ladmin on 15/05/2024.
//

import UIKit

class DiscountViewController: UIViewController {
    
    
//    @property (weak, nonatomic) IBOutlet UIImageView *percentageIcon;
//    @property (weak, nonatomic) IBOutlet UIImageView *fixedIcon;
//    @property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *fixedLabel;
//
//    @property (weak, nonatomic) IBOutlet UIView *percentageView;
//    @property (weak, nonatomic) IBOutlet UIView *fixedView;
//    
//    UIImage *selectedImage;
//    UIImage *unselectedImage;
//    NSInteger selectedId = 0;
//    
//    
//    [self setupView];
//    
//    - (void)setupView {
//        selectedImage = [UIImage imageNamed:@"radioEmpty"];
//        unselectedImage = [UIImage imageNamed:@"radioFill"];
//        _fixedIcon.image = selectedImage;
//        _percentageIcon.image = unselectedImage;
//        _percentageView.hidden = FALSE;
//        _fixedView.hidden = YES;
//    }
//    
//    - (IBAction)didTapBtn:(UIButton *)sender {
//        switch (sender.tag) {
//            case 0:
//                selectedId = 0;
//                _fixedIcon.image = selectedImage;
//                _percentageIcon.image = unselectedImage;
//                _percentageView.hidden = FALSE;
//                _fixedView.hidden = YES;
//                break;
//                
//            case 1:
//                selectedId = 1;
//                _fixedIcon.image = unselectedImage;
//                _percentageIcon.image = selectedImage;
//                _percentageView.hidden = YES;
//                _fixedView.hidden = FALSE;
//                break;
//                
//            default:
//                break;
//        }
//    }

    
    
    
    @IBOutlet weak var percentageIcon: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var fixedIcon: UIImageView!
    @IBOutlet weak var fixedLabel: UILabel!
    
    @IBOutlet weak var fixedBtn: UIButton!
    @IBOutlet weak var percentageBtn: UIButton!
    
    var selectedId = 0
    
//    let selectedImage = UIImage(named: "radioEmpty")
//    let unselectedImage = UIImage(named: "radioFill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    


    
}
