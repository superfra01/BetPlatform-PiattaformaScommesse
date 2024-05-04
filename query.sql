-1. **Inserimento di un nuovo utente**:
   INSERT INTO Utente (CF, Nome, Cognome, Data_di_nascita, Email, Password, Data_registrazione) 
VALUES ('[codice fiscale]', '[nome]', '[cognome]', '[data di nascita]', '[email]', '[password]', CURDATE());

INSERT INTO Conto (ID_Conto, Utente_CF, Saldo)
VALUES ('[id conto]', '[codice fiscale]', 0.00);

-2. **Visualizzare lo storico schedine di un utente**:
   
   SELECT * FROM Schedina 
   WHERE Utente_CF = '[codice fiscale utente]';
   

-3. **Visualizzare le transazioni di un utente**:
   
   SELECT * FROM Transazione 
   WHERE Utente_CF = '[codice fiscale utente]';
   

-4. **Visualizzare le credenziali di un utente**:
   
   SELECT CF, Nome, Cognome, Email, Password FROM Utente 
   WHERE CF = '[codice fiscale utente]';
   

-5. **Visualizzare il saldo di un utente**:
   
   SELECT Saldo FROM Conto 
   WHERE Utente_CF = '[codice fiscale utente]';
   

-6. **Inserimento di una transazione relativa ad un utente**:
   
   INSERT INTO Transazione (ID_Transazione, Conto_ID_conto, Conto_Utente_CF, Utente_CF, Data, Importo, Conto_esterno, Tipo) 
   VALUES ('[id transazione]', '[id conto]', '[conto utente cf]', '[utente cf]', CURDATE(), [importo], '[conto esterno]', '[tipo]');


    UPDATE Conto SET Saldo = Saldo - ? WHERE ID_Conto = ?

    UPDATE Conto SET Saldo = Saldo + ? WHERE ID_Conto = ?
   
SBAGLIATA?? non crea le Riguardante
-7. **Inserimento di una schedina relativa ad un utente**:
   
   INSERT INTO Schedina (Codice_Scommessa, Utente_CF, Data, Importo_scommesso) 
   VALUES ('[codice scommessa]', '[utente cf]', CURDATE(), [importo scommesso]);
   
-7.5 **inserimento di un riguardante su di una schedina
    
    INSERT INTO Riguardante (Codice_Scommessa, Utente_CF, ID_Partita, Previsione)
    VALUES ('[codice scommessa]', '[codice fiscale utente]', '[id partita]', '[previsione]');
    
-8. **Visualizzazione di una schedina del relativo importo vicibile ed esito**:
   
   SELECT 
    S.Codice_Scommessa, S.Utente_CF, S.Data, S.Importo_scommesso,
    P.ID_Partita, P.Data as Data_Partita, P.Risultato, 
    R.Previsione,
    SQ1.Nome as Squadra_Casa, SQ2.Nome as Squadra_Ospite
    FROM 
        Schedina S
    JOIN 
        Riguardante R ON S.Codice_Scommessa = R.Codice_Scommessa
    JOIN 
        Partita P ON R.ID_Partita = P.ID_Partita
    JOIN 
        Giocata_da G1 ON P.ID_Partita = G1.ID_Partita AND G1.in_casa = TRUE
    JOIN 
        Giocata_da G2 ON P.ID_Partita = G2.ID_Partita AND G2.in_casa = FALSE
    JOIN 
        Squadra SQ1 ON G1.ID_squadra = SQ1.ID_Squadra
    JOIN 
        Squadra SQ2 ON G2.ID_squadra = SQ2.ID_Squadra
    WHERE 
        S.Codice_Scommessa = '[codice scommessa]';
   

-9. **Inserimento di una partita**:
   
    INSERT INTO Partita (ID_Partita, Data, Quota_vittoria, Quota_pareggio, Quota_sconfitta, stato) 
    VALUES ('[id partita]', '[data]', [quota vittoria], [quota pareggio], [quota sconfitta], '[stato]');

    INSERT INTO Giocata_da (ID_Partita, ID_squadra, in_casa) 
    VALUES ('[id partita]', '[id squadra 1]', [true o false]);

    INSERT INTO Giocata_da (ID_Partita, ID_squadra, in_casa) 
    VALUES ('[id partita]', '[id squadra 2]', [true o false]);
   

-10. **Inserimento di una partita riguardante un campionato**:
    
    INSERT INTO Partita (ID_Partita, Data, Quota_vittoria, Quota_pareggio, Quota_sconfitta, stato) 
    VALUES ('[id partita]', '[data]', [quota vittoria], [quota pareggio], [quota sconfitta], '[stato]');

    INSERT INTO Parte_di (ID_Partita, ID_Campionato) 
    VALUES ('[id partita]', '[id campionato]');
    Inserire le due squadre nella tabella Giocata_da:

    INSERT INTO Giocata_da (ID_Partita, ID_squadra, in_casa) 
    VALUES ('[id partita]', '[id squadra 1]', [true o false]);

    INSERT INTO Giocata_da (ID_Partita, ID_squadra, in_casa) 
    VALUES ('[id partita]', '[id squadra 2]', [true o false]);
    

-11. -**conclusione di una partita e inserimento del risultato**:
    
    UPDATE Partita 
    SET stato = 'conclusa'
    SET risultato = '[risultato]' 
    WHERE ID_Partita = '[id partita]';
    

-12. **Inserimento di un campionato**:
    
    INSERT INTO Campionato (ID_Campionato, Nome) 
    VALUES ('[id campionato]', '[nome]');
    

-13. **Visualizzare le squadre relative ad un campionato**:
    
    SELECT s.ID_Squadra, s.Nome, s.Citta_di_Origine, p.posizione
    FROM Squadra s
    JOIN Partecipa_in p ON s.ID_Squadra = p.ID_Squadra
    WHERE p.ID_Campionato = '[id campionato]';
    

-14. **Registrazione di una squadra ed inserimento nel relativo campionato**:
    
    INSERT INTO Squadra (ID_Squadra, Nome, Citta_di_Origine) 
    VALUES ('[id squadra]', '[nome]', '[città di origine]');
    INSERT INTO Partecipa_in (ID_Squadra, ID_Campionato, posizione) 
    VALUES ('[id squadra]', '[id campionato]', [posizione]);
    

-15. **Visualizzare tutte le partite di una squadra**:
    
    SELECT Partita.* 
    FROM Partita 
    JOIN Giocata_da ON Partita.ID_Partita = Giocata_da.ID_Partita 
    WHERE Giocata_da.ID_squadra = '[id squadra]';
    

-16. **Aggiornamento della posizione di una squadra in un campionato**:
    
    UPDATE Partecipa_in 
    SET posizione = [nuova posizione] 
    WHERE ID_Squadra = '[id squadra]' AND ID_Campionato = '[id campionato]';
    

-17. **Visualizzare una partita e le squadre che la giocano**:
    
    SELECT Partita.*, Squadra.Nome 
    FROM Partita 
    JOIN Giocata_da ON Partita.ID_Partita = Giocata_da.ID_Partita 
    JOIN Squadra ON Giocata_da.ID_squadra = Squadra.ID_Squadra 
    WHERE Partita.ID_Partita = '[id partita]';
    
18. **Inserimento di un giocatore in una squadra**:
    
    INSERT INTO Membro (CF, Nome, Cognome, Data_di_nascita, Squadra_ID) 
    VALUES ('[cf]', '[nome]', '[cognome]', '[data di nascita]', [squadra id]);

    INSERT INTO Giocatore (Membro_CF, Numero_di_maglia, Numero_di_goal, Posizione, Titolare) 
    VALUES ('[cf]', [numero di maglia], [numero di goal], '[posizione]', [titolare]);
    


19. **Inserimento di un Allenatore in una squadra**:
    
    INSERT INTO Membro (CF, Nome, Cognome, Data_di_nascita, Squadra_ID) 
    VALUES ('[cf]', '[nome]', '[cognome]', '[data di nascita]', [squadra id]);

    INSERT INTO Allenatore (ID_Allenatore, Membro_CF, Descrizione) 
    VALUES ('[id allenatore]', '[cf]', '[descrizione]');
    

20. **Visualizzazione dei membri di una squadra**:
    
    SELECT 
        M.CF, M.Nome, M.Cognome, M.Data_di_nascita, M.Squadra_ID,
        G.Numero_di_maglia, G.Numero_di_goal, G.Posizione, G.Titolare,
        A.ID_Allenatore, A.Descrizione
    FROM 
        Membro M
    LEFT JOIN 
        Giocatore G ON M.CF = G.Membro_CF
    LEFT JOIN 
        Allenatore A ON M.CF = A.Membro_CF
    WHERE 
        M.Squadra_ID = [id squadra];

21. 
    