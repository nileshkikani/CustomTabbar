
@class CustomListIPhone;

@protocol CustomListIPhoneDelegate

@required

- (void)PlayViewSelected:(CustomListIPhone *)navBar;
- (void)WalletViewSelected:(CustomListIPhone *)navBar;
- (void)CouponsViewSeleceted:(CustomListIPhone *)navBar;
- (void)ProfileViewSeleceted:(CustomListIPhone *)navBar;
- (void)SettingsViewSeleceted:(CustomListIPhone *)navBar;

@end