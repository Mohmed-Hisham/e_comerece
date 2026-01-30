import 'dart:async';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurProductsSearchController extends GetxController {
  late LocalProductRepoImpl _localProductRepo;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // Search suggestions
  List<LocalProductModel> suggestions = [];
  Statusrequest suggestionsStatus = Statusrequest.none;

  // Search results
  List<LocalProductModel> searchResults = [];
  Statusrequest searchStatus = Statusrequest.none;
  bool hasMore = true;
  int _page = 1;
  static const int _pageSize = 10;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  // Debounce timer
  Timer? _debounceTimer;

  // Scroll controller for pagination
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _localProductRepo = LocalProductRepoImpl(apiService: Get.find());

    // Auto focus on search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    // Listen to scroll for pagination
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    searchController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      loadMoreResults();
    }
  }

  // Called when text changes - for suggestions
  void onSearchChanged(String query) {
    _debounceTimer?.cancel();

    if (query.length < 2) {
      suggestions.clear();
      suggestionsStatus = Statusrequest.none;
      update(['suggestions']);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _fetchSuggestions(query);
    });
  }

  // Fetch suggestions
  Future<void> _fetchSuggestions(String query) async {
    suggestionsStatus = Statusrequest.loading;
    update(['suggestions']);

    final result = await _localProductRepo.searchProducts(
      query: query,
      page: 1,
      pageSize: 6,
    );

    result.fold(
      (failure) {
        suggestionsStatus = Statusrequest.failuer;
      },
      (response) {
        suggestions = response.products ?? [];
        suggestionsStatus = suggestions.isEmpty
            ? Statusrequest.noData
            : Statusrequest.success;
      },
    );

    update(['suggestions']);
  }

  // Execute full search
  Future<void> executeSearch() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    focusNode.unfocus();
    suggestions.clear();
    suggestionsStatus = Statusrequest.none;

    searchStatus = Statusrequest.loading;
    _page = 1;
    hasMore = true;
    searchResults.clear();
    update(['search', 'suggestions']);

    final result = await _localProductRepo.searchProducts(
      query: query,
      page: _page,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        searchStatus = Statusrequest.failuer;
      },
      (response) {
        searchResults = response.products ?? [];
        hasMore = response.hasMore;
        searchStatus = searchResults.isEmpty
            ? Statusrequest.noData
            : Statusrequest.success;
      },
    );

    update(['search']);
  }

  // Load more search results
  Future<void> loadMoreResults() async {
    if (_isLoadingMore || !hasMore || searchStatus != Statusrequest.success) {
      return;
    }

    _isLoadingMore = true;
    _page++;
    update(['search']);

    final result = await _localProductRepo.searchProducts(
      query: searchController.text.trim(),
      page: _page,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        _page--;
      },
      (response) {
        if (response.products != null && response.products!.isNotEmpty) {
          searchResults.addAll(response.products!);
          hasMore = response.hasMore;
        } else {
          hasMore = false;
        }
      },
    );

    _isLoadingMore = false;
    update(['search']);
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    suggestions.clear();
    searchResults.clear();
    suggestionsStatus = Statusrequest.none;
    searchStatus = Statusrequest.none;
    _page = 1;
    hasMore = true;
    update(['search', 'suggestions']);
    focusNode.requestFocus();
  }

  // Select suggestion
  void selectSuggestion(LocalProductModel product) {
    searchController.text = product.title ?? '';
    executeSearch();
  }

  // Check if showing suggestions
  bool get showSuggestions =>
      searchController.text.length >= 2 &&
      searchStatus != Statusrequest.success;
}
