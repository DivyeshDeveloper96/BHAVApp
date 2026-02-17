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

  /// Page token for pagination (instead of page number)
  var nextPageToken = ''.obs;

  /// Flag to determine if using token-based pagination
  bool useTokenPagination = false;

  /// Fetch method for page-based pagination
  Future<List<T>> fetchPage(int page, String query);

  /// Fetch method for token-based pagination
  /// Returns a map with 'items' and 'nextPageToken'
  Future<Map<String, dynamic>> fetchPageWithToken(String? pageToken, String query) async {
    throw UnimplementedError('Override fetchPageWithToken when useTokenPagination is true');
  }

  void loadInitial() {
    page = 1;
    nextPageToken.value = '';
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
      if (useTokenPagination) {
        // Token-based pagination
        final response = await fetchPageWithToken(
          nextPageToken.value.isEmpty ? null : nextPageToken.value,
          searchQuery.value,
        );

        final List<T> newItems = response['items'] as List<T>;
        items.addAll(newItems);

        // Update next page token
        nextPageToken.value = response['nextPageToken'] ?? '';

        // Check if there are more items
        if (nextPageToken.value.isEmpty || newItems.isEmpty) {
          hasMore.value = false;
        }
      } else {
        // Traditional page-based pagination
        final newItems = await fetchPage(page, searchQuery.value);
        items.addAll(newItems);
        page++;
        if (newItems.length < pageSize) hasMore.value = false;
      }
    } catch (e) {
      isError.value = true;
      print('Error loading more: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _loadAll() async {
    if (isLoading.value) return;

    isLoading.value = true;
    isError.value = false;

    try {
      if (useTokenPagination) {
        // Load all with token pagination
        final response = await fetchPageWithToken(null, searchQuery.value);
        final List<T> allItems = response['items'] as List<T>;
        items.assignAll(allItems);
        nextPageToken.value = response['nextPageToken'] ?? '';
      } else {
        // Traditional load all
        final allItems = await fetchPage(1, searchQuery.value);
        items.assignAll(allItems);
      }
      hasMore.value = false;
    } catch (e) {
      isError.value = true;
      print('Error loading all: $e');
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

    // If query length < 3, do not perform search
    if (trimmed.length < 3) {
      return;
    }

    // For queries with length >= 3 perform search
    searchQuery.value = trimmed;
    loadInitial();
  }

  @override
  void onInit() {
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