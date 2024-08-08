/*

	About: BF map
	Author: Foxze

*/

#if defined _INC_MAP_BF
	#endinput
#endif
#define _INC_MAP_BF

	object_world = object_int = -1;

	CreateObject(8957, 681.400024, -447.399994, -26.700001, 0.000000, 270.000000, 0.000000, 10.0); // 0
	CreateObject(3037, 376.399994, 194.800003, 1013.000000, 0.000000, 270.000000, 90.000000, 12.0); // 0
	CreateObject(3055, 189.500000, 175.100006, 1002.000000, 90.000000, 0.000000, 0.000000, 10.0); // 0
	CreateObject(19377, 2182.887207, 1628.728271, 1042.312500, 0.000000, 90.000000, 0.000000, 16.0); // 0
	CreateObject(19377, 2182.887207, 1619.128174, 1042.312500, 0.000000, 90.000000, 0.000000, 16.0); // 0
	CreateObject(19377, 2193.361816, 1628.728271, 1042.312500, 0.000000, 90.000000, 0.000000, 16.0); // 0
	CreateObject(19377, 2193.361816, 1619.100342, 1042.312500, 0.000000, 90.000000, 0.000000, 16.0); // 0
	CreateObject(19377, 447.133392, -107.266296, 998.455322, 0.000000, 90.000000, 180.000000, 16.0); // 0
	CreateObject(19377, 457.573303, -107.266296, 998.455322, 0.000000, 90.000000, 180.000000, 16.0); // 0
	tmpobjid = CreateDynamicObject(19548, -1539.147339, 2426.058838, 36.447163, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, STREAMER_OBJECT_SD, 600.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "Grass", 0);
	CreateDynamicObject(706, -1564.879761, 2415.329834, 41.505100, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1570.391602, 2344.411377, 41.971088, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1667.205444, 2316.367432, 28.438587, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1631.994629, 2270.724854, 29.935425, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	tmpobjid = CreateDynamicObject(19482, 1279.455200, -2012.392822, 63.012207, 0.000000, -0.000014, 179.999847, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р РµРєР»Р°РјР° РЅР° СЃРїР°СѓРЅРµ", 130, "Arial", 60, 0, 0xFF000000, 0, 1);
	CreateDynamicObject(987, -1667.938965, 2164.409668, 19.045731, 0.000000, 0.000000, 126.000008, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(987, -1693.170288, 2149.076660, 16.809410, 0.000000, 0.000000, 31.300003, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.699509, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g  ggg  g  ggggg  g  ggg  g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19480, 1279.464111, -2012.315430, 60.146484, -0.000022, 0.000007, -179.999863, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g", 120, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(987, -1703.398560, 2142.857178, 16.809410, 0.000000, 0.000000, 31.300003, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.624508, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g          g  ggg      g          g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.549507, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "ggggggg  g  g  g  ggggggg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.474506, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "                g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.399506, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "gg  g    gg    ggg  ggg  gg  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.324505, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "        g      gggg  g    g    g  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.249504, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "  g  gggg  g    g  g  g  g  g  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.174503, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "    gggg  gggg  g      gg  gg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.099503, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "    gggggggg  g  g  gg  g  g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 59.024502, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "                g  g        gg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.949501, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "ggggggg  g    gggg  g    g  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.874500, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g          g            g    gg  gg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.799500, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g  ggg  g    g    g  gg      g  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.724499, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g  ggg  g  g  g    ggggg    g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.649498, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g  ggg  g    ggg    gg        g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.574497, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g          g  gg  gg    g      gg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1279.417725, -2012.873657, 58.499496, -0.000045, 0.000029, -179.999786, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "ggggggg  g              g    g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19531, 1279.503296, -2045.134399, 57.756596, 90.000000, 0.000000, 270.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0);
	CreateDynamicObject(19531, 1267.504028, -2045.134399, 57.756596, 90.000000, 0.000000, 180.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19531, 1267.504028, -2007.595337, 57.756596, 90.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19078, 1261.199951, -2008.400024, 60.099998, 0.000000, -90.999916, -175.899902, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	tmpobjid = CreateDynamicObject(18762, 1242.963501, -2028.266113, 81.639069, -44.999973, 180.000000, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampwhite", 0xFFFFFFFF);
	CreateDynamicObject(18762, 1242.962524, -2025.429932, 81.631996, 45.000011, 180.000000, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19789, 1242.721558, -2026.077881, 77.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0xFFFFFFFF);
	CreateDynamicObject(19789, 1242.721558, -2025.827881, 77.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.721558, -2025.952881, 78.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.721558, -2026.202881, 76.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.952881, 76.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.702881, 76.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.721558, -2026.202881, 75.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.838501, -2028.266113, 81.366737, -44.999973, 180.000015, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.952881, 75.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.837524, -2025.429932, 81.359665, 45.000011, 180.000015, -0.000022, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.702881, 75.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.963501, -2031.786865, 78.117706, -44.999973, 180.000000, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.725586, -2024.092529, 77.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2029.697266, 76.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.721558, -2026.452881, 74.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.962524, -2021.894287, 78.096489, 45.000011, 180.000000, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.725586, -2024.092529, 76.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.723511, -2025.702881, 74.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.712524, -2028.197266, 74.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2023.592529, 77.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.723511, -2025.452881, 74.817841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.838501, -2031.482544, 78.149445, -44.999973, 180.000015, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2026.577881, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2027.697266, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2029.697266, 75.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.962524, -2031.786865, 75.277840, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2023.592529, 76.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.577881, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2024.217529, 75.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.327881, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2028.697266, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2030.697266, 76.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.837524, -2022.050049, 77.979752, 45.000011, 180.000015, -0.000022, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.963501, -2021.894287, 75.299057, -44.999996, 0.000009, 0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.837524, -2031.482544, 75.228767, 44.999992, 0.000019, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2023.467529, 75.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2029.697266, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2030.697266, 75.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2026.577881, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2027.697266, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2024.217529, 74.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.838501, -2022.050049, 75.398460, -44.999992, 0.000019, 0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.577881, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.327881, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2028.697266, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.962524, -2028.266113, 71.756477, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.963501, -2025.429932, 71.763550, -44.999996, 0.000009, 0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2030.697266, 74.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2023.467529, 74.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2029.697266, 73.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.838501, -2025.429932, 72.018547, -44.999992, 0.000019, 0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2024.217529, 73.137833, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(18762, 1242.837524, -2028.266113, 71.881477, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2026.577881, 72.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2027.697266, 72.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.577881, 72.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.327881, 72.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2028.697266, 72.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2026.697266, 71.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2027.697266, 71.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2025.697266, 71.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19789, 1242.722534, -2026.697266, 70.317841, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19480, 1243.219238, -2026.792236, 66.366493, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "-", 120, "Arial", 120, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19790, 1240.665405, -2024.966553, 77.122398, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19790, 1240.664429, -2027.236816, 74.852585, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19790, 1240.666382, -2022.808594, 74.965752, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19790, 1240.663452, -2025.242554, 72.858551, 44.999996, 0.000009, -0.000007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(987, -1721.178101, 2157.979248, 16.839411, 0.000000, 0.000000, -35.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(18260, -1673.729980, 2135.248047, 19.351027, 6.600001, 0.000000, -59.599995, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2060, -1667.132324, 2137.436523, 19.818752, 0.000000, 0.000000, -14.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2023.818115, 63.079430, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "2", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19480, 1243.219238, -2036.692139, 65.936508, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "TRAINING", 120, "Arial", 80, 0, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2023.818115, 63.079430, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g", 130, "Webdings", 50, 1, 0xBF303030, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.157837, -2030.999023, 63.079430, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "ggggggg  gg    gggg      gg  ggggggg", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2022.732300, 63.126492, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "РќРђРЁР� РЎРђР™РўР«:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.157837, -2030.999023, 63.004429, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g          g  gggggg    g          g          g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19480, 1243.219238, -2017.011963, 65.936508, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "SANDBOX", 120, "Ariel", 80, 0, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.099365, -2023.925293, 62.862465, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "I", 130, "Impact", 42, 0, 0xE6D2691E, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.157837, -2030.999023, 62.929428, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g  ggg  g      ggg      g    gg  g  ggg  g", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	CreateDynamicObject(2060, -1667.132324, 2137.436523, 19.578753, 0.000000, 0.000000, -14.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	tmpobjid = CreateDynamicObject(19477, 1243.097168, -2023.754639, 62.859444, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "g", 140, "Webdings", 55, 1, 0xBF303030, 0, 1);
	CreateDynamicObject(2060, -1667.132324, 2137.436523, 19.318747, 0.000000, 0.000000, -14.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2023.349121, 62.869484, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "training-server.com", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2023.462402, 62.859444, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2023.168335, 62.859444, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2022.878052, 62.859444, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.157837, -2030.999023, 62.554424, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "                ggg  g    ggg  g                  ", 130, "Webdings", 20, 0, 0xFF000000, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2023.818115, 62.109493, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "i", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2022.238770, 62.509434, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "РЎР°Р№С‚ СЃРµСЂРІРµСЂР°", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.107178, -2023.818115, 62.109493, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2020.257568, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "_", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2020.257568, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2023.925293, 61.892529, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2023.754639, 61.889507, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2023.462402, 61.889507, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2020.364746, 62.862465, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2023.168945, 61.899548, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "forum.training-server.com", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2023.168335, 61.889507, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2020.194092, 62.859444, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2022.878052, 61.889507, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2019.171753, 63.126492, 0.000000, 0.000007, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "РњС‹ Р’РљРѕРЅС‚Р°РєС‚Рµ:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.097168, -2022.588013, 61.889507, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2019.901855, 62.859444, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2019.688477, 62.869484, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "vk.com/training_server", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.129395, -2034.862671, 63.083542, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "0", 130, "Ariel", 20, 1, 0xFFFFFFFF, 0, 1);
	tmpobjid = CreateDynamicObject(19477, 1243.119385, -2034.864136, 63.089447, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "n", 130, "Webdings", 27, 0, 0xBF303030, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2019.607788, 62.859444, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.121582, -2034.866211, 62.982475, 89.999992, 89.999992, -89.999969, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2035.077881, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Q", 130, "GTAWEAPON3", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2035.117920, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2035.441772, 63.126492, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р�Р“Р РћРљР� РћРќР›РђР™Рќ:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.097168, -2019.317505, 62.859444, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2019.027222, 62.859444, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2022.238770, 61.539497, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р¤РѕСЂСѓРј СЃРµСЂРІРµСЂР°", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2020.257568, 62.109493, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "@", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2020.257568, 62.109493, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2020.364746, 61.892529, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.129395, -2036.143921, 63.083542, 0.000000, 0.000007, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "16", 130, "Ariel", 20, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.119385, -2036.145386, 63.089447, 0.000000, 0.000007, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2020.194092, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.121582, -2036.147461, 62.982475, 89.999992, 89.999985, -89.999985, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2018.678223, 62.509434, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Training | SA:MP", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2036.408813, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "p", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2019.901855, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2036.408813, 63.079430, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.129395, -2034.862671, 62.083553, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.119385, -2034.864136, 62.089458, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2019.558350, 61.899548, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "vk.com/training_warehouse", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2019.607788, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.121582, -2034.866211, 61.982487, 89.999992, 90.000023, -89.999962, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2035.117920, 62.069469, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "8", 130, "GTAWEAPON3", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2019.317505, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2035.117920, 62.069469, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2019.027466, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2018.737183, 61.889507, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.117188, -2016.546875, 63.079430, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2016.546875, 63.079430, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.129395, -2036.153809, 62.083553, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "1", 130, "Ariel", 20, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.119385, -2036.155273, 62.089458, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.121582, -2036.157349, 61.982487, 89.999992, 90.000053, -89.999962, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2018.678223, 61.539497, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Training Warehouse", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2036.408813, 62.069469, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "N", 130, "Wingdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2036.408813, 62.069469, 0.000000, 0.000037, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.117188, -2016.546875, 62.659443, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2016.546875, 62.659443, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2015.461060, 63.126492, 0.000000, 0.000022, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р РђР—Р РђР‘РћРўР§Р�РљР�:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2038.908936, 62.509434, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "World of Tanks", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2014.967529, 62.509434, 0.000000, 0.000045, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Goodman", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2039.668945, 62.869484, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "wot", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2039.644043, 62.859444, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2039.814697, 62.862465, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2039.937256, 62.853539, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "/", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2039.938721, 62.859444, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2014.967529, 62.089447, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Trashman", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.117188, -2040.448242, 63.079430, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2040.488281, 63.079430, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2013.276245, 63.079430, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "C", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2013.276245, 63.079430, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2039.347900, 61.849483, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2038.908936, 61.499474, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Gun Game", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2039.498779, 61.859524, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "gungame", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2039.644043, 61.849483, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2013.276245, 62.659443, 0.000000, 0.000059, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "&", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2013.276245, 62.659443, 0.000000, 0.000059, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2039.814697, 61.852505, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2039.937256, 61.843578, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2039.938721, 61.849483, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.117188, -2040.488281, 62.069469, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2040.488281, 62.069469, 0.000000, 0.000029, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.117188, -2013.276245, 62.219494, 0.000000, 0.000068, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2012.190430, 63.126492, 0.000000, 0.000029, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "РџРћРњРћР©Р¬ Р’", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.107178, -2013.276245, 62.219494, 0.000000, 0.000068, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2041.851074, 63.126492, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р”РћРЎРўРЈРџРќР«Р• Р�Р“Р Р«:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2041.319092, 62.509434, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Police Chase", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.097168, -2041.758057, 62.859444, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19776, 1246.901001, -2046.289185, 60.546654, 90.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 9259, "presidio01_sfn", "stainwin_law", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2013.276245, 61.799507, 0.000000, 0.000075, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "%", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2013.276245, 61.799507, 0.000000, 0.000075, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2041.908936, 62.869484, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "copchase", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2042.054199, 62.859444, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.099365, -2042.224854, 62.862465, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.117188, -2013.276245, 61.389542, 0.000000, 0.000082, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "N", 130, "Webdings", 50, 0, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.107178, -2013.276245, 61.389542, 0.000000, 0.000082, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2042.347412, 62.853539, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2042.348877, 62.859444, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2011.696899, 62.509434, 0.000000, 0.000052, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Markus Williams", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.117188, -2042.898438, 63.079430, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2042.898438, 63.079430, 0.000000, 0.000014, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19478, 1246.438232, -2046.288208, 60.536678, 0.000000, 0.000000, -90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 9259, "presidio01_sfn", "stainwin_law", 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2041.319092, 61.499474, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Death Match", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(11702, 1246.436890, -2046.393066, 60.541763, 360.000000, 90.000000, 90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	CreateDynamicObject(11702, 1246.436890, -2046.394043, 60.541763, 270.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2011.696899, 62.089447, 0.000000, 0.000059, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Eddy Marlow", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2042.069092, 61.859524, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "dm", 130, "Ariel", 25, 1, 0xFFFFFFFF, 0, 1);
	CreateDynamicObject(19477, 1243.097168, -2042.054199, 61.849483, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19483, 1243.163574, -2010.539551, 63.126492, 0.000000, 0.000029, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Р РђР—Р РђР‘РћРўРљР•:", 130, "Arial", 62, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19477, 1243.099365, -2042.224854, 61.852505, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.107178, -2042.347412, 61.843578, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(19477, 1243.097168, -2042.348877, 61.849483, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2011.696899, 61.649498, 0.000000, 0.000068, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Sean1111", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(19776, 1245.970093, -2046.289185, 60.546654, 90.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19835, 1246.552124, -2045.728516, 59.036560, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 3
	SetDynamicObjectMaterial(tmpobjid, 2, 14608, "triad_big", "silver_coins2", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicrfedge", 0);
	CreateDynamicObject(325, 1246.370117, -2045.480225, 59.007290, 76.700020, 24.300003, -90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(325, 1246.370117, -2045.480225, 59.007290, 90.000000, 0.000000, -90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19477, 1243.117188, -2042.898438, 62.069469, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(2868, 1247.012207, -2046.249268, 58.773945, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19477, 1243.107178, -2042.898438, 62.069469, 0.000000, 0.000022, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2011.696899, 61.229511, 0.000000, 0.000075, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "DracoJe", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	CreateDynamicObject(11702, 1246.436890, -2046.392090, 59.511761, 360.000000, 90.000000, 90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	tmpobjid = CreateDynamicObject(2828, 1246.483765, -2045.998535, 59.009720, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 2
	SetDynamicObjectMaterial(tmpobjid, 5, 2266, "picture_frame", "CJ_PAINTING33", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 13761, "lahills_whisky", "whisk5", 0);
	tmpobjid = CreateDynamicObject(19475, 1246.349121, -2045.846069, 59.031372, 0.000000, 90.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 1827, "kbmiscfrn2", "man_mny1", 0);
	tmpobjid = CreateDynamicObject(19477, 1243.107178, -2011.696899, 60.819546, 0.000000, 0.000082, -0.000014, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterialText(tmpobjid, 0, "Vol3k", 130, "Arial", 50, 1, 0xFFFFFFFF, 0, 0);
	tmpobjid = CreateDynamicObject(19478, 1246.039917, -2045.952026, 59.031929, 180.000000, 270.000000, -45.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 2218, "pizza_tray", "pizzaslice", 0);
	CreateDynamicObject(18701, 1247.031494, -2046.240479, 57.673428, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(2060, -1666.334106, 2137.462402, 20.038754, 0.000000, 0.000000, 24.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	tmpobjid = CreateDynamicObject(11706, 1246.437012, -2046.383789, 58.270435, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 2567, "ab", "ab_metaledge", 0xFFFFFFFF);
	CreateDynamicObject(2869, 1246.460693, -2046.127686, 57.864403, 0.000000, 0.000000, -14.499997, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(2869, 1246.427490, -2046.105225, 57.864403, 0.000000, 0.000000, -34.300007, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19531, 1243.093628, -2045.134399, 57.756596, 90.000000, 0.000000, 90.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 1
	CreateDynamicObject(2060, -1665.576172, 2137.800781, 19.778748, 0.000000, 0.000000, 24.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	CreateDynamicObject(2060, -1664.560913, 2138.250488, 20.038754, 0.000000, 0.000000, 24.000002, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	CreateDynamicObject(10826, -1702.364868, 2128.754883, -7.688506, 0.000000, 0.000000, 134.799973, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(13591, -1671.050049, 2108.095947, 17.576174, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(706, -1601.556641, 2162.201416, 24.634384, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1590.226563, 2098.280762, 29.481668, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1768.747314, 2080.708008, 12.070482, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1554.124146, 2137.048340, 42.766476, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(10826, -1780.369629, 2065.899170, -14.818502, 0.000000, 0.000000, 116.799957, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(706, -1704.622925, 2013.636597, 27.829018, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(18980, -1839.241943, 2121.838623, -4.987010, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(981, -1636.861572, 2007.710327, 18.064951, 0.000000, 0.000000, 6.499999, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(16093, -1843.518555, 2093.493652, 1.948858, 0.000000, 0.000000, -109.299973, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(706, -1727.761841, 2001.347656, 20.785013, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(987, -1866.757935, 2189.355469, 3.910330, 0.000000, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(18690, -1867.476318, 2170.224854, 2.539618, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 200.0); // 0
	CreateDynamicObject(12957, -1866.430298, 2202.207764, 4.923778, 0.000000, 0.000000, 86.100006, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(18980, -1870.415039, 2161.114258, -6.385567, 0.000000, 0.000000, 53.099987, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(987, -1876.776001, 2195.746338, 3.910330, 0.000000, 0.000000, -32.900024, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(7025, -1883.201538, 2171.778564, 5.300879, 4.099997, -6.699995, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(17472, -1901.902466, 2245.888428, 6.314143, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1700.443237, 1906.404297, 17.879877, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(3569, -1578.040894, 1789.524658, 18.308287, 0.000000, 0.000000, 51.299995, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(1681, -1624.778076, 1779.629028, 10.591672, -13.200001, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(10826, -1533.635376, 1760.719360, -15.772676, 0.000000, 0.000000, -15.400001, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(19548, -1621.779663, 1736.672485, -11.185588, 0.000000, 0.000000, -20.599998, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(11145, -1645.142700, 1587.680908, 4.794723, 0.000000, 0.000000, -38.799976, -1, -1, -1, STREAMER_OBJECT_SD, 550.0); // 0
	CreateDynamicObject(11146, -1602.810425, 1554.564819, 12.895503, 0.000000, 0.000000, -38.600025, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(10771, -1596.144653, 1548.343872, 6.086767, 0.000000, 0.000000, -38.799999, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(10772, -1595.189697, 1547.460205, 17.876078, 0.000000, 0.000000, -38.600010, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(11149, -1604.101196, 1548.150635, 12.507614, 0.000000, 0.000000, -38.599995, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(10770, -1598.277466, 1540.470703, 39.237747, 0.000000, 0.000000, -38.799999, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(11237, -1598.084106, 1539.652466, 38.892052, -0.599999, 0.000000, -38.999985, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(11495, -1592.245850, 1568.015747, 0.014285, 0.000000, 0.000000, -130.100082, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(8886, -1653.992310, 1609.040039, 21.221996, 0.000000, 0.000000, -40.099998, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1659.428467, 1601.059326, 12.189262, 0.000000, 0.000000, 51.000011, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3069, -1624.190674, 1592.252808, 9.686388, -6.399999, 0.000000, 51.899994, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1657.043457, 1593.468018, 12.189262, 0.000000, 0.000000, 57.300007, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(19089, -1664.020386, 1622.654297, 8.827633, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(18260, -1652.239868, 1589.993774, 4.065971, 0.000000, 0.000000, 50.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1651.436646, 1588.505127, 12.219262, 0.000000, 0.000000, 43.200001, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1671.511230, 1590.383545, 17.679585, 0.000000, 0.000000, -39.099979, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3069, -1615.942383, 1585.736938, 3.876538, 23.100012, 0.000000, 51.899994, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1636.135010, 1585.277954, 3.965971, 0.000000, 0.000000, 52.199997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1630.817261, 1581.153320, 3.965971, 0.000000, 0.000000, 52.199997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3069, -1608.491699, 1579.754883, -1.427561, 23.100012, 0.000000, 51.899994, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(18260, -1642.148560, 1577.615479, 12.380269, 0.000000, 0.000000, 46.900021, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(8885, -1643.723389, 1577.147705, 5.825973, 0.000000, 0.000000, -40.600010, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3066, -1625.633545, 1575.070190, 3.585973, 0.000000, 0.000000, -37.299988, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3069, -1601.445923, 1573.413208, 0.059891, -7.699985, 0.000000, 50.200005, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(8885, -1633.373413, 1566.235352, 5.825973, 0.000000, 0.000000, -40.600010, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(939, -1627.975098, 1579.390259, 13.101263, 0.000000, 0.000000, -40.200001, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3565, -1610.688721, 1570.011719, 12.131258, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3576, -1604.273804, 1563.290527, 12.234333, 0.000000, 0.000000, -39.899990, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3576, -1597.429932, 1557.568481, 12.234333, 0.000000, 0.000000, -39.899990, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3576, -1592.105591, 1553.116577, 12.234333, 0.000000, 0.000000, -39.899990, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3069, -1583.424072, 1521.840698, 12.630495, 0.100000, 92.300026, 59.199986, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3066, -1555.391479, 1520.672485, 11.761754, 0.000000, 0.000000, -40.100002, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3069, -1573.814575, 1514.505981, 12.664908, 0.100000, 92.300026, 59.199986, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1564.874878, 1513.050781, 12.136754, 0.000000, 0.000000, -31.400011, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(13011, -1560.006470, 1539.801636, 12.770832, 0.000000, 0.000000, -127.999954, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3565, -1570.113403, 1536.468994, 11.801753, 0.000000, 0.000000, -40.500011, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(10166, -1338.567505, 1256.564453, -10.202054, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(3885, -1526.372070, 1480.575684, 18.595827, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	
	CreateDynamicObject(706, -1568.692017, 2216.123779, 52.504570, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(19307, -1477.877808, 2633.876465, 58.667961, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	CreateDynamicObject(17472, -1798.174805, 2240.911133, 5.588325, 0.000000, 0.000000, -37.500000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(3632, -1477.867188, 2633.816650, 58.237965, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 80.0); // 0
	CreateDynamicObject(706, -1605.583252, 2210.264404, 39.499390, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(1522, -1390.778442, 2639.247070, 54.974400, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0	
	CreateDynamicObject(8314, -1705.949097, 2193.121582, 21.180885, 0.000000, 0.000000, 65.999977, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(19909, -1687.762085, 2174.440186, 19.787476, 1.199998, 0.000000, 44.900002, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(8314, -1670.446655, 2155.303955, 20.178341, 0.000000, 0.000000, 140.499908, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(3279, -1691.471313, 2157.077637, 16.292439, 0.000000, 0.000000, 130.199982, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(987, -1674.863281, 2173.940186, 19.045731, 0.000000, 0.000000, 133.899979, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(8615, -1677.195435, 2172.241943, 22.235083, 0.000000, 0.000000, 133.199982, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1652.215576, 2136.822021, 20.113226, 0.000000, 0.000000, 18.400000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3279, -1739.602173, 2148.226807, 16.526440, 0.000000, 0.000000, 30.599998, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(987, -1688.137329, 2152.137451, 19.069429, 0.000000, 0.000000, 31.300003, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(987, -1711.655762, 2151.467041, 16.839411, 0.000000, 0.000000, -46.199982, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(16093, -1765.630981, 2208.847412, 2.777904, 0.000000, 0.000000, -35.200012, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(1681, -1639.640747, 2072.356689, 18.721716, -16.699995, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(18248, -1671.303345, 2077.463379, 25.017544, 0.000000, 0.000000, -98.199974, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(705, -1727.244629, 2075.308594, 26.307915, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(705, -1695.921631, 2049.837891, 33.631947, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1726.937012, 2033.572754, 27.345001, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(3569, -1655.268555, 2045.672241, 19.507351, 0.000000, 0.000000, -100.699997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(922, -1655.219116, 2143.495361, 19.743694, 0.000000, 0.000000, 27.599998, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(16093, -1771.450684, 2114.424316, 17.641859, 0.000000, 0.000000, -90.700005, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(16093, -1814.963135, 2154.719238, 6.587903, 0.000000, 0.000000, -65.300003, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(16093, -1847.451172, 2231.286865, 20.165968, 0.000000, 3.299998, -34.799992, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3279, -1811.794189, 2088.559082, 7.146839, 0.000000, 0.000000, -26.600004, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(703, -1706.948853, 1988.042603, 25.869921, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(18980, -1850.928223, 2138.379150, -6.105566, 0.000000, 0.000000, 39.600006, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(18980, -1859.055298, 2148.204102, -6.105566, 0.000000, 0.000000, 39.600006, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(3568, -1808.856934, 2128.447266, 9.073266, -3.599997, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2985, -1665.713379, 2138.357666, 18.884634, 0.000000, 0.000000, -66.899994, -1, -1, -1, STREAMER_OBJECT_SD, 200.0); // 0
	CreateDynamicObject(987, -1857.331543, 2182.040039, 5.199265, -85.299995, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0	
	CreateDynamicObject(19089, -1664.020386, 1622.654297, 16.207638, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(10826, -1948.836426, 2246.785889, -14.818502, 0.000000, 0.000000, -149.300049, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(706, -1591.728638, 2273.664307, 48.096584, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(3279, -1963.623901, 2188.369629, 0.835851, 0.000000, 0.000000, 31.700003, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(706, -1780.703491, 2317.750244, 45.360023, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1620.784180, 2323.500000, 40.942383, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(705, -1553.605957, 2302.191406, 48.711430, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(987, -1887.210693, 2201.231445, 3.910330, 0.000000, 0.000000, -27.000031, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0	
	CreateDynamicObject(19909, -1453.823608, 2669.367676, 54.851494, 0.000000, 0.000000, 89.900024, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(8210, -1462.614868, 2676.949707, 56.640255, 0.000000, 0.000000, 179.899979, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(18260, -1466.760254, 2670.042969, 56.127499, 0.000000, 0.000000, -89.700005, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(987, -1435.775146, 2665.240479, 54.512920, 0.000000, 0.000000, 89.699997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(987, -1435.814697, 2657.753906, 54.512920, 0.000000, 0.000000, 89.699997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3576, -1481.417114, 2673.801025, 55.987503, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(987, -1435.876221, 2645.974121, 54.512920, 0.000000, 0.000000, 89.699997, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3279, -1484.515503, 2663.712158, 54.263924, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(987, -1492.850464, 2678.571289, 55.209820, -97.300011, 0.000000, -156.299988, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.354980, 2641.673828, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3568, -1498.411255, 2668.286377, 56.917496, -0.199992, 0.000000, -123.999969, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.397095, 2637.644287, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(2929, -1485.439819, 2633.554199, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(987, -1505.421387, 2665.600586, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.476685, 2630.143311, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(987, -1505.671631, 2653.632568, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.518188, 2626.104248, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(8210, -1435.900024, 2618.262451, 57.559486, 0.000000, 0.000000, 90.199997, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(3630, -1480.485718, 2622.156982, 59.171246, 0.000000, 0.000000, -91.699959, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.563232, 2621.755615, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(987, -1505.921265, 2641.725342, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(2929, -1485.598755, 2618.237305, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(2929, -1479.527100, 2611.805176, 57.277954, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(2929, -1485.640869, 2614.285645, 57.297958, 0.000000, 0.000000, -90.600044, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3279, -1468.790405, 2606.966309, 54.285927, 0.000000, 0.000000, -90.399910, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(2929, -1483.677246, 2611.805176, 57.297958, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(987, -1506.171631, 2629.757080, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(3630, -1498.892456, 2621.322266, 56.134575, 0.000000, 0.000000, -89.600006, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(18260, -1473.798218, 2599.105225, 56.200798, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(987, -1506.422729, 2617.769043, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(18260, -1486.548096, 2601.464844, 56.180798, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(8210, -1463.333374, 2590.641602, 57.196732, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(19870, -1504.711060, 2604.113037, 54.697533, 89.599998, 0.000000, -111.800018, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(19870, -1490.877319, 2590.142334, 56.387493, -4.999999, 0.000000, -105.100082, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3279, -1503.141113, 2593.756836, 53.990925, 0.000000, 0.000000, 89.399971, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(987, -1506.875610, 2596.141846, 54.393311, 0.000000, 0.000000, -91.199966, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	CreateDynamicObject(19870, -1507.062378, 2596.094482, 56.449463, 0.000000, 0.000000, 149.100006, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(19870, -1500.178345, 2586.692139, 54.738972, 90.200005, -24.299997, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(987, -1512.637695, 2590.123779, 54.393311, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 350.0); // 0
	tmpobjid = CreateDynamicObject(19548, -1513.351440, 2484.289551, 41.495274, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 3954, "rczero_track", "desertstones256grass", 0);
	CreateDynamicObject(706, -1544.952148, 2455.838867, 50.090786, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(16613, -1504.270630, 2407.593018, 49.177246, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 550.0); // 0
	CreateDynamicObject(10357, -1624.386475, 2481.738037, 152.062775, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(3799, -1584.004883, 1528.520874, 10.631752, 0.000000, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3799, -1578.264526, 1525.767456, 12.831748, 0.000000, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3799, -1578.264526, 1525.767456, 10.631752, 0.000000, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(3799, -1572.391846, 1524.450195, 10.631752, 0.000000, 0.000000, -37.500004, -1, -1, -1, STREAMER_OBJECT_SD, 250.0); // 0
	CreateDynamicObject(705, -1629.714478, 2445.243408, 77.075249, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1555.291016, 2383.041260, 37.105110, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(705, -1522.197388, 2360.708984, 45.189434, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1763.284302, 2350.442383, 53.463036, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0
	CreateDynamicObject(706, -1627.096313, 2236.367188, 28.016388, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 450.0); // 0	
	CreateDynamicObject(10826, -1826.248657, 2272.761963, -5.238502, 0.000000, 0.000000, -129.899979, -1, -1, -1, STREAMER_OBJECT_SD, 600.0); // 0
	CreateDynamicObject(19089, -1633.223145, 1558.414551, 16.227896, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19089, -1684.638672, 1599.775513, 16.235470, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19089, -1684.638672, 1599.775513, 8.925458, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(3576, -1670.749512, 1593.857910, 19.305826, 0.000000, 0.000000, 140.600067, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0
	CreateDynamicObject(19089, -1633.223145, 1558.414551, 8.877902, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 300.0); // 0	
	CreateObject(2938, 2527.399902, -1683.400024, 1014.400024, 0.000000, 270.000000, 90.000000, 14.0); // 0
	CreateDynamicObject(17068, -1425.688843, 522.799316, -0.027380, 0.000000, 0.000000, -90.099968, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0
	CreateDynamicObject(5822, -1407.619995, 518.450684, 3.791620, 0.000000, 0.000000, -85.200050, -1, -1, -1, STREAMER_OBJECT_SD, 400.0); // 0