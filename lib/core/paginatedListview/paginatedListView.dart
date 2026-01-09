import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'basePaginatedController.dart';

class PaginatedListView<T> extends StatelessWidget {
  final BasePaginatedController<T> controller;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? noDataWidget;
  final bool useGrid;
  final bool isShowSearch;
  final String? hintText;
  final int gridCrossAxisCount;
  final bool enablePagination;
  final String? noListMessage;
  final String? searchHintText;
  final Widget Function(BuildContext)? shimmerBuilder;

  const PaginatedListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.noDataWidget,
    this.useGrid = false,
    this.gridCrossAxisCount = 2,
    this.isShowSearch = true,
    this.enablePagination = true,
    this.shimmerBuilder,
    this.noListMessage,
    this.searchHintText = "Search",
    this.hintText,
  });

  Future<void> _handleRefresh() async {
    controller.loadInitial();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isShowSearch)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 6,
              top: 6,
            ),
            child: TextField(
              controller: controller.searchController,
              // use persistent controller
              onChanged: (query) {
                controller.onSearch(query); // keep your search behavior
              },
              decoration: InputDecoration(
                hintText: searchHintText ?? "Search",
                contentPadding: EdgeInsets.zero,
                hintStyle:
                    searchHintText != null
                        ? Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorConstant.disabledGrey,
                          fontSize: 11,
                        )
                        : Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorConstant.disabledGrey,
                        ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: Obx(() {
                  final isNotEmpty =
                      (controller.searchQuery.value ?? '').isNotEmpty;
                  return isNotEmpty
                      ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // clear both textfield and reactive state
                          controller.clearSearch();
                        },
                      )
                      : const SizedBox.shrink();
                }),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFBAD5F6), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFBAD5F6), width: 1.5),
                ),
              ),
            ),
          ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value && controller.items.isEmpty) {
              return shimmerBuilder?.call(context) ??
                  const Center(child: CircularProgressIndicator());
            }

            if (controller.isError.value && controller.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Something went wrong'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.retry,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (controller.items.isEmpty) {
              return noDataWidget ?? Center(child: noDataFound());
            }

            int itemCount =
                controller.items.length +
                (enablePagination && controller.hasMore.value ? 1 : 0);

            Widget listView =
                useGrid
                    ? GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: itemCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCrossAxisCount,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        if (index < controller.items.length) {
                          return itemBuilder(context, controller.items[index]);
                        } else {
                          return shimmerBuilder?.call(context) ??
                              const Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                    : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: itemCount,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        if (index < controller.items.length) {
                          return itemBuilder(context, controller.items[index]);
                        } else {
                          return shimmerBuilder?.call(context) ??
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                        }
                      },
                    );

            return RefreshIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              color: Theme.of(context).scaffoldBackgroundColor,
              onRefresh: _handleRefresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      !controller.isLoading.value &&
                      controller.hasMore.value) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: listView,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget noDataFound() {
    final theme =
        Get.context != null ? Theme.of(Get.context!) : ThemeData.light();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Images/no_data_img.webp'),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            noListMessage ?? 'No list found',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor, // Use themed color
            ),
          ),
        ),
      ],
    );
  }
}
