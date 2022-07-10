import 'package:financial_terms/components/a_delegate.dart';
import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:financial_terms/models/finance_term.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({
    Key? key,
    this.id = 1,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late PageController _pageController;
  final double _minExtent = 80.0;
  final double _maxExtent = 175.0;

  double _i = 0.0;

  final termsController = Get.find<TermsController>();

  @override
  void initState() {
    super.initState();
    final i = termsController.indexById(widget.id);
    _pageController = PageController(initialPage: i);

    _pageController.addListener(_pageChaneListener);
  }

  void _pageChaneListener() {
    setState(() {
      _i = _pageController.page ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: termsController.terms.length,
        itemBuilder: (_, i) {
          final financeTerm = termsController.terms[i];

          final List<String> desc =
              financeTerm.body!.replaceAll("i.e.", "______").split(". ");

          if (_i == 0) {
            return _layoutBuilder(financeTerm, desc, theme);
          }

          return Transform(
            transform: Matrix4.identity()
              ..rotateX(_i - i)
              ..rotateY(_i - i),
            child: _layoutBuilder(financeTerm, desc, theme),
          );
        },
      ),
    );
  }

  CustomScrollView _layoutBuilder(
      FinanceTerm financeTerm, List<String> desc, ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: AFlexiblePersistentHeader(
            builder: (
              _,
              shrinkOffset,
              overlapsContent,
            ) {
              final progress = 1 - (shrinkOffset / _maxExtent);
              return FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: FinancialTermsAppTheme.paddingXXXLarge,
                          left: FinancialTermsAppTheme.paddingXXXSmall,
                          bottom: FinancialTermsAppTheme.paddingXSmall,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          padding: EdgeInsets.all(
                              FinancialTermsAppTheme.paddingXSmall),
                          splashRadius: 24.0,
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: theme.iconTheme.color,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.lerp(
                                      EdgeInsets.only(
                                        left: FinancialTermsAppTheme
                                                .paddingXXXLarge +
                                            FinancialTermsAppTheme.paddingLarge,
                                        bottom: FinancialTermsAppTheme
                                                .paddingSmall +
                                            FinancialTermsAppTheme
                                                .paddingXXSmall,
                                      ),
                                      EdgeInsets.only(
                                        left:
                                            FinancialTermsAppTheme.paddingLarge,
                                        bottom:
                                            FinancialTermsAppTheme.paddingSmall,
                                      ),
                                      progress) ??
                                  EdgeInsets.zero,
                              child: ShaderMask(
                                blendMode: BlendMode.srcATop,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      theme.primaryColor,
                                      theme.colorScheme.secondary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  "${financeTerm.title}",
                                  style: GoogleFonts.jost(
                                    fontWeight: FontWeight.lerp(
                                      FontWeight.w500,
                                      FontWeight.w400,
                                      progress,
                                    ),
                                    color: theme.textTheme.titleMedium?.color,
                                    height: 1.0,
                                    fontSize: 18.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: 1 + progress,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            minHeight: _minExtent,
            maxHeight: _maxExtent,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FinancialTermsAppTheme.paddingLarge,
                vertical: FinancialTermsAppTheme.paddingMedium,
              ),
              child: Text(
                "${desc[index].trim().replaceAll("______", "i.e.")}${index < desc.length - 1 ? '.' : ''}",
                style: GoogleFonts.jost(height: 1.75, fontSize: 16.0),
              ),
            ),
            childCount: desc.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: FinancialTermsAppTheme.paddingXXXLarge,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageChaneListener);
    _pageController.dispose();
    super.dispose();
  }
}
