import 'package:financial_terms/components/a_card.dart';
import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final termsController = Get.find<TermsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Obx(() {
        final loading = termsController.fetchingTerms;
        final terms = termsController.terms;

        if (loading) {
          return const Center(
            child: Text("Loading..."),
          );
        }

        if (terms.isEmpty) {
          return const Center(
            child: Text("No data!!,"),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ACard(
                  onClick: () {},
                  margin: EdgeInsets.symmetric(
                    horizontal: ATheme.paddingXSmall,
                    vertical: ATheme.paddingSmall,
                  ),
                  padding: EdgeInsets.all(
                    ATheme.paddingMedium,
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
