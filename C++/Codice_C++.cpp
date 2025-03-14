#include <cstdio>
#include <iostream>
#include <fstream>
#include "dependencies/include/libpq-fe.h"

using namespace std;

void checkResults(PGresult* res, const PGconn* conn) {
	if (PQresultStatus(res) != PGRES_TUPLES_OK) {
		cout << "Risultati Inconsistenti: " << PQerrorMessage(conn) << endl;
		PQclear(res);
		exit(1);
	}
}

void printQuery(PGresult* results, int colonne, int righe) {
	for (int i = 0; i < colonne; ++i) {
		cout << PQfname(results, i);
		if(i+1 != colonne) cout << ",\t\t";
	}
	
	cout << endl;

	for (int i = 0; i < righe; ++i) {
		for (int j = 0; j < colonne; j++) {
			cout << PQgetvalue(results, i, j) << "\t\t";
		}
		cout << endl;
	}

	cout << "FINE OUTPUT" << endl << endl;
}

int main(int argc, char** argv) {
	#define PG_HOST		"127.0.0.1"
	#define PG_USER		"postgres"
	#define PG_DB		"Progetto_FastAuto"
	#define PG_PASS		"FastAuto"
	#define PG_PORT		5432

	char ConnectionInfo[250];
	sprintf(ConnectionInfo, " user =%s password =%s dbname =%s hostaddr =%s port =%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);
	PGconn* conn;
	conn = PQconnectdb(ConnectionInfo);

	if (PQstatus(conn) != CONNECTION_OK) {
		cout << "Errore di Connessione: " << PQerrorMessage(conn);
		exit(1);
	}
	else {
		cout << "Connessione Stabilita" << endl;
		PGresult* res;

		//Query 1
		cout << "Query 1. Contare il numero di clienti con garanzia maggiore o uguale a 3 anni" << endl;
		res = PQexec(conn, "SELECT COUNT(Cl.cf) AS NumGarEstese, Gar.durata FROM Cliente AS Cl, Pagamento AS Pag, Veicolo AS Vei, Garanzia AS Gar WHERE Cl.cf = Pag.cf_cliente AND Pag.sn_veicolo = Vei.sn AND Vei.sn = Gar.sn_veicolo AND Gar.durata >= 3 GROUP BY(Gar.durata); ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 2
		cout << "Query 2. Selezionare i modelli di veicoli venduti con un importo maggiore di 35000 euro ordinandole in ordine decrescente " << endl;
		res = PQexec(conn, "SELECT DISTINCT Vei.modello, Pag.importo FROM Veicolo AS Vei, Pagamento AS Pag WHERE Vei.sn = Pag.sn_veicolo AND Pag.importo >= 35000 ORDER BY(Pag.importo) DESC; ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 3
		cout << "Query 3. Selezionare le marche e i modelli dei veicoli vendute dalla sede di Milano " << endl;
		res = PQexec(conn, " SELECT Vei.marca, Vei.modello, Se.citta FROM Sede AS Se, Pagamento AS Pag, Veicolo AS Vei WHERE Se.citta = Pag.citta_sede AND Pag.sn_veicolo = Vei.sn AND Se.citta = 'Milano'; ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 4
		cout << "Query 4. Calcolare l'importo totale delle vendite effettuate dalle sedi con un numero di dipendenti maggiore di 5 " << endl;
		res = PQexec(conn, "SELECT SUM(Pag.importo) AS SommaTot, Se.citta, COUNT(Dip.codice) AS NumDip FROM Pagamento AS Pag, Sede AS Se, Dipendente AS Dip WHERE Se.citta = Pag.citta_sede AND Se.citta = Dip.citta_sede GROUP BY(Se.citta) HAVING (COUNT(Dip.codice) >= 5); ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 5
		cout << "Query 5. Selezionare i clienti che hanno acquistato una auto usata con più di 70000 km, raggruppando per marca, ordinadoli per i km in modo decrescente " << endl;
		res = PQexec(conn, "SELECT Cl.nome, Cl.cognome, Vei.km, Vei.marca FROM Cliente AS Cl, Pagamento AS Pag, Veicolo AS Vei WHERE Cl.cf = Pag.cf_cliente AND Pag.sn_veicolo = Vei.sn AND Vei.km > 70000 GROUP BY(Cl.cf, Vei.km,Vei.marca) ORDER BY (Vei.km) DESC; ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 6
		cout << "Query 6. Selezionare i meccanici nelle sedi in cui sono state vendute veicoli per una somma maggiore di 70000 euro, ordinandoli per il loro salario " << endl;
		res = PQexec(conn, "SELECT Dip.nome, Dip.cognome, Dip.salario, SUM(Pag.importo) AS SommaTot, Se.citta FROM Pagamento AS Pag, Sede AS Se, Dipendente AS Dip WHERE Se.citta = Pag.citta_sede AND Se.citta = Dip.citta_sede GROUP BY(Dip.nome, Dip.cognome, Dip.salario,Se.citta) HAVING (SUM(Pag.importo) > 70000) ORDER BY Dip.salario DESC; ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		// Query 7
		cout << "Query 7. Selezionare i clienti che hanno scelto il pagamento a rate, calcolando l'importo delle rate arrotondato e ordinandole in modo decrescente " << endl;
		res = PQexec(conn, "SELECT Cl.nome, Cl.cognome, ROUND(Pag.importo/Pag.rate) AS Importo_Rate FROM Cliente AS Cl, Pagamento AS Pag WHERE Cl.cf = Pag.cf_cliente AND Pag.rate is not null ORDER BY (Pag.importo/Pag.rate) DESC ");
		checkResults(res, conn);
		printQuery(res, PQnfields(res), PQntuples(res));
		PQclear(res);

		PQfinish(conn);
	}

	cout << "Fine Programma" << endl;
	cout << "Termine Connessione" << endl;
	PQfinish(conn);
}
