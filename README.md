# 🗺️ Tourist App

Welcome to the **Tourist App**, an iOS application built using **UIKit** and **Swift** that helps you explore cities and discover exciting tourist attractions!

## 📱 Features

- **City Search**: Effortlessly search for cities using the **Google Autocomplete API** for quick and accurate suggestions.
- **Discover Attractions**: Get a curated list of tourist attractions in and around the searched city.
Access important details about each tourist attraction, which includes:
  - Tourist Attraction Name
  - City
  - Photo
  - Operational Hours
  - Ratings
  - Reviews Count 
    
- **Image Gallery**: View beautiful images of selected tourist locations to help plan your next adventure.
  - **Pagination**: Seamlessly browse images across up to **10 pages** of stunning visuals related to your selected attractions. 
  - **Reload Functionality**: A **reload button** allows you to refresh and load images again in case of an API failure.


## 📚 API References
### 1. Autocomplete User City Search
    GET https://google-map-places.p.rapidapi.com/maps/api/place/queryautocomplete/json?radius=1000&input={searchItem}

| Parameter     | Type   | Description                                     |
|---------------|--------|-------------------------------------------------|
| `searchItem`    | `string` | Required. The city name being searched by the user. |

- **Description**: 
This API autocompletes user search queries for city names, returning the top 5 matched place names.

- **Output**: 
A list of predictions, each containing the `placeId` and `mainText` (the suggested place name).

---

### 2. Selected City Information
      GET https://maps-data.p.rapidapi.com/place.php?place_id={placeId}

| Parameter  | Type   | Description                                          |
|------------|--------|------------------------------------------------------|
| `placeId`    | `string` | **Required.** The ID of the place selected by the user which is retrieved from the Autocomplete API. |

- **Description**: 
This API retrieves latitude and longitude details for the selected city using the place ID.

- **Output**: 
Returns `latitude` and `longitude` of the selected place, along with additional place information like `businessId`.

---

### 3. Nearby Tourist Attractions
    GET https://maps-data.p.rapidapi.com/nearby.php?query=Tourist attraction&limit=30&latitude={latitude}&longitude={longitude}

| Parameter  | Type      | Description                                          |
|------------|-----------|------------------------------------------------------|
| `latitude`   | `double`    | **Required.** Latitude of the selected place.           |
| `longitude`  | `double`    | **Required.** Longitude of the selected place.          |

- **Description**: 
This API retrieves the top 30 tourist attractions near the specified latitude and longitude.

- **Output**: 
Returns a list of nearby tourist attractions, including details like `name`, `city`, `rating`, `operational hours` and associated photos.

---
### 4. Image Search
    GET https://api.pexels.com/v1/search?per_page=20&query={placeName}

| Parameter   | Type   | Description                                                   |
|-------------|--------|---------------------------------------------------------------|
| `placeName`   | `string` | **Required.** The name of the place for which you want to retrieve images. |

- **Description**: 
This API retrieves up to 20 high-quality images related to the specified place name, functioning as an image gallery. The pagination feature allows users to fetch images across multiple pages.

- **Output**: 
The response contains an array of photo objects, each with details such as the photo URL and photographer information.


## 📸 Screenshots

<div align="center">
    <img src="./Screenshots/Seach Cities.png" alt="Auto City Search" width="400" />
    <p><em>Search for cities and discover attractions!</em></p>
    <img src="./Screenshots/Nearby Tourist Attractions List.png" alt="Nearby Attractions" width="400" />
    <p><em>View a list of top 30 nearby attractions in and around the selected city!</em></p>
    <img src="./Screenshots/Searched Place Image Gallery.png" alt="Attraction Details" width="400" />
    <p><em>View stunning images of your chosen attractions!</em></p>
</div>


## 🎥 Demo Video

Check out this video demonstration of the Tourist App to see it in action!
<div align="center">

https://github.com/user-attachments/assets/0644a28f-1591-4e61-bf89-139b4fdbf031

</div>


In this video, you will see:
- How to search for cities.
- A walkthrough of exploring tourist attractions.
- Viewing images of selected locations.
