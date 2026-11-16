# Warsztat KIKE 2026 – blok 6: Python w QGIS
# Uruchom w QGIS: Wtyczki → Konsola Pythona → Pokaż edytor → Otwórz skrypt → Uruchom.
# Wymaga otwartego projektu z warstwami "wezly" i "budynki" (np. projekty/04_model.qgz).

from pathlib import Path

import processing
from qgis.core import QgsAction, QgsProcessingModelAlgorithm, QgsProject

projekt = QgsProject.instance()
wezly = projekt.mapLayersByName("wezly")[0]
budynki = projekt.mapLayersByName("budynki")[0]

# 1. Wczytanie modelu z bloku 4 (plik obok projektu)
plik_modelu = Path(projekt.homePath()).parent / "modele" / "potencjal_wezla.model3"
model = QgsProcessingModelAlgorithm()
model.fromFile(str(plik_modelu))

# 2. Ten sam model dla kilku promieni
print("promień | budynki | potencjał | nasycenie")
for promien in (300, 500, 1000):
    wynik = processing.run(model, {
        "wezly": wezly,
        "budynki": budynki,
        "promien": promien,
        "zasieg_wezlow": "TEMPORARY_OUTPUT",
    })
    warstwa = wynik["zasieg_wezlow"]
    warstwa.setName(f"zasieg_{promien}m")
    projekt.addMapLayer(warstwa)
    razem = sum(int(f["budynki"]) for f in warstwa.getFeatures())
    potencjal = sum(int(f["potencjal"]) for f in warstwa.getFeatures())
    print(f"{promien:7d} | {razem:7d} | {potencjal:9d} | {100 * (razem - potencjal) / razem:8.1f} %")

# Uwaga: przy 1000 m zasięgi węzłów w Wieliczce nachodzą na siebie,
# więc ten sam budynek liczy się kilka razy – suma jest zawyżona.

# 3. Akcja warstwy: klik na węzeł otwiera jego położenie w przeglądarce
#    (u operatora ten sam mechanizm otwiera kartę obiektu w systemie, np. LMS)
url = ("https://www.openstreetmap.org/?mlat=[% y(transform($geometry, 'EPSG:2180', 'EPSG:4326')) %]"
       "&mlon=[% x(transform($geometry, 'EPSG:2180', 'EPSG:4326')) %]#map=17/"
       "[% y(transform($geometry, 'EPSG:2180', 'EPSG:4326')) %]/"
       "[% x(transform($geometry, 'EPSG:2180', 'EPSG:4326')) %]")
akcja = QgsAction(QgsAction.OpenUrl, "Pokaż węzeł w OpenStreetMap", url)
akcja.setActionScopes({"Canvas", "Feature", "Field"})
wezly.actions().addAction(akcja)
print("Dodano akcję do warstwy wezly – użyj narzędzia 'Uruchom akcję obiektu' na pasku Atrybuty.")
