import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/models/finance_term.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final FinanceTerm? financeTerm;

  const DetailsPage({
    Key? key,
    required this.financeTerm,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<String> desc =
        widget.financeTerm != null && widget.financeTerm!.body != null
            ? widget.financeTerm!.body!.replaceAll("i.e.", "______").split(". ")
            : [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.all(FinancialTermsAppTheme.paddingXSmall),
              splashRadius: 24.0,
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: theme.iconTheme.color,
                size: 20.0,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.only(
                left: 60.0,
                bottom: FinancialTermsAppTheme.paddingMedium,
                right: FinancialTermsAppTheme.paddingMedium,
              ),
              title: Text(
                "${widget.financeTerm?.title}",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.labelLarge?.color,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
                  "${desc[index].trim().replaceAll("______", "i.e.")}.",
                  style: GoogleFonts.jost(height: 1.75, fontSize: 16.0),
                ),
              ),
              childCount: desc.length,
            ),
          )
        ],
      ),
    );
  }
}
