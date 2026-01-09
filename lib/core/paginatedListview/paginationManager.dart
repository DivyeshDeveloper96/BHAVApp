
import 'package:bhavapp/core/paginatedListview/basePaginatedController.dart';

class PaginationManager<T> extends BasePaginatedController<T> {
  final Future<List<T>> Function(int page, String query) fetchPageCallback;

  int _page = 1;

  PaginationManager({required this.fetchPageCallback});

  @override
  Future<List<T>> fetchPage(int page, String query) {
    return fetchPageCallback(page, query);
  }

  @override
  void loadInitial() {
    _page = 1;
    items.clear();
    hasMore.value = true;
    loadMore();
  }

  @override
  void loadMore() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    isError.value = false;

    try {
      final newItems = await fetchPage(_page, searchQuery.value);
      print("📦 Page $_page fetched ${newItems.length} items");
      items.addAll(newItems); // this.items comes from BasePaginatedController
      _page++;
      if (newItems.length < pageSize) hasMore.value = false;
    } catch (_) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void retry() => loadMore();

  @override
  void onSearch(String query) {
    searchQuery.value = query;
    loadInitial();
  }
}
