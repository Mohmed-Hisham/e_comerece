import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurProductsController extends GetxController {
  // Repository
  late LocalProductRepoImpl _localProductRepo;

  // Status
  Statusrequest statusRequest = Statusrequest.none;
  Statusrequest searchStatusRequest = Statusrequest.none;

  // Controllers
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  // Data
  List<LocalProductModel> products = [];
  List<LocalProductCategoryModel> categories = [];

  // Pagination
  int _currentPage = 1;
  static const int _pageSize = 10;
  bool hasMore = true;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  // Filters
  String? selectedCategoryId;
  String _searchQuery = '';
  bool _isSearchMode = false;

  bool get showClose => searchController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _localProductRepo = LocalProductRepoImpl(apiService: Get.find());
    _setupScrollListener();
    _fetchCategories();
    fetchProducts();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        loadMore();
      }
    });
  }

  /// Fetch categories from API
  Future<void> _fetchCategories() async {
    // Add "All" category first
    categories = [
      LocalProductCategoryModel(id: null, name: StringsKeys.all.tr),
    ];

    final result = await _localProductRepo.getCategories();
    result.fold(
      (failure) {
        // Keep just the "All" category on failure
      },
      (categoriesList) {
        categories.addAll(categoriesList);
      },
    );
    update(['categories']);
  }

  /// Fetch products from API
  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      hasMore = true;
      products.clear();
    }

    if (!hasMore && !isRefresh) return;

    statusRequest = isRefresh || products.isEmpty
        ? Statusrequest.loading
        : statusRequest;
    update(['products']);

    // Determine which API to call
    final result = await _getProductsFromApi();

    result.fold(
      (failure) {
        if (products.isEmpty) {
          statusRequest = Statusrequest.failuer;
        }
      },
      (response) {
        if (response.products != null) {
          products.addAll(response.products!);
        }
        hasMore = response.hasMore;
        _currentPage++;
        statusRequest = products.isEmpty
            ? Statusrequest.noData
            : Statusrequest.success;
      },
    );

    update(['products']);
  }

  /// Get products based on current filters
  Future<dynamic> _getProductsFromApi() async {
    if (_isSearchMode && _searchQuery.isNotEmpty) {
      return _localProductRepo.searchProducts(
        query: _searchQuery,
        page: _currentPage,
        pageSize: _pageSize,
      );
    } else if (selectedCategoryId != null) {
      return _localProductRepo.getProductsByCategory(
        categoryId: selectedCategoryId!,
        page: _currentPage,
        pageSize: _pageSize,
      );
    } else {
      return _localProductRepo.getProducts(
        page: _currentPage,
        pageSize: _pageSize,
      );
    }
  }

  /// Load more products (pagination)
  Future<void> loadMore() async {
    if (_isLoadingMore || !hasMore) return;

    _isLoadingMore = true;
    update(['products']);
    await fetchProducts();
    _isLoadingMore = false;
    update(['products']);
  }

  /// Refresh products
  Future<void> refreshProducts() async {
    await fetchProducts(isRefresh: true);
  }

  /// Select category
  void selectCategory(String? categoryId) {
    if (selectedCategoryId == categoryId) return;

    selectedCategoryId = categoryId;
    _isSearchMode = false;
    _searchQuery = '';
    searchController.clear();
    update(['categories']);
    fetchProducts(isRefresh: true);
  }

  /// Search products
  void onChangeSearch(String value) {
    _searchQuery = value.trim();
    if (_searchQuery.isEmpty) {
      if (_isSearchMode) {
        _isSearchMode = false;
        fetchProducts(isRefresh: true);
      }
    }
    update();
  }

  void whenstartSearch(String value) {
    // Optional implementation if needed
  }

  /// Execute search
  void onTapSearch() {
    if (_searchQuery.isEmpty) return;

    _isSearchMode = true;
    selectedCategoryId = null;
    fetchProducts(isRefresh: true);
    searchFocusNode.unfocus();
  }

  /// Clear search
  void onCloseSearch() {
    searchController.clear();
    _searchQuery = '';
    if (_isSearchMode) {
      _isSearchMode = false;
      fetchProducts(isRefresh: true);
    }
    update();
  }

  void goTofavorite() {
    Get.toNamed(
      AppRoutesname.favoritealiexpress,
      arguments: {'platform': "LocalProduct"},
    );
  }
}
