# Local Products API Documentation

## Overview
APIs for browsing and searching locally managed products within the Sltuk application.

**Base URL:** `/api/v1/LocalProduct`

---

## Endpoints

### 1. Get All Categories
Retrieves all active product categories.

**Endpoint:** `GET /categories`

**Response:**
```json
{
  "success": true,
  "message": "Categories retrieved successfully",
  "data": [
    {
      "id": "11111111-1111-1111-1111-111111111111",
      "name": "Electronics",
      "description": "Gadgets, accessories, and electronic devices",
      "image": "https://example.com/electronics.jpg",
      "productCount": 5
    }
  ]
}
```

---

### 2. Get All Products
Retrieves all active products with pagination.

**Endpoint:** `GET /products`

**Query Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | int | 1 | Page number |
| `pageSize` | int | 10 | Items per page (max 50) |

**Example:** `GET /products?page=1&pageSize=10`

**Response:**
```json
{
  "success": true,
  "message": "Products retrieved successfully",
  "data": {
    "products": [
      {
        "id": "a0000001-0000-0000-0000-000000000001",
        "title": "Wireless Bluetooth Earbuds",
        "description": "High-quality wireless earbuds",
        "price": 299.99,
        "discountPrice": 249.99,
        "stockQuantity": 50,
        "mainImage": "https://example.com/earbuds.jpg",
        "images": ["https://example.com/img1.jpg", "https://example.com/img2.jpg"],
        "categoryId": "11111111-1111-1111-1111-111111111111",
        "categoryName": "Electronics"
      }
    ],
    "totalCount": 20,
    "page": 1,
    "pageSize": 10,
    "totalPages": 2
  }
}
```

---

### 3. Get Products by Category
Retrieves products filtered by category ID.

**Endpoint:** `GET /products/category/{categoryId}`

**Path Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `categoryId` | Guid | Category identifier |

**Query Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | int | 1 | Page number |
| `pageSize` | int | 10 | Items per page (max 50) |

**Example:** `GET /products/category/11111111-1111-1111-1111-111111111111?page=1&pageSize=10`

---

### 4. Get Product by ID
Retrieves a single product's full details along with paginated related products from the same category.

**Endpoint:** `GET /products/{productId}`

**Path Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `productId` | Guid | Product identifier |

**Query Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `relatedPage` | int | 1 | Page number for related products |
| `relatedPageSize` | int | 4 | Items per page for related products (max 50) |

**Example:** `GET /products/a0000001-0000-0000-0000-000000000001?relatedPage=1&relatedPageSize=4`

**Response:**
```json
{
  "success": true,
  "message": "Product retrieved successfully",
  "data": {
    "product": {
        "id": "a0000001-0000-0000-0000-000000000001",
        "title": "Wireless Bluetooth Earbuds",
        "description": "High-quality wireless earbuds",
        "price": 299.99,
        "discountPrice": 249.99,
        "stockQuantity": 50,
        "mainImage": "https://example.com/earbuds.jpg",
        "images": ["https://example.com/img1.jpg"],
        "categoryId": "11111111-1111-1111-1111-111111111111",
        "categoryName": "Electronics"
    },
    "relatedProducts": {
        "products": [
            {
                "id": "a0000001-0000-0000-0000-000000000002",
                "title": "Smart Watch",
                ...
            }
        ],
        "totalCount": 4,
        "page": 1,
        "pageSize": 4,
        "totalPages": 1
    }
  }
}
```

---

### 5. Search Products
Searches products by title, description, or category name.

**Endpoint:** `GET /products/search`

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | Search term |
| `page` | int | No | Page number (default: 1) |
| `pageSize` | int | No | Items per page (default: 10, max: 50) |

**Example:** `GET /products/search?query=wireless&page=1&pageSize=10`

---

## Error Responses

All endpoints return the following structure on error:
```json
{
  "success": false,
  "message": "Error description"
}
```

**HTTP Status Codes:**
- `200 OK` - Success
- `400 Bad Request` - Invalid parameters
- `404 Not Found` - Product not found
