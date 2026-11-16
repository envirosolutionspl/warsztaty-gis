# Zaawansowane możliwości QGIS w pracy przedsiębiorstwa telekomunikacyjnego

Wydarzenie: KIKE 2026
Data: 17.11.2026, 16:00–18:00
Prowadzący: Michał Włoga (EnviroSolutions)

## Pobranie materiałów

Pobierz paczkę ZIP z [Release tych warsztatów](https://github.com/envirosolutionspl/warsztaty-gis/releases/tag/2026_kike_qgis-w-telekomunikacji).

## Jak zacząć

1. Rozpakuj cały folder na dysk lokalny (nie pracuj na pendrivie).
2. Otwórz instrukcję: [20261117_KIKE_warsztat_QGIS_instrukcja-v.1.1.pdf](20261117_KIKE_warsztat_QGIS_instrukcja-v.1.1.pdf).
3. W QGIS 3.44 LTR otwórz `projekty/00_start.qgz` i pracuj według instrukcji.

Wszystkie zadania działają bez internetu.

## Zawartość

```
dane/       wielnet.gpkg (dane operatora WielNET, EPSG:2180), zgloszenia.csv (150 adresów)
projekty/   00_start.qgz – początek; 01–05 – punkty kontrolne po zadaniach; 08 – generator geometrii
wyniki/     wyniki.gpkg – gotowe wyniki zadań; karty_wezlow/ – przykładowe karty z atlasu (PDF)
modele/     potencjal_wezla.model3 – model z zadania 4
sql/        zapytania do warstw wirtualnych (zadanie 3)
python/     potencjal_seria.py – skrypt z zadania 6
wydruk/     karta_wezla.qpt – szablon wydruku (zadanie 5), logo
style/      style QML z generatorem geometrii (pokaz 8)
```

## Źródła danych i licencje

Dane są fikcyjne, szczegóły w [ZRODLA.md](ZRODLA.md).
Materiały udostępniane są na licencji [CC BY-NC 4.0](../../LICENSE), kod (`sql/`, `python/`) na licencji [MIT](../../LICENSE-CODE).
