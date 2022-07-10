import 'package:financial_terms/components/a_delegate.dart';
import 'package:financial_terms/components/a_loading_indicator.dart';
import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/controllers/connectivity_controller.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:financial_terms/models/finance_term.dart';
import 'package:financial_terms/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/a_button.dart';
import '../config/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _minExtent = 80.0;
  final double _maxExtent = 200.0;
  late TextEditingController _searchController;

  final termsController = Get.find<TermsController>();
  final connectivity = Get.find<ConnectivityController>();

  final _hints = <String>[
    "Dividend",
    "Share",
    "Financial Management",
    "Assets",
    "Balance Sheet",
    "Financial Accounting",
    "Ad-hoc Audit",
    "Arbitration",
  ];

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

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
                  "${termsController.networkResponse?.message}",
                  style: GoogleFonts.arsenal(fontSize: 20.0),
                ),
                AButton(
                  onPressed: () async {
                    if (!connectivity.hasInternet) {
                      Get.showSnackbar(
                        GetSnackBar(
                          messageText: Text(
                            "No Internet Connection!!",
                            style: GoogleFonts.jost(
                              fontSize: 16.0,
                              color: theme.textTheme.caption?.color,
                            ),
                          ),
                          duration: const Duration(
                            milliseconds: 2000,
                          ),
                          backgroundColor: theme.primaryColor.withOpacity(0.10),
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
                  labelStyle: GoogleFonts.jost(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          );
        }

        final labeledTerms = termsController.labeledTerms;
        _hints.shuffle();

        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: AFlexiblePersistentHeader(
                  builder: (_, shrinkOffset, overlapping) {
                    final progress = shrinkOffset / _maxExtent;

                    return Padding(
                      padding: EdgeInsets.lerp(
                            EdgeInsets.only(
                              right: FinancialTermsAppTheme.paddingSmall,
                            ),
                            EdgeInsets.only(
                              left: FinancialTermsAppTheme.paddingLarge * 3.25,
                              right: FinancialTermsAppTheme.paddingSmall,
                            ),
                            1 - progress,
                          ) ??
                          EdgeInsets.zero,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  theme.primaryColor,
                                  theme.colorScheme.secondary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: Text(
                              "Financial Terms",
                              style: GoogleFonts.jost(
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: 1 - progress,
                            ),
                          ),
                          SizedBox(
                            height: (1 - progress) *
                                FinancialTermsAppTheme.paddingXLarge,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(
                                  (1 - progress) *
                                      (theme.light ? 0.075 : 0.35)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "e.g. ${_hints.first}",
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                              ),
                              style: GoogleFonts.jost(),
                              textInputAction: TextInputAction.search,
                              onChanged: termsController.filterTerms,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  minHeight: _minExtent,
                  maxHeight: _maxExtent),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: FinancialTermsAppTheme.paddingLarge * 2.0,
              ),
            ),
            if (labeledTerms.isNotEmpty)
              ...labeledTerms
                  .map((e) => _StickyHeaderSliverList(fTerms: e))
                  .toList()
            else
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height - _maxExtent * 2,
                  child: Center(
                    child: Text(
                      "Sorry, No Results found!!",
                      style: GoogleFonts.jost(
                        fontSize: 16.0,
                        color: theme.textTheme.caption?.color,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

/// Sticky Header Sliver List
class _StickyHeaderSliverList extends StatelessWidget {
  const _StickyHeaderSliverList({
    Key? key,
    required this.fTerms,
  }) : super(key: key);
  final FinanceTerms fTerms;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      overlapsContent: true,
      header: _SideHeader(label: fTerms.label),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(left: 40.0, bottom: 40.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              (__, index) => Padding(
                    padding: EdgeInsets.only(
                      left: FinancialTermsAppTheme.paddingLarge,
                      right: FinancialTermsAppTheme.paddingXXSmall,
                      top: FinancialTermsAppTheme.paddingXXSmall,
                      bottom: FinancialTermsAppTheme.paddingXXSmall,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.details,
                            arguments: fTerms.terms[index].id);
                      },
                      child: Ink(
                        padding: EdgeInsets.only(
                          left: FinancialTermsAppTheme.paddingXSmall,
                          right: FinancialTermsAppTheme.paddingMedium,
                          top: FinancialTermsAppTheme.paddingMedium,
                          bottom: FinancialTermsAppTheme.paddingMedium,
                        ),
                        child: Text(
                          "${fTerms.terms[index].title}",
                          style: GoogleFonts.jost(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
              childCount: fTerms.count),
        ),
      ),
    );
  }
}

/// Sticky Header
class _SideHeader extends StatelessWidget {
  const _SideHeader({
    Key? key,
    this.label,
  }) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 60.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RotatedBox(
          quarterTurns: 3,
          child: InkWell(
            onTap: () {},
            child: Ink(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              width: 34.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.secondary.withOpacity(0.75),
                    theme.primaryColor.withOpacity(0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  "$label".toUpperCase(),
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
