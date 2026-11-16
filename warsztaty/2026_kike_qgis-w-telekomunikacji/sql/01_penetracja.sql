-- Penetracja usług w gminach – warstwa wirtualna (Warstwa → Dodaj warstwę → Dodaj/edytuj warstwę wirtualną)
-- Wymaga w projekcie warstw: gminy, budynki
SELECT g.teryt,
       g.nazwa,
       s.budynki,
       s.z_usluga,
       round(100.0 * s.z_usluga / s.budynki, 1) AS penetracja,
       g.geometry
FROM gminy AS g
JOIN (SELECT teryt_gminy,
             count(*) AS budynki,
             sum(CASE WHEN klienci > 0 THEN 1 ELSE 0 END) AS z_usluga
      FROM budynki
      GROUP BY teryt_gminy) AS s
  ON s.teryt_gminy = g.teryt
