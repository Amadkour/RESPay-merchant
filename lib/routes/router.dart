import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/network_error_widget.dart';
import 'package:res_pay_merchant/core/widget/dialogs/main_dialog.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/view/page/create_new_password_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/view/page/forget_password_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/page/login_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/view/page/onboarding_view.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/view/otp_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/view/page/pin_code_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/view/page/regeistration_view.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/page/card_limit_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/page/cards_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/view/page/cards_credit_card_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/view/page/cashback_digital_cards_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/view/page/notification_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/page/faq_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/about/view/page/about_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/view/page/customer_loyalty_first.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/view/page/customer_loyalty_rate.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/privacy/view/page/privacy_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/pages/profile_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/page/promotions_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/page/promotions_search_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/pages/referral_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/view/page/change_password_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/page/shipping_location_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/view/page/support_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/view/page/terms_and_conditions_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/page/settings.dart';
import 'package:res_pay_merchant/features/dashboard/view/page/dashboard_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/page/cart_items_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_detail_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_search_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/product_details_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/single_story_preview_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/video_list_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/page/checkout_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/view/page/favourite_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_details_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/view/page/store_details.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/view/page/card_info_page.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/page/add_category_page.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/page/analytics_details_page.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/gift/local/add_new_beneficiary_gift.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/request/local/add_request_page.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/parent/transfer_details_page.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/list/page/beneficiary_list.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/page/budget_category_details_page.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/page/budget_page.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/page/new_budget_category_page.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/page/bank_transfer_page.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/page/deposite_via_page.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/page/new_deposit_page.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/view/page/gift_tabs.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/pages/transaction_search_screen.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/pages/transfer_history_page.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/view/page/add_bill_request.dart';
import 'package:res_pay_merchant/features/payment/modules/qr_code/view/page/qr_code_page.dart';
import 'package:res_pay_merchant/features/payment/modules/qr_code/view/page/qr_code_transfer_money_page.dart';
import 'package:res_pay_merchant/features/payment/modules/request/view/page/request_tabs.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/page/recent_activity_saving_page.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/page/saving_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/page/beneficiary_activate_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/page/beneficiary_successfully_activated_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/page/new_transfer_summary_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/page/transfer_money_page.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/view/pages/add_bank_account.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/view/pages/withdraw_page.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

mixin AppRouter {
  static Route<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.activateBeneficiary:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => BeneficiaryActivatePage(
            beneficiary: settings.arguments! as Beneficiary,
          ),
        );
      case RoutesName.profile:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => ProfilePage(
            profileValidationFormKey:
                settings.arguments! as GlobalKey<FormState>,
          ),
        );
      case RoutesName.referral:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const ReferralPage(),
        );
      case RoutesName.settings:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const SettingsPage(),
        );
      case RoutesName.addRequest:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => AddRequestPage(
            beneficiary: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['beneficiary']
                    as Beneficiary?)
                : null,
            phoneNumber: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['phoneNumber']
                    as String?)
                : null,
          ),
        );
      case RoutesName.networkError:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => NetworkErrorWidget(
            callback: settings.arguments! as Future<void> Function(),
          ),
        );
      case RoutesName.beneficiaryActivated:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) =>
              BeneficiarySuccessfullyActivatedPage(
            beneficiary: settings.arguments != null
                ? settings.arguments! as Beneficiary
                : null,
          ),
        );
      case RoutesName.gift:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const GiftTabs(),
        );

      case RoutesName.transferBeneficiaries:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const BeneficiaryList(
              serviceType: ServiceType.transfer, haveAppBar: false),
        );

      case RoutesName.request:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const RequestTabs(),
        );
      case RoutesName.addNewBeneficiaryGift:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => AddNewBeneficiaryGift(
            beneficiary: settings.arguments != null
                ? settings.arguments! as Beneficiary
                : null,
          ),
        );
      case RoutesName.transferMoneyScreen:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => TransferMoneyPage(
            beneficiary: settings.arguments! as Beneficiary,
          ),
        );
      case RoutesName.newTransferSummary:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => NewTransferSummaryPage(
            beneficiary: settings.arguments! as Beneficiary,
          ),
        );

      case RoutesName.transferTo:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return const BeneficiaryList(
                serviceType: ServiceType.transfer,
              );
            });
      case RoutesName.support:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return SupportPage(
                supportValidationFormKey:
                    settings.arguments! as GlobalKey<FormState>,
              );
            });
      case RoutesName.qrCode:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => QRCodePage(
            returnWithValue:
                settings.arguments != null ? settings.arguments! as bool : null,
          ),
        );

      case RoutesName.qrCodeTransferMoneyPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const QRCodeTransferMoneyPage(),
        );
      case RoutesName.saving:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const SavingPage(),
        );
      case RoutesName.recentActivitySaving:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => RecentActivitySavingPage(
            cubit: settings.arguments! as SavingCubit,
          ),
        );
      case RoutesName.internationalResApp:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const TransferTypePage(),
        );
      case RoutesName.register:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const RegistrationView(),
        );
      case RoutesName.authDashboard:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const DashboardPage(
            isAuthorized: true,
          ),
        );
      case RoutesName.dashboard:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const DashboardPage(
            isAuthorized: false,
          ),
        );

      /// Cards Section
      case RoutesName.cards:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const CardsPage(),
        );
      case RoutesName.changeLimit:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const CardLimitPage(),
        );
      case RoutesName.cardCreditCard:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CardsCreditCardPage(
              creditCardModels: settings.arguments! as List<CreditCardModel>),
        );
      case RoutesName.cashBackDigitalCardsPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const CashBackDigitalCardsPage(),
        );

      case RoutesName.otp:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => OTPPage(
            onSuccess:
                settings.arguments! as Future<void> Function(String? code)?,
          ),
        );
      case RoutesName.transactionOtp:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => OTPPage(
            onSuccess:
                settings.arguments! as Future<void> Function(String? code)?,
            isFromAuth: false,
          ),
        );

      case RoutesName.onBoarding:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const OnBoardingView(),
        );
      case RoutesName.login:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const LoginPage(),
        );
      case RoutesName.notification:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const NotificationPage(),
        );
      case RoutesName.pinCode:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PinCodePage(
            canPop: settings.arguments != null,
            // ignore: avoid_bool_literals_in_conditional_expressions
            setup:
                // ignore: avoid_bool_literals_in_conditional_expressions
                (settings.arguments is Map)
                    ? ((settings.arguments as Map<String, dynamic>?)?['setup']
                            as bool? ??
                        false)
                    : false,
            onSuccess: settings.arguments == null
                ? () async {
                    CustomNavigator.instance.pushNamedAndRemoveUntil(
                        RoutesName.authDashboard,
                        (Route<dynamic> route) => false);
                    return '';
                  }
                : settings.arguments is Map
                    ? ((settings.arguments
                            as Map<String, dynamic>?)!['onSuccess']
                        as Future<String?> Function()?)
                    : settings.arguments as Future<String?> Function()?,
          ),
        );
      case RoutesName.pinCodeWithoutAnimation:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              PinCodePage(
            setup: false,
            canPop: false,
            onSuccess: () async {
              CustomNavigator.instance.pop();
              return '';
            },
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case RoutesName.setupPinCode:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PinCodePage(
            setup: true,
            onSuccess: () async {
              MainDialog(
                  imagePNG: 'assets/images/register_confirmation.png',
                  imageHeight: 188,
                  imageWidth: 260,
                  dialogTitle: 'Congratulations!',
                  dialogSupTitle:
                      'Your account is ready to use. You wild be redirected to the home page in a few seconds.');
              await Future<dynamic>.delayed(
                const Duration(
                  seconds: 2,
                ),
              );

              CustomNavigator.instance.pop(result: 'dialog');
              await CustomNavigator.instance
                  .pushNamed(RoutesName.authDashboard);
              return '';
            },
          ),
        );
      case RoutesName.forgetPassword:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const ForgetPasswordPage(),
        );
      case RoutesName.createNewPassword:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CreateNewPasswordPage(
              map: settings.arguments! as Map<String, dynamic>),
        );
      case RoutesName.changePassword:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const ChangePasswordPage(),
        );

      case RoutesName.newDeposit:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const NewDepositPage(),
        );
      case RoutesName.payBill:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const AddBillRequest(),
        );
      case RoutesName.depositVia:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => DepositViaPage(
            cubit: settings.arguments! as DepositCubit,
          ),
        );
      case RoutesName.transferHistory:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const TransferHistoryPage(),
        );
      case RoutesName.withdraw:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const WithdrawView(),
        );

      case RoutesName.addBankAccount:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => AddBankAccount(
            withdrawCubit: settings.arguments! as WithdrawCubit,
          ),
        );

      case RoutesName.analyticsDetails:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => AnalyticsDetailsPage(
            isAuthorized: settings.arguments! as bool,
          ),
        );
      case RoutesName.addCategory:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => AddCategoryPage(
            index: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['index']
                    as int?)
                : null,
            isAuthorized: (settings.arguments is Map)
                ? ((settings.arguments
                    as Map<String, dynamic>?)?['isAuthorized'] as bool?)
                : null,
          ),
        );

      case RoutesName.budget:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const BudgetPage(),
        );
      case RoutesName.addBudgetCategory:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => NewBudgetCategoryPage(
            isEditing: (settings.arguments ?? false) as bool,
          ),
        );
      case RoutesName.transactionSearch:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const TransactionSearchScreen(),
        );
      case RoutesName.privacy:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const PrivacyPage(),
        );
      case RoutesName.terms:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const TermsAndConditionsPage(),
        );
      case RoutesName.about:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const AboutPage(),
        );
      case RoutesName.shippingLocation:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const ShippingLocationPage(),
        );

      case RoutesName.videoList:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const VideoListPage(),
        );

      case RoutesName.faqs:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const FAQsPage(),
        );
      case RoutesName.storyPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => SingleStoryPreviewPage(
            story: settings.arguments! as Story,
          ),
        );
      case RoutesName.celebritySearch:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const CelebritySearchScreen(),
        );
      case RoutesName.promotionsSearch:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const PromotionsSearchScreen(),
        );
      case RoutesName.cardInfo:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CardInfoPage(
            arguments: settings.arguments! as Map<String, dynamic>,
          ),
        );
      case RoutesName.budgetCategoryPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => BudgetCategoryDetailsPage(
            category: settings.arguments! as BudgetCategoryModel,
          ),
        );

      case RoutesName.ordersPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const OrdersPage(),
        );
      case RoutesName.bankTransfer:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const BankTransferPage(),
        );
      case RoutesName.cart:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CardItemsPage(
            shopUUID: settings.arguments! as String,
          ),
        );
      case RoutesName.favorite:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => FavouritePage(
            shopUUID: settings.arguments! as String,
          ),
        );
      case RoutesName.celerityDetail:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CelebrityDetail(
            currentCelebrity: settings.arguments! as Celebrity,
          ),
        );
      case RoutesName.customerLoyalty:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => MainCustomerLoyalty(),
        );
      case RoutesName.customerLoyaltyRate:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => CustomerRate(),
        );
      case RoutesName.orderDetails:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => OrderDetailsPage(),
        );
      case RoutesName.storeDetails:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => StoreDetail(
            shopSlug: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['shopSlug']
                    as String)
                : "",
          ),
        );

      case RoutesName.checkout:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const CheckoutPage(),
        );

      case RoutesName.product:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => ProductPage(
            shopUUID: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['shopUUID']
                    as String)
                : "",
            product: (settings.arguments is Map)
                ? ((settings.arguments as Map<String, dynamic>?)?['product']
                    as ProductModel)
                : ProductModel(),
          ),
        );
      case RoutesName.promotions:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const PromotionsPage(),
        );

      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => const LoginPage(),
        );
    }
  }
}
