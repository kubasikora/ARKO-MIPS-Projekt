# ARKO-MIPS-Projekt
Projekt z MIPSa z przedmiotu ARKO (Architektura Komputerów) prowadzonego na Wydziale Elektroniki i Technik Informacyjnych Politechniki Warszawskiej

University Project for ARKO (Computers Architecture) course taken at Faculty of Electronic and Information Technology, Warsaw University of Technology 

## Temat projektu
Projekt nr 12: Rysowanie trójpunktowej krzywej Beziera na obrazku BMP

Project no. 12: Drawing a three-point Bezier Curve on BMP image

## Zalecenia
Zalecenia dotyczące pisania projektów (ich nieprzestrzeganie może skutkować obniżeniem oceny lub niezaliczeniem projektu):

- W projektach nalezy używać jedynie typów stałoprzecinkowych i całkowitych.Ze względów dydaktycznych, w projektach MIPS obowiązuje zakaz używania jednostki zmiennopozycyjnej. Będzie ona wykorzystana w projektach x86.
- Obliczeń stałoprzecinkowych NIE wykonujemy w potędze liczby 10.
- Wywołania systemowe (syscalls) wykonują się znacznie dłużej, niż pojedyncze instrukcje. Należy z nich korzystać tylko wtedy gdy jest to niezbędne i nie mnożyć ich ilości (Np. tekst wypisujemy na ekran jednym wywołaniem - cały tekst, a nie litera po literze).
- Skok bezwarunkowy do etykiety znajdującej się za nim, powoduje przerwanie wykonania potoku procesora, nie wnosząc żadnych korzyści. Należy unikać takiej sytuacji.
Przykład:
    ...
    b label5
label5:
    ...
- Należy unikać skoków do krótkich kawałków kodu (skoki ze śladem). Każde użycie pod-procedury powoduje przerwanie wykonania potoku procesora (dwukrotne - skok i powrót). Jej kod można wkleić w miejsce gdzie ma ona zostać wykonana - spowoduje to zwiększenie się rozmiaru programu, ale wielkość pamięci operacyjnej nie stanowi ograniczenia (dodatkowe kilka/dziesiąt linijek kodu vs. gigabajty pamięci operacyjnej).
- Niewyrównany dostęp do pamięci będzie powodował błąd wykonania programu. Do pamięci należy odwoływać się wyłącznie pod adresy podzielne przez długość operandu (Np. adres zapisu/odczytu słowa 32-bitowego musi być podzielny przez 4).
- Operacje modulo, mnożenie i dzielenie przez potęgi liczby 2 (2^n) wykonujemy poprzez maskowanie i przesunięcia bitowe.
Przykłady:
  + (i / (2^n)) równa się (i >> n)
  + (i / 4) równa się (i >> 2) ponieważ (4 = 2^2)
  + (i * (2^n)) równa się (i << n)
  + (i * 8) równa się (i << 3) ponieważ (8 = 2^3)
  + (i % 4) równa się (i & 0x3) przykład: wartość 7 binarnie to b00000111, maska bitowa 0x03 binarnie to b00000011; b00000111 AND b00000011 równa się b00000011; wynik wynosi 3

- Program powinien być czytelny - etykiety - bez wcięć, instrukcje - jedno wcięcie.
- Pętle należy implementować tak, aby przy pierwszym i ostatnim obiegu ilość skoków nie była nadmiarowa (sprawdzenie warunku wejścia - przed pętlą, sprawdzenie warunku na kolejny obieg - na końcu pętli).
- W projektach operujących na obrazkach .bmp uwzględniamy "padding", wczytywane obrazki moga mieć dowolną szerokość.

UWAGA! Powyższa lista to jedynie najważniejsze z wymagań/zaleceń. Projekty powinny uwzględniać wszystkie poruszone na laboratoriach zagadnienia.
