# Warstwy wirtualne w QGIS – praktyczne wykorzystanie

Wydarzenie: GIS Day w Stolicy 2023 „GIS w gospodarce przestrzennej”, Wydział Leśny SGGW, Warszawa
Data: 23.11.2023, 16:00–17:00
Prowadzący: EnviroSolutions Sp. z o.o.

Przykłady wykorzystania warstw wirtualnych (zapytań SQL) w QGIS.

## Pobranie materiałów

Pobierz paczkę ZIP z [Release tych warsztatów](https://github.com/envirosolutionspl/warsztaty-gis/releases/tag/2023_gis-day-w-stolicy_warstwy-wirtualne).
Duże pliki danych są dołączone tylko do Release – pobierz je i umieść w katalogu `warstwy_wirtualne`:

| Plik | Rozmiar | Gdzie |
|------|---------|-------|
| `warszawa.gpkg` | 64 MB | Release |
| `A02_Granice_powiatow.zip` (rozpakuj: `.shp`, `.shx`, `.dbf`, `.prj`) | 35 MB | Release |

## Zawartość

```
warstwy_wirtualne/
  gisday2023_sggw.qgz   projekt z granicami powiatów oraz warstwami pkt i linia
  warszawa.qgz          projekt z danymi dla Warszawy (wymaga warszawa.gpkg)
  gisday.txt            zapytania SQL używane na warsztatach
  pkt.*, linia.*        dane do zapytań o przecięcia
```

## Źródła danych i licencje

Zobacz [ZRODLA.md](ZRODLA.md). Materiały udostępniane są na licencji [CC BY-NC 4.0](../../LICENSE).
