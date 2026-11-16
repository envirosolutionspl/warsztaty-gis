-- Klienci odcięci po awarii linku – warstwa wirtualna
-- Wymaga w projekcie warstw: linki, klienci
-- Zmień numer linku w linii oznaczonej <-- (id z tabeli atrybutów warstwy linki)
WITH RECURSIVE dotkniete(id) AS (
    SELECT wezel_dst FROM linki WHERE id = 6          -- <-- uszkodzony link
    UNION
    SELECT l.wezel_dst
    FROM linki AS l
    JOIN dotkniete AS d ON l.wezel_src = d.id         -- wszystkie węzły "za" linkiem
)
SELECT k.*
FROM klienci AS k
JOIN dotkniete AS d ON k.id_wezla = d.id
WHERE k.status = 'podłączony'
