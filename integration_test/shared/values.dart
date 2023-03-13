import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';

///Shared
final Finder datasheetFinder = find.byKey(datasheetKey);
final Finder cancelButtonDialogFinder = find.byKey(cancelButtonDialogKey);
final Finder confirmButtonDialogFinder = find.byKey(confirmButtonDialogKey);
final Finder blueTextFinder = find.byKey(blueTextKey);
final Finder settingFinder = find.byKey(settingKey);
final Finder pinCodeTextFieldFinder = find.byKey(pinCodeTextFieldKey);
final Finder yearsDateListFinder = find.byKey(yearsDateListKey);
final Finder bottomSheetListFinder = find.byKey(bottomSheetListKey);

///onBoarding
final Finder goToLoginFinder = find.byKey(goToLoginKey);
final Finder goToSignupFinder = find.byKey(goToSignupKey);

/// Login
final Finder passwordControllerFinder = find.byKey(passwordControllerKey);
final Finder idControllerFinder = find.byKey(idControllerKey);
final Finder loginButtonFinder = find.byKey(loginButtonKey);
final Finder signUpFinder = find.byKey(signUpKey);
final Finder loginListFinder = find.byKey(loginListKey);

/// Forget password
final Finder forgetPasswordFinder = find.byKey(forgetPasswordKey);
final Finder idForgetPasswordTextFieldFinder =
    find.byKey(idForgetPasswordTextFieldKey);
final Finder forgetPasswordListFinder = find.byKey(forgetPasswordListKey);
final Finder confirmButtonForgetPasswordFinder =
    find.byKey(confirmButtonForgetPasswordKey);
final Finder createNewPassTextFieldFinder =
    find.byKey(createNewPassTextFieldKey);
final Finder confirmCreateNewPassTextFieldFinder =
    find.byKey(confirmCreateNewPassTextFieldKey);
final Finder confirmButtonCreateNewPasswordFinder =
    find.byKey(confirmButtonCreateNewPasswordKey);
final Finder createPasswordListFinder = find.byKey(createPasswordListKey);

/// Register

final Finder registerFullNameTextFieldFinder =
    find.byKey(registerFullNameTextFieldKey);
final Finder registerIDNumberTextFieldFinder =
    find.byKey(registerIDNumberTextFieldKey);
final Finder registerDateTextFieldFinder = find.byKey(registerDateTextFieldKey);
final Finder registerPhoneNumberTextFieldFinder =
    find.byKey(registerPhoneNumberTextFieldKey);
final Finder registerEmailTextFieldFinder =
    find.byKey(registerEmailTextFieldKey);
final Finder registerPasswordTextFieldFinder =
    find.byKey(registerPasswordTextFieldKey);
final Finder registerConfirmPasswordTextFieldFinder =
    find.byKey(registerConfirmPasswordTextFieldKey);
final Finder registerConfirmButtonFinder = find.byKey(registerConfirmButtonKey);

/// dashboard
final Finder moreIconFinder = find.byKey(moreIconKey);
final Finder homeIconFinder = find.byKey(homeIconKey);
final Finder shopIconFinder = find.byKey(shopIconKey);
final Finder celebrityIconFinder = find.byKey(celebrityIconKey);

/// more
final Finder moreListFinder = find.byKey(moreListKey);
final Finder scheduleFinder = find.byKey(scheduleKey);
final Finder promotionsFinder = find.byKey(promotionsKey);
final Finder customerLoyaltyFinder = find.byKey(customerLoyaltyKey);
final Finder shippingLocationFinder = find.byKey(shippingLocationKey);
final Finder changeLanguageFinder = find.byKey(changeLanguageKey);
final Finder faqsFinder = find.byKey(faqsKey);
final Finder privacyPolicyFinder = find.byKey(privacyPolicyKey);
final Finder termOfConditionsFinder = find.byKey(termOfConditionsKey);
final Finder aboutUsFinder = find.byKey(aboutUsKey);
final Finder supportFinder = find.byKey(supportKey);
final Finder changePasswordFinder = find.byKey(changePasswordKey);
final Finder logoutButtonFinder = find.byKey(logoutButtonKey);

/// home
final Finder transferFinder = find.byKey(transferKey);
final Finder depositFinder = find.byKey(depositKey);
final Finder withdrawFinder = find.byKey(withdrawKey);
final Finder qrCoderFinder = find.byKey(qrCoderKey);
final Finder historyFinder = find.byKey(historyKey);
final Finder requestFinder = find.byKey(requestKey);
final Finder billFinder = find.byKey(billKey);
final Finder giftFinder = find.byKey(giftKey);
final Finder savingFinder = find.byKey(savingKey);
final Finder budgetFinder = find.byKey(budgetKey);

/// home => Cards
final Finder moreCardsFinder = find.byKey(moreCardsKey);
final Finder viewMoreCardsFinder = find.byKey(viewMoreCardsKey);
final Finder addCardFinder = find.byKey(addCardKey);
final Finder cardNumberTextFieldFinder = find.byKey(cardNumberTextFieldKey);
final Finder nameOnCardTextFieldFinder = find.byKey(nameOnCardTextFieldKey);
final Finder cvvTextFieldFinder = find.byKey(cvvTextFieldKey);
final Finder dateTextFieldFinder = find.byKey(dateTextFieldKey);
final Finder confirmAddCardButtonFinder = find.byKey(confirmAddCardButtonKey);
final Finder deleteCardButtonFinder = find.byKey(deleteCardButtonKey);
final Finder cardsListFinder = find.byKey(cardsListKey);
final Finder confirmDateFinder = find.byKey(confirmDateKey);

/// Saving
final Finder addNewRoleButtonFinder = find.byKey(addNewRoleButtonKey);
final Finder fromTextFieldSavingFinder = find.byKey(fromSavingKey);
final Finder toTextFieldSavingFinder = find.byKey(toSavingKey);
final Finder saveTextFieldSavingFinder = find.byKey(saveSavingKey);
final Finder savingLoadingButtonFinder = find.byKey(savingLoadingButtonKey);
final Finder savingBottomSheetListFinder = find.byKey(savingBottomSheetListKey);
final Finder popupRoleSavingFinder = find.byKey(popupRoleSavingKey);
final Finder deleteRoleButtonFinder = find.byKey(deleteRoleButtonKey);
final Finder toggleRoleButtonFinder = find.byKey(toggleRoleButtonKey);
final Finder updateRoleButtonFinder = find.byKey(updateRoleButtonKey);
final Finder investingSavingFinder = find.byKey(investingSavingKey);
final Finder depositSavingFinder = find.byKey(depositSavingKey);
final Finder withdrawSavingFinder = find.byKey(withdrawSavingKey);
final Finder amountSavingTextFieldFinder = find.byKey(amountSavingTextFieldKey);
final Finder savingListFinder = find.byKey(savingListKey);
final Finder activationToggleFinder = find.byKey(activationToggleKey);

/// Change password
final Finder oldPasswordTextFieldKeFinder = find.byKey(oldPasswordTextFieldKey);
final Finder newPasswordTextFieldKeFinder = find.byKey(newPasswordTextFieldKey);
final Finder confirmNewPasswordTextFieldKeFinder =
    find.byKey(confirmNewPasswordTextFieldKey);
final Finder confirmChangePasswordButtonFinder =
    find.byKey(confirmChangePasswordButtonKey);
final Finder changePasswordListFinder = find.byKey(changePasswordListKey);
final Finder showPasswordFinder = find.byKey(showPasswordIconKey);

///Terms
final Finder termsListTileFinder = find.byKey(termsListTileKey);

/// privacy
final Finder privacyListTileFinder = find.byKey(privacyListTileKey);

/// change language
final Finder englishRadioButtonFinder = find.byKey(englishRadioButtonKey);
final Finder arabicRadioButtonFinder = find.byKey(arabicRadioButtonKey);
final Finder changeLanguageConfirmButtonFinder =
    find.byKey(changeLanguageConfirmButtonKey);

/// Shipping Location
final Finder confirmAddAddressButtonFinder =
    find.byKey(confirmAddAddressButtonKey);
final Finder addNewAddressFinder = find.byKey(addNewAddressKey);
final Finder shippingLocationListFinder = find.byKey(shippingLocationListKey);
final Finder postalCodeTextFieldFinder = find.byKey(postalCodeTextFieldKey);
final Finder stateTextFieldFinder = find.byKey(stateTextFieldKey);
final Finder houseNumberTextFieldFinder = find.byKey(houseNumberTextFieldKey);
final Finder streetNameTextFieldFinder = find.byKey(streetNameTextFieldKey);
final Finder firstCityFinder = find.byKey(firstCityKey);
final Finder defaultAddressCheckBoxFinder =
    find.byKey(defaultAddressCheckBoxKey);
final Finder deleteAddressFinder = find.byKey(deleteAddressKey);

/// Budget
final Finder budgetFilterDropdownFinder = find.byKey(budgetFilterDropdownKey);
final Finder addNewBudgetButtonFinder = find.byKey(addNewBudgetButtonKey);
final Finder createBudgetButtonFinder = find.byKey(createBudgetCategoryKey);
final Finder amountTextfieldFinder = find.byKey(amountTextFieldKey);
final Finder openBudgetCategoriesSheetFinder =
    find.byKey(openCategoriesSheetButtonKey);
final Finder deleteBudgetButtonFinder = find.byKey(deleteBudgetButtonKey);
final Finder toggleBudgetSwitchFinder = find.byKey(toggleBudgetSwitchKey);
final Finder editBudgetCategoryButtonFinder =
    find.byKey(editBudgetCategoryButtonKey);
final Finder budgetScrollViewFinder = find.byKey(budgetScrollView);

/// transfer
final Finder transferAddBeneficiaryButtonFinder =
    find.byKey(transferAddBeneficiaryButtonKey);
final Finder resAppTransferTypeFromBottomSheetFinder =
    find.byKey(resAppTransferTypeFromBottomSheetKey);
final Finder resAppInternalTransferTypeFromBottomSheetFinder =
    find.byKey(resAppInternalTransferTypeFromBottomSheetKey);
final Finder westernTransferTypeFromBottomSheetFinder =
    find.byKey(westernTransferTypeFromBottomSheetKey);
final Finder eWalletTypeFromBottomSheetFinder =
    find.byKey(eWalletTypeFromBottomSheetKey);
final Finder eWalletInternalTypeFromBottomSheetFinder =
    find.byKey(eWalletInternalTypeFromBottomSheetKey);
final Finder bankAccountTypeFromBottomSheetFinder =
    find.byKey(bankAccountTypeFromBottomSheetKey);
final Finder bankAccountInternalTypeFromBottomSheetFinder =
    find.byKey(bankAccountInternalTypeFromBottomSheetKey);
final Finder giftInternalTypeFromBottomSheetFinder =
    find.byKey(giftInternalTypeFromBottomSheetKey);

final Finder countriesDropdownListFinder = find.byKey(countriesDropdownListKey);
final Finder citiesDropdownListFinder = find.byKey(citiesDropdownListKey);
final Finder currenciesDropdownListFinder =
    find.byKey(currenciesDropdownListKey);
final Finder relationShipsDropdownListFinder =
    find.byKey(relationShipsDropdownListKey);
final Finder purposeDropDownListFinder = find.byKey(purposeDropDownListKey);
final Finder categoriesDropDownListFinder =
    find.byKey(categoriesDropDownListKey);
final Finder walletNamesDropDownListFinder =
    find.byKey(walletNamesDropDownListKey);
final Finder nationalityDropDownListFinder =
    find.byKey(nationalityDropDownListKey);
final Finder bankNamesDropDownListFinder = find.byKey(bankNamesDropDownListKey);

final Finder countryItemInCountriesDropdownListFinder =
    find.byKey(countryItemInCountriesDropdownListKey);
final Finder currencyItemInCurrenciesDropdownListFinder =
    find.byKey(currencyItemInCurrenciesDropdownListKey);
final Finder nationalityItemInCurrenciesDropdownListFinder =
    find.byKey(nationalityItemInCurrenciesDropdownListKey);
final Finder relationShipItemInDropdownListFinder =
    find.byKey(relationShipItemInDropdownListKey);
final Finder purposeItemForTransferFinder =
    find.byKey(purposeItemForTransferKey);

final Finder firstNameTextFieldFinder = find.byKey(firstNameTextFieldKey);
final Finder lastNameTextFieldFinder = find.byKey(lastNameTextFieldKey);
final Finder phoneNumberTextFieldFinder = find.byKey(phoneNumberTextFieldKey);
final Finder accountNumberTextFieldFinder =
    find.byKey(accountNumberTextFieldKey);
final Finder swiftCodeTextFieldFinder = find.byKey(swiftCodeTextFieldKey);
final Finder iBANTextFieldFinder = find.byKey(iBANTextFieldKey);
final Finder scanBarCodeFinder = find.byKey(scanBarCodeKey);
final Finder transactionAmountTextFieldFinder =
    find.byKey(transactionAmountTextFieldKey);
final Finder noteTextFieldFinder = find.byKey(noteTextFieldKey);

final Finder transferDetailsLoadingButtonFinder =
    find.byKey(transferDetailsLoadingButtonKey);
final Finder continueLoadingButtonFinder = find.byKey(continueLoadingButtonKey);
final Finder callMeNowButtonFinder = find.byKey(callMeNowButtonKey);
final Finder makeTransferButtonFinder = find.byKey(makeTransferButtonKey);
final Finder makeTransferContinueButtonFinder =
    find.byKey(makeTransferContinueButtonKey);
final Finder newTransferSummaryConfirmButtonFinder =
    find.byKey(newTransferSummaryConfirmButtonKey);
final Finder viewEReceiptFinder = find.byKey(viewEReceiptKey);
final Finder backToHomeDialogFinder = find.byKey(backToHomeDialogKey);

///request
final Finder requestAddBeneficiaryButtonFinder =
    find.byKey(requestAddBeneficiaryButtonKey);
final Finder addRequestBeneficiaryContinueButtonFinder =
    find.byKey(addRequestBeneficiaryContinueButtonKey);
final Finder beneficiaryItemButtonFinder = find.byKey(beneficiaryItemButtonKey);
final Finder requestAmountContinueButtonFinder =
    find.byKey(requestAmountContinueButtonKey);

/// gift
final Finder giftAddBeneficiaryButtonFinder =
    find.byKey(giftAddBeneficiaryButtonKey);
final Finder addGiftBeneficiaryContinueButtonFinder =
    find.byKey(addGiftBeneficiaryContinueButtonKey);
final Finder sendGiftContinueButtonFinder =
    find.byKey(sendGiftContinueButtonKey);

final Finder giftTitleTextFieldFinder = find.byKey(giftTitleTextFieldKey);
final Finder recipientNameTextFieldFinder =
    find.byKey(recipientNameTextFieldKey);
final Finder sendGiftTapFinder = find.byKey(sendGiftTapKey);
final Finder receivedGitsTapFinder = find.byKey(receivedGiftsTapKey);

/// history
final Finder historySearchButtonFinder = find.byKey(historySearchButtonKey);
final Finder historySearchTextFieldFinder = find.byKey(searchTextFieldKey);
final Finder searchClearTextFieldButtonFinder =
    find.byKey(searchClearTextFieldButtonKey);
final Finder historyCategoryFilterFinder = find.byKey(historyCategoryFilterKey);
final Finder historyDurationFilterFinder = find.byKey(historyDurationFilterKey);
final Finder periodDropdownFinder = find.byKey(periodDropdownKey);
final Finder clearPeriodButtonFinder = find.byKey(clearPeriodButtonKey);
final Finder selectHistoryPeriodFromButtonFinder =
    find.byKey(selectHistoryPeriodFromButtonKey);
final Finder clearFromDateButtonFinder = find.byKey(clearFromDateButtonKey);
final Finder selectHistoryPeriodToButtonFinder =
    find.byKey(selectHistoryPeriodToButtonKey);
final Finder clearToDateButtonFinder = find.byKey(clearToDateButtonKey);
final Finder sheetApplyButtonFinder = find.byKey(sheetApplyButtonKey);
final Finder sheetCancelButtonFinder = find.byKey(sheetCancelButtonKey);
final Finder datePickedButtonFinder = find.byKey(datePickedButtonKey);

/// support
final Finder emailTextFieldFinder = find.byKey(emailTextFieldKey);
final Finder supportMessageTextFieldFinder =
    find.byKey(supportMessageTextFieldKey);
final Finder sendButtonFinder = find.byKey(sendButtonKey);
final Finder sendIssueScrollListFinder = find.byKey(sendIssueScrollList);

/// profile
final Finder goToProfileInfoButtonFinder = find.byKey(goToProfileInfoButtonKey);
final Finder editProfileButtonFinder = find.byKey(editProfileButtonKey);
final Finder cancelProfileButtonFinder = find.byKey(cancelProfileButtonKey);
final Finder saveChangesProfileButtonFinder =
    find.byKey(saveChangesProfileButtonKey);
final Finder changeProfileImageButtonFinder =
    find.byKey(changeProfileImageButtonKey);
final Finder cameraIconButtonFinder = find.byKey(cameraIconButtonKey);

final Finder profileFullNameTextFieldFinder =
    find.byKey(profileFullNameTextFieldKey);
final Finder profilePhoneNumberTextFieldFinder =
    find.byKey(profilePhoneNumberTextFieldKey);
final Finder profileEmailTextFieldFinder = find.byKey(profileEmailTextFieldKey);
final Finder profileIdTextFieldFinder = find.byKey(profileIdTextFieldKey);
final Finder profileBirthDateTextFieldFinder =
    find.byKey(profileBirthDateTextFieldKey);

/// Deposit
final Finder chooseDepositCardButtonFinder =
    find.byKey(chooseDepositCardButtonKey);
final Finder depositViaCreditCardFinder = find.byKey(depositViaCreditCardKey);
final Finder addNewCreditCardKeyButtonFinder =
    find.byKey(addNewCreditCardButtonKey);
final Finder depositViaScrollViewFinder = find.byKey(depositViaScrollViewKey);
final Finder depositSubmitButtonFinder = find.byKey(depositSubmitButtonKey);

/// cart
final Finder shopItemFinder = find.byKey(shopItemKey);
final Finder shopScrollFinder = find.byKey(shopScrollKey);
final Finder firstProductItemFinder = find.byKey(firstProductItemKey);
final Finder secondProductItemFinder = find.byKey(secondProductItemKey);
final Finder favouriteIconProductItemFinder =
    find.byKey(favouriteIconProductItemKey);
final Finder addToCartFinder = find.byKey(addToCartKey);
final Finder removeItemFromCartFinder = find.byKey(removeItemFromCartKey);
final Finder cartIconInAppBarFinder = find.byKey(cartIconInAppBarKey);
final Finder favouriteIconInAppBarFinder = find.byKey(favoriteIconInAppBarKey);
final Finder incrementButtonInCartListFinder =
    find.byKey(incrementButtonKeyInCartList);
final Finder decrementButtonInCartListFinder =
    find.byKey(decrementButtonKeyInCartList);
final Finder shopProductsScrollFinder = find.byKey(shopProductsScrollKey);
final Finder discountCodeTextFieldFinder = find.byKey(discountCodeTextField);
final Finder checkOrRemovePromoCodeButtonFinder =
    find.byKey(checkOrRemovePromoCodeButton);
final Finder checkOutNowButtonFinder = find.byKey(checkOutNowButton);
final Finder showSummaryBottomSheetFinder = find.byKey(showSummaryBottomSheet);
final Finder addressAtFirstIndexFinder = find.byKey(addressAtFirstIndex);
final Finder continueButtonAfterSelectAddressFinder =
    find.byKey(continueButtonAfterSelectAddress);
final Finder selectAddressListFinder = find.byKey(selectAddressListKey);
final Finder addNewAddressWhenNoAddressesFoundFinder =
    find.byKey(addNewAddressWhenNoAddressesFoundKey);
final Finder dropDownItemAtIndex0Finder = find.byKey(dropDownItemAtIndex0);
final Finder firstItemInDropDownItemAtIndex0Finder =
    find.byKey(firstItemInDropDownItemAtIndex0Key);
final Finder dropDownItemAtIndex1Finder = find.byKey(dropDownItemAtIndex1);
final Finder firstItemInDropDownItemAtIndex1Finder =
    find.byKey(firstItemInDropDownItemAtIndex1Key);
final Finder storeDetailSearchProductsFinder =
    find.byKey(storeDetailSearchProductsKey);

/// withdraw
final Finder withdrawAmountText = find.byKey(withdrawText);
final Finder withdrawBankCheck = find.byKey(bankCheckButton);
final Finder withdrawButton = find.byKey(withdrawLoadingButton);
final Finder recipientNameTextButton = find.byKey(recipientNameTextKey);
final Finder accountNumberTextButton = find.byKey(accountNumberTextKey);
final Finder ibanTextFieldKeyTextButton = find.byKey(ibanTextFieldKeyTextKey);
final Finder withdrawAddAccountButton = find.byKey(withdrawAddAccountKey);
final Finder withdrawAddNewAccountButton = find.byKey(withdrawAddNewAccountKey);

/// receipt screen
final Finder closeScreenButton = find.byKey(closeButtonKey);
final Finder getPdfButtonFinder = find.byKey(getPdfButtonKey);
final Finder getImageButtonFinder = find.byKey(getImageButtonKey);
final Finder openDownloadReceiptSheetFinder =
    find.byKey(openDownloadReceiptSheetKey);

/// orders
final Finder ordersIconFinder = find.byKey(ordersIconKey);
final Finder orderSearchTextFieldFinder = find.byKey(orderSearchTextFieldKey);
final Finder viewOrderDetailsButtonFinder =
    find.byKey(viewOrderDetailsButtonKey);
final Finder buyAgainButtonFinder = find.byKey(buyAgainButtonKey);
final Finder complainButtonFinder = find.byKey(complainButtonKey);
final Finder cancelOrderButtonFinder = find.byKey(cancelOrderButtonKey);
final Finder orderDetailsScrollViewFinder =
    find.byKey(orderDetailsScrollViewKey);
final Finder descriptionTextfieldFinder = find.byKey(descriptionTextfieldKey);
final Finder complainOrderReasonFinder = find.byKey(complainReasonKey);

/// pay Bill
final Finder selectCompanyFinder = find.byKey(selectCompanyKey);
final Finder customerIdFinder = find.byKey(customerIdKey);
final Finder seeBillFinder = find.byKey(seeBillKey);
final Finder payNowFinder = find.byKey(payNowKey);

/// schedule time
final Finder selectDayFinder = find.byKey(selectDayKey);
final Finder selectTimeFinder = find.byKey(selectTimeKey);
final Finder setCallFinder = find.byKey(setCallKey);
final Finder goBackToMore = find.byKey(goBackKey);

/// customer Loyalty
final Finder selectItemFinder = find.byKey(selectItemKey);
final Finder selectRateFinder = find.byKey(selectRateKey);
final Finder redeemFinder = find.byKey(redeemKey);
final Finder dialogFinder = find.byKey(dialogKey);

/// referral
final Finder referralIconFinder = find.byKey(referralIconKey);
final Finder referralsTapFinder = find.byKey(referralsTapKey);
final Finder inviteFriendTapFinder = find.byKey(inviteFriendTapKey);
final Finder copyReferralLinkFinder = find.byKey(copyReferralLinkKey);
final Finder othersReferralLinkFinder = find.byKey(othersReferralLinkKey);

/// FAQs
final Finder faqsTapFinder = find.byKey(faqsTapKey);
final Finder faqSearchTextFieldFinder = find.byKey(faqSearchTextFieldKey);

/// shop
final Finder shopCategoryFinder = find.byKey(shopCategoryKey);
final Finder firstShopCategoryFinder = find.byKey(firstShopCategoryKey);

/// promotions
final Finder firstPromoCodeFinder = find.byKey(firstPromoCodeKey);
final Finder searchIconFinder = find.byKey(searchIconKey);
final Finder promotionItemFinder = find.byKey(promotionItemKey);

/// celebrity
final Finder celebritySearchInkwellFinder = find.byKey(celebritySearchInkwell);
final Finder celebrityWidgetFinder = find.byKey(celebrityWidgetKey);
final Finder storiesButtonFinder = find.byKey(storiesButtonKey);
final Finder storiesPageViewFinder = find.byKey(storiesPageViewKey);
final Finder bookmarkedStoriesFinder = find.byKey(bookmarkedStoriesKey);
final Finder likedStoriesFinder = find.byKey(likedStoriesKey);

/// loading
Finder loadingFinder = find.byKey(loadingKey);
