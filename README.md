# Go Natural Grocery - Flutter Machine Test

A Flutter mobile application built by converting the provided Figma designs into a functional UI and integrating it with the provided REST API collection.

## 📱 Project Overview
This project demonstrates pixel-perfect UI implementation, robust API integration, clean code architecture, and efficient state management using GetX.

### Key Features Implemented
* **Splash Screen:** Custom Twitter-style zoom animation.
* **Authentication:** Login validation with API integration & dynamic token storage.
* **Dynamic Home Screen:** Horizontal categories, banner carousels, and a featured product grid fetching real data.
* **Product Lists:** Dynamic grids utilizing category slugs to fetch specific items, handling paginated nested JSON structures.
* **Product Details:** Clean UI with fallback descriptions for API stability.
* **Cart Logic:** Fully functional in-memory global cart state (Add, Increment, Decrement, Total calculations) reflected across the Bottom Navigation Bar.

---

## 🛠️ Tech Stack & Requirements

* **Flutter Version Used:** 3.32.7
* **State Management Used:** GetX (Chosen for minimal boilerplate, reactive state management `Obx`, and easy dependency injection for global controllers like the Cart and Auth services).
* **Network:** Dio (For API calls, interceptors, and robust error handling).
* **Image Caching:** `cached_network_image` (For smooth scrolling and optimized memory usage).

---

## 🚀 Steps to Run the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/adhillatheef/go_natural_grocery