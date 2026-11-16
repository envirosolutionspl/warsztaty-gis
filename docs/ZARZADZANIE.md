# Zarządzanie repozytorium warsztatów

Instrukcja dla osób z EnviroSolutions, które dodają lub aktualizują materiały szkoleniowe.

## 1. Zasada ogólna

Jedno repozytorium, jeden katalog na jedne warsztaty w `warsztaty/`.
Każda edycja dostaje paczkę ZIP w zakładce **Releases**, którą uczestnicy pobierają jednym linkiem.

```
warsztaty-gis/
├── README.md              katalog wszystkich warsztatów
├── LICENSE                CC BY-NC 4.0 (materiały)
├── LICENSE-CODE           MIT (kod)
├── docs/ZARZADZANIE.md    ten plik
├── _szablon/              README.md i ZRODLA.md do skopiowania
└── warsztaty/
    ├── 2025_spotkanie-uzytkownikow-qgis_lizmap/
    └── 2026_kike_qgis-w-telekomunikacji/
```

## 2. Nazwa katalogu

Wzorzec: `RRRR_wydarzenie_temat`

- `RRRR` – rok warsztatów,
- `wydarzenie` – nazwa wydarzenia lub klienta (np. `spotkanie-uzytkownikow-qgis`, `kike`),
- `temat` – krótki temat warsztatów (np. `lizmap`, `generator-geometrii`).

Tylko małe litery bez polskich znaków, cyfry i myślniki; części oddziela podkreślenie.
Dokładną datę podaj w README warsztatów.

## 3. Dodanie nowych warsztatów krok po kroku

1. Utwórz katalog `warsztaty/RRRR_wydarzenie_temat/`.
2. Skopiuj do niego `_szablon/README.md` i `_szablon/ZRODLA.md` i uzupełnij.
3. Dodaj materiały. Struktura wewnątrz katalogu jest dowolna; sprawdzona to:
   `dane/`, `projekty/`, `style/`, `sql/`, `python/`, `wyniki/`, instrukcja PDF.
4. Otwórz każdy projekt QGIS z nowej lokalizacji i sprawdź, czy warstwy się wczytują.
5. Dodaj wiersz do tabeli w głównym `README.md`.
6. Zrób commit i push do `main`. Workflow **Kontrola** sprawdzi zasady (punkt 7).
7. Opublikuj paczkę (punkt 6).

## 4. Pliki i dane

| Zasada | Dlaczego |
|--------|----------|
| Pojedynczy plik maks. **50 MB** w repozytorium; większe tylko w Release | duże pliki spowalniają klonowanie dla wszystkich i zostają w historii na zawsze |
| Bez spacji w nazwach plików i katalogów; unikaj polskich znaków | spacje psują linki w README, polskie znaki bywają źle rozpakowywane z ZIP na Windows |
| Ścieżki w projektach QGIS **względne** | ścieżka typu `C:\Users\...` nie zadziała u uczestnika |
| Preferowany format: GeoPackage (`.gpkg`) | jeden plik zamiast kilku plików Shapefile |
| Nie używaj Git LFS | publiczne pobieranie szybko wyczerpuje limit transferu |
| Nie dodawaj danych osobowych ani danych klientów | repozytorium jest publiczne |
| Nie dodawaj haseł do prawdziwych systemów | j.w.; dopuszczalne są tylko hasła do lokalnych maszyn szkoleniowych |

Ścieżki względne w QGIS: *Projekt → Właściwości → Ogólne → Zapisz ścieżki: Względne*.
Przed zapisaniem projektu sprawdź też źródła tabel i atlasu w wydrukach.

Zmniejszenie GeoPackage przed dodaniem: w QGIS *Menedżer baz danych* lub w konsoli `ogrinfo plik.gpkg -sql "VACUUM"`.

### Pliki powyżej 50 MB

1. Nie dodawaj ich do repozytorium.
2. W README warsztatów wpisz je w tabelę „Pobranie materiałów” z adnotacją „Release”.
3. Po utworzeniu Release (punkt 6) wejdź w *Releases → wybrany Release → Edit* i przeciągnij plik w pole *Attach binaries*. Maksymalny rozmiar pliku to 2 GB.

## 5. Źródła danych i licencje

- Materiały (instrukcje, projekty, style, ćwiczenia) – **CC BY-NC 4.0**: wolno korzystać i modyfikować z podaniem autorstwa, bez użytku komercyjnego.
- Kod (`.py`, `.sql`, `.js`, workflow) – **MIT**, chyba że plik ma w nagłówku inną licencję.
- Dane zewnętrzne – licencja źródła. Każdy katalog warsztatów ma `ZRODLA.md` z tabelą: plik, źródło, data pobrania, licencja.
  Jeśli źródło jest nieznane, wpisz „do uzupełnienia”.
- Dane OpenStreetMap wymagają podpisu „© OpenStreetMap contributors” (licencja ODbL).

## 6. Publikacja paczki (Release)

Tag o nazwie katalogu uruchamia workflow **Paczka warsztatów**, który pakuje katalog (z plikami licencji) do ZIP i publikuje Release.

```bash
git tag 2026_kike_qgis-w-telekomunikacji
git push origin 2026_kike_qgis-w-telekomunikacji
```

Poprawiona wersja po warsztatach – dodaj wersję w formacie `-v.X.Y`:

```bash
git tag 2026_kike_qgis-w-telekomunikacji-v.1.1
git push origin 2026_kike_qgis-w-telekomunikacji-v.1.1
```

Bez linii poleceń: *Releases → Draft a new release → Choose a tag* → wpisz nazwę katalogu → *Create new tag* → *Publish release*. Workflow dołączy ZIP po ok. minucie.

Uczestnikom podawaj link do Release, np.
`https://github.com/envirosolutionspl/warsztaty-gis/releases/tag/2026_kike_qgis-w-telekomunikacji`

## 7. Kontrola automatyczna

Workflow **Kontrola** uruchamia `.github/scripts/sprawdz.sh` przy każdym pushu i pull requeście. Sprawdza:

- nazwy katalogów w `warsztaty/`,
- obecność `README.md` i `ZRODLA.md`,
- rozmiar plików (maks. 50 MB),
- spacje w ścieżkach,
- ścieżki bezwzględne w projektach, stylach i szablonach QGIS.

Lokalnie (Git Bash na Windows lub Linux): `bash .github/scripts/sprawdz.sh`

## 8. Praca zespołowa

- Drobne poprawki można commitować bezpośrednio do `main`.
- Nowe warsztaty najlepiej przez gałąź i pull request – druga osoba sprawdza materiały przed publikacją.
- Komunikaty commitów po polsku, w trybie dokonanym: „dodanie danych do ćwiczenia 3”, „poprawa linków w README”.
