#!/usr/bin/env bash
# Sprawdza zasady opisane w docs/ZARZADZANIE.md. Uruchamiany przez workflow "Kontrola" i lokalnie:
#   bash .github/scripts/sprawdz.sh
set -uo pipefail

MAKS_MB=50
WZORZEC='^20[0-9]{2}_[a-z0-9]+(-[a-z0-9]+)*(_[a-z0-9]+(-[a-z0-9]+)*)+$'
bledy=0
blad() { echo "BŁĄD: $*"; bledy=$((bledy + 1)); }

cd "$(git rev-parse --show-toplevel)"

for katalog in warsztaty/*/; do
  nazwa=$(basename "$katalog")
  [[ $nazwa =~ $WZORZEC ]] || blad "nazwa katalogu '$nazwa' nie pasuje do wzorca RRRR_wydarzenie_temat"
  for plik in README.md ZRODLA.md; do
    [[ -f $katalog$plik ]] || blad "brak pliku $katalog$plik"
  done
done

while IFS= read -r -d '' plik; do
  [[ $plik == *" "* ]] && blad "spacja w ścieżce: $plik"
  rozmiar=$(stat -c %s "$plik")
  (( rozmiar > MAKS_MB * 1024 * 1024 )) && blad "plik większy niż $MAKS_MB MB (dodaj go do Release): $plik"
  case "$plik" in
    *.qgz) tresc=$(unzip -p "$plik" '*.qgs' 2>/dev/null) ;;
    *.qgs|*.qml|*.qpt|*.cfg|*.model3) tresc=$(cat "$plik") ;;
    *) continue ;;
  esac
  sciezka=$(grep -oE '([A-Za-z]:[\\/](Users|Documents and Settings)|/home/|/Users/)[^"<|]*' <<<"$tresc" | head -1)
  [[ -n $sciezka ]] && blad "ścieżka bezwzględna '$sciezka' w $plik (użyj ścieżki względnej)"
done < <(git ls-files -z warsztaty)

if (( bledy )); then
  echo "Znaleziono błędów: $bledy"
  exit 1
fi
echo "OK: wszystkie zasady spełnione."
