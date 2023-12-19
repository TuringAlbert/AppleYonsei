'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "d94a66a38e6f1476b35a4d43f5288f13",
"index.html": "510af30f7a6b2623ca6235568b3d557c",
"/": "510af30f7a6b2623ca6235568b3d557c",
"main.dart.js": "2f6d4d79ca7d0e19e28ac800bcab58fa",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bfcfd84374b002aac953219542c35148",
"assets/AssetManifest.json": "05170a4989d65e196cd9da041a83aff7",
"assets/NOTICES": "0ad74b3b9f6c37de138c1b418e76d911",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "366d96fca0db3973e2f4d53b4d8f2ef2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/kakao_map_plugin/assets/images/marker.png": "12bf67c50646e79b2efb6246b3631612",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "e2fe3fac64b5cb803abeda2be2a5abd3",
"assets/fonts/MaterialIcons-Regular.otf": "a44094987ad1ccf8012bf113f6653242",
"assets/assets/discover_things/featured_collection.webp": "47128cc62f6fc9d65bcbc8b41948cadc",
"assets/assets/discover_things/online_experiences.webp": "8f30f60c729d7f8de16b33075363b12d",
"assets/assets/discover_things/experiences.webp": "da27b07ba115c1576970df40ea30d359",
"assets/assets/map.html": "e703068448719ed2faa9e93944dfbbe3",
"assets/assets/live_anywhere/pets_allowed.webp": "7adf2e6f118a240e0919c0d54b439ecd",
"assets/assets/live_anywhere/outdoor_getaways.webp": "4b57a91e20fb14a8e839c81a814e873b",
"assets/assets/live_anywhere/unique_stays.webp": "cee3cfbbed50ce8cb257314265bbfe18",
"assets/assets/live_anywhere/entire_homes.webp": "ae3c0c2e6586eb132c513c65a35f4c70",
"assets/assets/images/apple.png": "4f658b9a7d067de5238644b78d8d09cc",
"assets/assets/images/reservation_completed.png": "f870fb19fff51196452147bd7b330fc2",
"assets/assets/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/images/babple_logo.png": "5b9e7b31f0dc4a1c534fac1f7632bc67",
"assets/assets/header_bg.webp": "85d81cc59a5381eda16b479b8351a5da",
"assets/assets/try_host/demonstration/host_demostrate.mp4": "c6465cfe975608aa32c5f54f3fffcf8c",
"assets/assets/try_host/demonstration/try_host.mp4": "af11bf20121ecfc8970a0703bcead923",
"assets/assets/try_host/demonstration/mexicoCity_sign.webp": "045ac73d04bf793b3b37f6e63b87cd02",
"assets/assets/try_host/demonstration/johannesburg_sign.webp": "bef2d49f55223644fff46e9b724549c7",
"assets/assets/try_host/demonstration/mumbai_sign.webp": "726aa6f41a4740a925551f164e66ed31",
"assets/assets/try_host/demonstration/philadelphia_sign.webp": "53cb1ec767f8d02342f6075b5c694fd1",
"assets/assets/try_host/host_anywhere/atlanta.webp": "eb162aa91cbef7ad5a6f83a6c63c8d7b",
"assets/assets/try_host/host_anywhere/chiang_mai.webp": "72901d9c9e9f802ab4f3092dba55622d",
"assets/assets/try_host/host_anywhere/palombara_sabina_sign.webp": "62b7912b2039357b3ff8517a7989ff0f",
"assets/assets/try_host/host_anywhere/atlanta_sign.webp": "8b3fb17efd9c8c25cc4ad4c2b9033104",
"assets/assets/try_host/host_anywhere/paraty_sign.webp": "8f3a137cf4244b5416ee0a4e9efdd85a",
"assets/assets/try_host/host_anywhere/wadi_rum.webp": "3d1f59d4c0a636c17bb609d2bf501471",
"assets/assets/try_host/host_anywhere/palombara_sabina.webp": "c2f2dea6bd6f5bd691a7bcedd0e27b5e",
"assets/assets/try_host/host_anywhere/app-release.apk": "35f3b679d05e7275a9f228d302b47e75",
"assets/assets/try_host/host_anywhere/milan_sign.webp": "eea30044adeedf02a2c9ea39f8af1c36",
"assets/assets/try_host/host_anywhere/paraty.webp": "0362c900e75125eaf9e40a923b499614",
"assets/assets/try_host/host_anywhere/milan.webp": "5021be004e340b3b3b2517f4824135f6",
"assets/assets/try_host/host_anywhere/chiang_mai_sign.webp": "7a30030cb12464b0d3bd7740e5d112e7",
"assets/assets/try_host/host_anywhere/wadi_rum_sign.webp": "d4c8fc50dda36961d9a9aa211769430e",
"assets/assets/try_host/help/support_host.webp": "163290c7658b6860bca5d5df7e82b5f2",
"assets/assets/try_host/help/host_experience.webp": "7c1bbfdd1536fe92c43b951602af7679",
"assets/assets/try_host/hosting.webp": "00a54293dceb58959209251b539329d6",
"assets/assets/icon/inbox_icon.png": "4b82e18ac46c1fe3cacbdd69d6f3a348",
"assets/assets/icon/airbnb_icon.png": "d4149bcd9bf770337afee70f6be5e9bd",
"assets/assets/icon/account_icon.png": "fba993a405940cc73f9746e1d22c1113",
"assets/assets/icon/heart_icon.png": "145f098a6b9a474a2e6264695f5bac72",
"assets/assets/icon/search_btn.png": "c3911f5a018f166d869e384396c04742",
"assets/assets/icon/auth_icon/google_icon.png": "a2229b88eeb7a5118f0a2c38b1862c58",
"assets/assets/icon/auth_icon/apple_icon.png": "a3ac5a79768db71b31c63ad558af7bcf",
"assets/assets/icon/auth_icon/email_icon.png": "44b1d7bd76e03eb90d841c7d491eafad",
"assets/assets/icon/auth_icon/fb_icon.png": "54926e4a9d76db213e9072e40bedcafc",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "286ecdb4fdb6743d6b7528ded96f3134",
"canvaskit/canvaskit.js.symbols": "b38bd4bea335fb40407f964a662c7a24",
"canvaskit/skwasm.wasm": "9589dc9655b7a09e8206b884d7622037",
"canvaskit/chromium/canvaskit.js.symbols": "8d7c4b1710d375d9587da3c2e3bf7774",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "eb72caf49bade5b6a2db8c0d1aa63d50",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "187c804605d7ae3cc3eca7ab182bee3b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
