import 'package:financial_terms/components/a_card.dart';
import 'package:financial_terms/components/a_loading_indicator.dart';
import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/config/routes.dart';
import 'package:financial_terms/controllers/connectivity_controller.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/a_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final termsController = Get.find<TermsController>();
  final connectivity = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Obx(() {
        final loading = termsController.fetchingTerms;
        final terms = termsController.terms;

        if (loading) {
          return const ALoadingIndicator(
            label: "Fetching data...",
            size: 42.0,
            lineWidth: 2.75,
          );
        }

        if (terms.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Something went wrong!!",
                  style: GoogleFonts.arsenal(fontSize: 20.0),
                ),
                AButton(
                  onPressed: () async {
                    if (!connectivity.hasInternet) {
                      Get.showSnackbar(
                        GetSnackBar(
                          messageText: Text(
                            "No Internet Connection!!",
                            style: GoogleFonts.arsenal(
                              fontSize: 16.0,
                            ),
                          ),
                          duration: const Duration(
                            milliseconds: 2000,
                          ),
                          backgroundColor: theme.dividerColor.withOpacity(0.75),
                          margin: EdgeInsets.all(
                              FinancialTermsAppTheme.paddingMedium),
                          borderRadius: FinancialTermsAppTheme.radiusXSmall,
                        ),
                      );
                      return;
                    }

                    await termsController.fetchTerms();
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: FinancialTermsAppTheme.paddingXXLarge,
                    vertical: FinancialTermsAppTheme.paddingSmall,
                  ),
                  margin: EdgeInsets.only(
                    top: FinancialTermsAppTheme.paddingSmall,
                  ),
                  label: "Reload",
                  labelStyle: GoogleFonts.arsenal(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ACard(
                  onClick: () {
                    Get.toNamed(Routes.details, arguments: terms[index]);
                  },
                  margin: EdgeInsets.symmetric(
                    horizontal: FinancialTermsAppTheme.paddingXSmall,
                    vertical: FinancialTermsAppTheme.paddingSmall,
                  ),
                  padding: EdgeInsets.all(
                    FinancialTermsAppTheme.paddingMedium,
                  ),
                  borderRadius: BorderRadius.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${terms[index].id} - ${terms[index].title}",
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Summary --- >${terms[index].summary}.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Author --> ${terms[index].author}"),
                    ],
                  ),
                ),
                childCount: terms.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
