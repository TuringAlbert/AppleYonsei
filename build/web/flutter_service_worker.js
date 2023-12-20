'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "d94a66a38e6f1476b35a4d43f5288f13",
"index.html": "c68da33bcef18a9c5f90270f2e7beacd",
"/": "c68da33bcef18a9c5f90270f2e7beacd",
"main.dart.js": "356a70b279885b6841a4c1128a7d9550",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bfcfd84374b002aac953219542c35148",
".git/config": "fa4e04980b4df5ea9427f98aebdf219a",
".git/objects/59/d22c5f2dbac0c7ad9910ed27401e7be042e0a7": "9e70363ec3769214034161c2d37505f0",
".git/objects/66/d72e60d7bfacb28b2f73aea9fd9da22c5e43c1": "4caa8c6d7a13951600542fad3acd6a14",
".git/objects/50/5520dc726bf2b82b7921a4c4fae9d5b4148125": "52ee01298885956c46498c9c8d78fe7a",
".git/objects/3b/00f0129d5444e8ae4895552cfa46d2a5eb3c5d": "e6f2ae56f3c06e29bafda9ae6d84f2dd",
".git/objects/6f/057c544b052e211a0f3bdecd97dfad1a5f12a1": "1a10aea9e9e15f0a92fd8e6f65b77b3e",
".git/objects/6f/b1d74c44d217f587cb5f63f11fe5eff0c43d1e": "b63c4bf5b5a9f299c4d2d85aaf18c104",
".git/objects/04/e5efc15dc0c60ea2ffcc37c5bf25e96689f44d": "978222f47488835b92838c74cb5c684c",
".git/objects/32/d7b8d4bc5695f05588a6fc80bb81234a5d54f2": "b01f3b13aca5051413364e98c19d6c93",
".git/objects/32/f2feb2fb9bd372b06a94b268c94a60c40c67d5": "46770f623c11631052858ad41797a983",
".git/objects/58/dcd62e9331b4297d457dfac7538918b6339d53": "11acef4dc85aead01df9861904a4a861",
".git/objects/93/2f9bee06a3e5412915e6c2d7095ebfc8e89115": "b291ae2922430aa4a9107026e9a66af9",
".git/objects/94/c5efcb9d91a7f9a05565bbf501def15821efa4": "8be2238375a32d6ad9f226336aabd1b3",
".git/objects/5a/5c7549f581d535230ce442747bf7049d0d9925": "3e38e9128ba33b64df52851352973905",
".git/objects/33/bd0671f573c54fa79397ad7f2975990f88180c": "0fcd822e5f576f3eb3bd873e01f31f62",
".git/objects/05/c72d96be10931ba66c4826e0f05c6e93c2c29f": "77bcee6ef3f5237303a839d1f88c3ca6",
".git/objects/05/a2331e97b24f10fa6e2b05e3e15409fb2f96e9": "cd7807aead9c0ddc810f341bf42c9209",
".git/objects/02/773597c98813eefecca9e94eab8446ce54c83c": "6ac3dd4ea20750fe50f798ae0ecb57c6",
".git/objects/a4/69663971a9a41434986c711195ac014b9e2ffd": "123ddb4ca388f81386fd2db8c7c34ac7",
".git/objects/b5/8835dfabd334d1657a30b8874a08e9ca3fe10b": "3705f5018356e59579b3b4f7ee4484f2",
".git/objects/ad/ea4d8143ae9971e161ebcffcd973202d9739e8": "47b80601b900af3172ca41f14152eda6",
".git/objects/d7/2c11112c7cb4e2ce754bc41470f9b829a2d00a": "d7280a766a5d6033f187d874a92b5ad6",
".git/objects/d0/c5921069afecf06134dc20fef92f1fc300433b": "5188302e7e60e8328b0cdb019e626ed3",
".git/objects/be/bf382e6a22a2c5bf1773e04322fea8b9245bae": "3266f51bd41ce946eb63102c5fd46d87",
".git/objects/da/f3bc747058ef23d9ca42421f67d7b29be0eaa6": "2c273621a9bbcb098704c51a489c195d",
".git/objects/bd/98e657c42ab00c306318cd14259bea053cfcc5": "91874bcc226e6ca0317a84f334002104",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/ebd4805981b8400db3e3291c74a743fef9a824": "6c33f0e88a71d9ba8563eab3ee932f04",
".git/objects/bc/72e8e027f813df11aae9440f30e7c8cd57edef": "68349c869cedfa7f26cf69b6375fbc7f",
".git/objects/ae/c766616b3635e7b0f3c019ad0bfca70b1bdfa1": "b181c054e8efa4ab0ffece4d0ee04e53",
".git/objects/f4/f13ac41f892bbf3a4428644a2b02b5c7777d5b": "d6d0092c469b5ef6cbbd0fad21c3c6fd",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/8867a6622a809d9ceda29328053ef4a756b11d": "ffffef950fe418ea8eea071b24827e13",
".git/objects/eb/8f3ab23f91a91706bd84581dff7549da7544b4": "c13b837c14b6fb498610ad2364311051",
".git/objects/f5/89ca37d210990980a9d9b1a5cb4a29d2db6c70": "8b8d21aac8e6cdbec1fc106163311c31",
".git/objects/c8/79b2a670a5c86a316c8d04acc67d906fe597b6": "d361cec147a74422289016c2eb93938e",
".git/objects/ed/39096d2589ec06cb19b3b5dc76e7ac739975c5": "dbdec50398ce092d6f25e18071ae5113",
".git/objects/ec/cbb879ea2430bbeaf60ec696895bc5aab74acb": "b4e5a3616760032fd52e24f4b62afb82",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/7d/16c1d5f8318c8d70e4f4c97040049605d63241": "60c2eea5cb0486eb048a7d9cfd48a7a0",
".git/objects/1f/ef37aaadf74e30585723086e61c14109cef60c": "222bdb113b1cf0bf0e6b920c0d98e6ec",
".git/objects/87/b7d4625764c3020a5e74efd9ef53e1aad75768": "d8f02438e154102bf60d8ede02596ed9",
".git/objects/80/fff50449709885e54e5e167d8cf1e300a7fda1": "2cc1c4b25222e4932e0f0f1667a42ea3",
".git/objects/1a/9981505809f33556d3cbbf2fec066f4a621d68": "d03903a9157e4faaae3e98365fe8c955",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/26/d33521af10bcc7fd8cea344038eaaeb78d0ef5": "39554bb11371007e021a7fb3361ecd47",
".git/objects/21/21fcec078b6298d3a95ea46c758f32e24c0c56": "0872068b0b0b3f86fd8cf722c9133d8c",
".git/objects/81/8900157824889aa0fca746eb95a6b1ac444a43": "25d953e56a8ac40f0e804e6845b6854a",
".git/objects/2a/ecd786e76328c71cad901fc491e15da01d44be": "13b924df69d0108756194a4cefe9142b",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6b/1bd4e9bb2f0e5b09bc6f26cf9fa470f3a3769b": "84d252dd0219c61c44df921143b11e9a",
".git/objects/38/d6cbe917869cd6be4f1bcda4eb5c7990f5eb6c": "018f204ed838d3c8fd77742d8c6f6aff",
".git/objects/5c/0020c533cf3c754d0cae9c3dfc68c042e94a4d": "4d1d8f376b0b7019c9905003a4c84605",
".git/objects/5d/8ac6c387876d33c06fa27625c66c79c06ec257": "1ff889bce5a91cd6aee95e6004d24a46",
".git/objects/31/fa44e6ee5de172cff7c22e555bdf398a2215d0": "f9481c8d0f15f975cf4f297808f81865",
".git/objects/31/bc6eff425aac5526bad8a40ac22cf83cfc08de": "f809ecff42c2dd4838402e76cc8925b2",
".git/objects/91/dfa7a16ac03d83e6b19c074a043c99da14a904": "7652da8cdd9435eed409872d99781358",
".git/objects/96/e852dc25f2b8d6b68a168ec159af29d454fb0d": "7abdafc67fd9cdc2aa4f403acf486bf3",
".git/objects/96/35406f74955ccb17694fae8a12391154f0543b": "1be1c50fa801830df435e8610439197f",
".git/objects/53/7807567919e88db2866b7825339c57e94c24d8": "970aec5149a3dbe9370a9dc982cdd022",
".git/objects/3f/c787dcc20ffe3b9555f30197b41b6868d7845c": "a896dc74efaea9d16ab0968832504243",
".git/objects/30/41914bddc7ad0746067728dfca5846a64bfc58": "2b6d3ab9d50cbb1f2b36247f24673d75",
".git/objects/5e/d258435591b87b3ace4d9693b7cf5ec5102796": "9b14589f5e205be54f3b13f34684456c",
".git/objects/01/0f2ab0713c31a67501f93a4ebd9767f4915155": "b6dca929a399d58fd1012d97a2c81fd0",
".git/objects/6c/0b8635858dc7ad44b93df54b762707ce49eefc": "4301997f66617848371b4f6ad8aeafc1",
".git/objects/52/2796977a6c606cafb46385f8492c0d6ca846fe": "8233ef4f4d6162a56152d2bb7c7804ca",
".git/objects/63/9900d13c6182e452e33a3bd638e70a0146c785": "488924a8ec51457535ebf377a60e23c8",
".git/objects/64/f6f243c8f7efb1870236b7f937f267cfa52e74": "bdca3cc376ae28fee7b31e900fbcfae1",
".git/objects/bf/8a3659f980c8a3d5b0b03f2d547bc5e3be9de4": "91876e596fb445cef8e75b666f7c0ce9",
".git/objects/d3/93702c015e6775921d43694203b4a00c143b55": "46dd8688f87351ca61ab2dfe2218d945",
".git/objects/ba/d8f41c77064069c55164dc9ac871fc5887bbc4": "0a48f69f9abc40335ee454be19e570b7",
".git/objects/ba/8cb00dd5231f1a55de0205c16445926a696526": "be8592f9341c9b01b70890c8614c6cf7",
".git/objects/a7/aae1fcc5126164bca4cf4d30ff9fded38b66bb": "6661f962a57dc94c9b0a79a0ac26f0c1",
".git/objects/b8/3fe92bdca306b479e414327701c787b85703ea": "878e9cde7fe2d86e30d8c4f235254112",
".git/objects/b6/f1e5820bd35220a6aaaaca13a7166eb1dac859": "4c22089f70e2a84c4dd0cbfd8afd6752",
".git/objects/d2/3dbe41ef58240abf1062c2bd0826385fe8a79a": "67a450c9e513caeb1e731dc0a5b9025b",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/a8/fa5aacfc54d1a8aafce8a7d6acfa29ac7182d7": "a48ce3c16dbf7aa20fce453d96f61b6e",
".git/objects/b0/b92064fc0942d905accc16a4afa9fb6242eafd": "e9d2acc3f1ef989506e85d60419e8391",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c3/87ebe6ae1bcc8b40b1d704b52f5a62bc7773be": "d0e700d0332a4cb14cc32d08e32ea2bb",
".git/objects/cc/ffd905456332155706540e2e860b7d917c526c": "58e6f05366b805379ab0724fa310ed3b",
".git/objects/e6/c0088edc03deaca44ea8754e803fe40a2917f0": "475483d3ec611a8da939a98819591813",
".git/objects/e6/b745f90f2a4d1ee873fc396496c110db8ff0f3": "2933b2b2ca80c66b96cf80cd73d4cd16",
".git/objects/e8/2c5850db3a3482d0c954a4dc122c02de555ce7": "d357cd906b3805bf81477f5527cca086",
".git/objects/fa/fb0d7e915d11b303c55d694a17755d52afdb5d": "9e731dcc064033b3453e57f70e28555d",
".git/objects/c5/f4bc2a4da91586f3005813077f0d0aa9040f82": "3191028b787554cee4652f5050144bff",
".git/objects/c5/0d2d1ba93b419fa996eaef215a35a02efa0780": "2da5da471207698b847a2f6408fb9268",
".git/objects/f1/03fe760d7c5e868cd3717475333daf6dc0804f": "4ee32496d51420d9417b01b5ccc3d059",
".git/objects/f1/3b494b6125d9e3da3548462fcee0214d23cd93": "f514f2ee41c2ee7f020349507692af54",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/2d/05528c6c4c6d1e391ebcbfb15e7d2ed5af3524": "c1388e375a10fca6b9515b45e7a0a58f",
".git/objects/41/e5cf91e8061de693e81c7834c1beccc0722093": "cab212c2ced1468abef5b6a9f7f7533b",
".git/objects/1e/f356227a156e84736e4f230e0015ede2182875": "1dfea622f8d82a186d581a009eee32f6",
".git/objects/84/6271738644a419f352ae63730c5797c3c21a10": "faa77ed7d853b4ed1e4d421d9bd342d8",
".git/objects/4a/39079e580dc9be820cba2fae41238c49eaa798": "ada1a19fea32fbb6719120809b9eae60",
".git/objects/23/c0e49cc64829dad943f91f1bd0dfef273c51d6": "6f73893821c81016218ab36818d9cd5e",
".git/objects/23/58dd26ea6a615fb18bc5deca1f4cff2b7fecf1": "6df8a4b903749969b0001c7c347b3257",
".git/objects/8d/a40d21a2ec6307e8d51b11aded375d5e99d4f2": "a3c1eb5fda4140c59c7c0c7d63b92b8e",
".git/objects/8c/2829e084c184e130a16581afe98179c0c77886": "9032b793758afe675b40426d25b0f74a",
".git/objects/71/7117947090611c3967f8681ab1ac0f79bca7fc": "ad4e74c0da46020e04043b5cf7f91098",
".git/objects/1c/3c956f2e7a4d8588743847113079c170b0e897": "0e0fb817cff1eed6abc136decba413d4",
".git/objects/82/1ef395d07317b0b1241bc5013bec79909f5369": "e4ee6cf7a3e287df74760ac2074d74f7",
".git/objects/49/4acede0c520f847f75982ca1f671fc6eaa889e": "c4a42624eaa20c8a64455bab6edd0908",
".git/objects/40/d8dea7a0c5bdf39f3f3b02838c6c6e4672c44a": "234fa161ad3f1737a268ecbaf3e800a5",
".git/objects/7f/154346ac3ee6295f4863f35e92f6856a1c3b23": "dfc42456799791f11b2b50fc316cee47",
".git/objects/7a/67624534c5482145c82b1e74fd3834adbc61a1": "2cb521835503a82d769371d9a2a56bd1",
".git/objects/14/68a19f0e14d14787033738c0b226fd6ae5e855": "263ce91855a271ab5a783a5ee8c3ae7c",
".git/objects/25/09cf68f782e1cfdc281b2b3115a021c489df1c": "5f58f7bb8a8ee654e7aeb9955e490471",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "b66631357f22544244116411b42706e7",
".git/logs/refs/heads/master": "b66631357f22544244116411b42706e7",
".git/logs/refs/remotes/origin/master": "72292fd6129c4a9d42e3adc1cd4441a1",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/master": "90ed23ef9899f71093fa607233e139f1",
".git/refs/remotes/origin/master": "90ed23ef9899f71093fa607233e139f1",
".git/index": "bc85890422704dcfee494359304c7b11",
".git/COMMIT_EDITMSG": "a8d5b56a4b634971b8d76d037455be4a",
"assets/map.html": "2f602a18b74254e4cea538d7434006e2",
"assets/AssetManifest.json": "411282de31685e25514cbd0a78cabf04",
"assets/NOTICES": "3ee293aef1af7749c01fe60eabfaff3d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "4de250c8cd3bad181c9e388e2db9a446",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/kakao_map_plugin/assets/images/marker.png": "12bf67c50646e79b2efb6246b3631612",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "d3de73b30708aeedcf11f47a50605afb",
"assets/fonts/MaterialIcons-Regular.otf": "c52643ff2c2f4085cdfd8ffa705a2c06",
"assets/assets/discover_things/featured_collection.webp": "47128cc62f6fc9d65bcbc8b41948cadc",
"assets/assets/discover_things/online_experiences.webp": "8f30f60c729d7f8de16b33075363b12d",
"assets/assets/discover_things/experiences.webp": "da27b07ba115c1576970df40ea30d359",
"assets/assets/map.html": "5df3606bbcfb2173ff25a485e5981522",
"assets/assets/live_anywhere/pets_allowed.webp": "7adf2e6f118a240e0919c0d54b439ecd",
"assets/assets/live_anywhere/outdoor_getaways.webp": "4b57a91e20fb14a8e839c81a814e873b",
"assets/assets/live_anywhere/unique_stays.webp": "cee3cfbbed50ce8cb257314265bbfe18",
"assets/assets/live_anywhere/entire_homes.webp": "ae3c0c2e6586eb132c513c65a35f4c70",
"assets/assets/images/Frame%25203179.png": "a3fb26ee767f3552ad8823c448904c1a",
"assets/assets/images/Frame%25203194.png": "e202332caf45ae4c34278f614d8c6055",
"assets/assets/images/apple.png": "4f658b9a7d067de5238644b78d8d09cc",
"assets/assets/images/reservation_completed.png": "f870fb19fff51196452147bd7b330fc2",
"assets/assets/images/Group%25203157.png": "bcd0bcb5c3ec4a3ccc92548e71e8bd81",
"assets/assets/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/images/babple_logo.png": "5b9e7b31f0dc4a1c534fac1f7632bc67",
"assets/assets/images/res.png": "a2a75f86636179f3271fae10f82e6801",
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
"assets/assets/icon/bookmark.png": "dcb777c7bb83fc9431b70b2c46fbc844",
"assets/assets/icon/bapple.svg": "bbba516c2a7d2e4f485e820a2b6e8258",
"assets/assets/icon/airbnb_icon.png": "d4149bcd9bf770337afee70f6be5e9bd",
"assets/assets/icon/account_icon.png": "fba993a405940cc73f9746e1d22c1113",
"assets/assets/icon/calendaradd_icon.png": "93993821b12ae98623c8833de9a354e4",
"assets/assets/icon/heart_icon.png": "145f098a6b9a474a2e6264695f5bac72",
"assets/assets/icon/search_btn.png": "c3911f5a018f166d869e384396c04742",
"assets/assets/icon/auth_icon/google_icon.png": "a2229b88eeb7a5118f0a2c38b1862c58",
"assets/assets/icon/auth_icon/apple_icon.png": "a3ac5a79768db71b31c63ad558af7bcf",
"assets/assets/icon/auth_icon/email_icon.png": "44b1d7bd76e03eb90d841c7d491eafad",
"assets/assets/icon/auth_icon/fb_icon.png": "54926e4a9d76db213e9072e40bedcafc",
"assets/assets/icon/dish_icon.png": "e5ef5105adba6024e33b24a169756612",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "286ecdb4fdb6743d6b7528ded96f3134",
"canvaskit/canvaskit.js.symbols": "b38bd4bea335fb40407f964a662c7a24",
"canvaskit/skwasm.wasm": "9589dc9655b7a09e8206b884d7622037",
"canvaskit/chromium/canvaskit.js.symbols": "8d7c4b1710d375d9587da3c2e3bf7774",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "eb72caf49bade5b6a2db8c0d1aa63d50",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "187c804605d7ae3cc3eca7ab182bee3b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
".idea/vcs.xml": "55b7e3c95c188fd86e7ecc8c360934b1",
".idea/workspace.xml": "d05564f830741e37260fbf9375d1766d",
".idea/modules.xml": "1eb3b065c55895e347308e50cd717dee",
".idea/web.iml": "52db5efd0fe9f576a1302b8c4b5eac6c",
".idea/misc.xml": "e6b023077aa4876dbe12734108325458"};
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
