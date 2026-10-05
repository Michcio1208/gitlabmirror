BUDOWA WOLTOMIERZA WARTOŚCI SZCZYTOWEJ

W programie demonstracyjnym pokazano budowę woltomierza z przetwornikiem wartości szczytowej w układzie szeregowym. Projektując taki woltomierz rozważa się przypadek idealny (dioda idealna, źródło o zerowej rezystancji wewnętrznej). W takim przypadku wartość średnia napięcia na wyjściu przetwornika jest równa wartości szczytowej sygnału wejściowego: Uwy0=UweM. Z praw Kirchhoffa wynika zależność: Uwy0=Iv0×(Rd+Rv), przy czym Iv0=Uv0/Rv, gdzie Iv0 jest wartością średnią prądu płynącego przez woltomierz magnetoelektryczny, Uv0 jest wartością średnią napięcia na tym woltomierzu, a Rv jego rezystancją. Stąd: Rd=Rv×(Uwy0/Uv0-1)=Rv×(UweM/Uv0-1).

W obliczeniach trzeba uwzględnić sposób wzorcowania budowanego woltomierza. Jeżeli budowany woltomierz ma pokazywać wartość skuteczną mierzonego sygnału, trzeba wykorzystać zależność: UweM=ka×Usk, gdzie ka jest współczynnikiem amplitudy, a Usk jest wartością skuteczną mierzonego sygnału. Dla sygnału sinusoidalnego ka=sqrt(2).

Aby obliczyć wartość rezystancji Rd, przy której zostanie osiągnięte wychylenie zakresowe miernika, trzeba jako Uv0 podstawić napięcie zakresowe woltomierza magnetoelektrycznego, a jako Usk - napięcie zakresowe budowanego woltomierza.

W przypadku przetwornika rzeczywistego wychylenie wskazówki będzie mniejsze od założonego z powodu występowania zjawisk opisanych w zakładce “Przetworniki wartości szczytowej”. Aby uzyskać wskazanie zakresowe należy:

1) dobrać pojemność C tak, aby uzyskać założoną wartość dolnej częstotliwości poprawnej pracy woltomierza fd10=10/τ, gdzie τ=(Rd+Rv)×C jest stałą czasową rozładowania kondensatora;

2) spełnić warunek f > fd10, gdzie f jest częstotliwością mierzonego sygnału;

3) ustawić doświadczalnie wartość rezystancji Rd, przy której osiągnięte zostanie wychylenie zakresowe miernika.
