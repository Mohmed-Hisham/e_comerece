import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CurrencySelectionDialog extends StatefulWidget {
  const CurrencySelectionDialog({super.key});

  @override
  State<CurrencySelectionDialog> createState() =>
      _CurrencySelectionDialogState();
}

class _CurrencySelectionDialogState extends State<CurrencySelectionDialog> {
  late String _selectedCurrency;
  final CurrencyService _currencyService = Get.find<CurrencyService>();

  @override
  void initState() {
    super.initState();
    _selectedCurrency = _currencyService.selectedCurrency;
  }

  final Map<String, Map<String, String>> _currencyInfo = {
    'USD': {'name': 'US Dollar', 'symbol': '\$'},
    'SAR': {'name': 'Saudi Riyal', 'symbol': 'SAR'},
    'AED': {'name': 'UAE Dirham', 'symbol': 'AED'},
    'YER': {'name': 'Yemeni Rial', 'symbol': 'YER'},
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringsKeys.selectDisplayCurrency.tr,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.black,
              ),
            ),
            SizedBox(height: 20.h),
            ...(_currencyService.availableCurrencies.map((currency) {
              final isSelected = _selectedCurrency == currency;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedCurrency = currency;
                  });
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Appcolor.primrycolor.withValues(alpha: 0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? Appcolor.primrycolor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Appcolor.primrycolor
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          _currencyInfo[currency]!['symbol']!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Appcolor.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currency,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.black,
                              ),
                            ),
                            Text(
                              _currencyInfo[currency]!['name']!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Appcolor.primrycolor,
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              );
            })),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      StringsKeys.cancel.tr,
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primrycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () async {
                      await _currencyService.setSelectedCurrency(
                        _selectedCurrency,
                      );
                      if (context.mounted) Navigator.pop(context, true);
                    },
                    child: Text(
                      StringsKeys.confirm.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showCurrencySelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CurrencySelectionDialog(),
  );
}
