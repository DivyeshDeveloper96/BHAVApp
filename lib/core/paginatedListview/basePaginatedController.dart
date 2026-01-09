import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/Base/BaseController.dart';

abstract class BasePaginatedController<T> extends BaseController {
  var items = <T>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var hasMore = true.obs;
  var page = 1;

  var searchQuery = ''.obs;
  int pageSize = 10;

  final TextEditingController searchController = TextEditingController();

  /// Mutable flag for enabling/disabling pagination
  bool isPaginationEnabled = true;

  Future<List<T>> fetchPage(int page, String query);

  void loadInitial() {
    page = 1;
    items.clear();
    hasMore.value = true;
    if (isPaginationEnabled) {
      loadMore();
    } else {

      _loadAll();
    }
  }

  void loadMore() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    isError.value = false;

    try {
      final newItems = await fetchPage(page, searchQuery.value);
      items.addAll(newItems);
      page++;
      if (newItems.length < pageSize) hasMore.value = false;
    } catch (_) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void _loadAll() async {
    if (isLoading.value) return;

    isLoading.value = true;
    isError.value = false;

    try {
      final allItems = await fetchPage(1, searchQuery.value);
      items.assignAll(allItems);
      hasMore.value = false;
    } catch (_) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    if (isPaginationEnabled) {
      loadMore();
    } else {
      _loadAll();
    }
  }

  void onSearch(String query) {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      searchQuery.value = '';
      loadInitial();
      return;
    }

    // If query length < 3, do not perform search (you can debounce or wait)
    if (trimmed.length < 3) {
      // keep the typed text in searchController (listener already does this),
      // but don't change the shown result set yet.
      // <<< NOTE: if you prefer clearing results for <3, call loadInitial() here.
      return;
    }

    // For queries with length >= 3 perform search
    searchQuery.value = trimmed;
    loadInitial();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    loadInitial();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    loadInitial();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
