CREATE TABLE Membro (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Data_di_nascita DATE NOT NULL,
    Squadra_ID INT
);

CREATE TABLE Giocatore (
    Membro_CF VARCHAR(16) NOT NULL,
    Numero_di_maglia INT NOT NULL,
    Numero_di_goal INT NOT NULL,
    Posizione VARCHAR(50) NOT NULL,
    Titolare BOOLEAN NOT NULL,
    PRIMARY KEY (Membro_CF, Numero_di_maglia),
    FOREIGN KEY (Membro_CF) REFERENCES Membro(CF)
);

CREATE TABLE Allenatore (
    ID_Allenatore INT NOT NULL,
    Membro_CF VARCHAR(16) NOT NULL,
    Descrizione TEXT NOT NULL,
    PRIMARY KEY (ID_Allenatore, Membro_CF),
    FOREIGN KEY (Membro_CF) REFERENCES Membro(CF)
);

CREATE TABLE Squadra (
    ID_Squadra INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Citta_di_Origine VARCHAR(100) NOT NULL
);

CREATE TABLE Campionato (
    ID_Campionato INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Partecipa_in (
    ID_Squadra INT NOT NULL,
    ID_Campionato INT NOT NULL,
    posizione INT NOT NULL,
    PRIMARY KEY (ID_Squadra, ID_Campionato),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra),
    FOREIGN KEY (ID_Campionato) REFERENCES Campionato(ID_Campionato)
);

CREATE TABLE Giocata_da (
    ID_Partita INT NOT NULL,
    ID_squadra INT NOT NULL,
    in_casa BOOLEAN NOT NULL,
    PRIMARY KEY (ID_Partita, ID_squadra),
    FOREIGN KEY (ID_squadra) REFERENCES Squadra(ID_Squadra)
);

CREATE TABLE Partita (
    ID_Partita INT PRIMARY KEY,
    Data DATE NOT NULL,
    Quota_vittoria DECIMAL(5,2) NOT NULL,
    Quota_pareggio DECIMAL(5,2) NOT NULL,
    Quota_sconfitta DECIMAL(5,2) NOT NULL,
    stato VARCHAR(50) NOT NULL,
    Risultato VARCHAR(50) 
);

CREATE TABLE Parte_di (
    ID_Partita INT NOT NULL,
    ID_Campionato INT NOT NULL,
    PRIMARY KEY (ID_Partita, ID_Campionato),
    FOREIGN KEY (ID_Partita) REFERENCES Partita(ID_Partita),
    FOREIGN KEY (ID_Campionato) REFERENCES Campionato(ID_Campionato)
);

CREATE TABLE Utente (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Data_di_nascita DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Data_registrazione DATE NOT NULL
);

CREATE TABLE Conto (
    ID_Conto INT PRIMARY KEY,
    Utente_CF VARCHAR(16) NOT NULL,
    Saldo DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Utente_CF) REFERENCES Utente(CF)
);

CREATE TABLE Transazione (
    ID_Transazione INT PRIMARY KEY,
    Conto_ID_conto INT NOT NULL,
    Conto_Utente_CF VARCHAR(16) NOT NULL,
    Utente_CF VARCHAR(16) NOT NULL,
    Data DATE NOT NULL,
    Importo DECIMAL(10,2) NOT NULL,
    Conto_esterno VARCHAR(50) NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (Conto_ID_conto) REFERENCES Conto(ID_Conto),
    FOREIGN KEY (Conto_Utente_CF) REFERENCES Conto(Utente_CF),
    FOREIGN KEY (Utente_CF) REFERENCES Utente(CF)
);

CREATE TABLE Schedina (
    Codice_Scommessa INT NOT NULL,
    Utente_CF VARCHAR(16) NOT NULL,
    Data DATE NOT NULL,
    Importo_scommesso DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(Codice_Scommessa, Utente_CF),
    FOREIGN KEY (Utente_CF) REFERENCES Utente(CF)
);

CREATE TABLE Riguardante (
    Codice_Scommessa INT NOT NULL,
    Utente_CF VARCHAR(16) NOT NULL,
    ID_Partita INT NOT NULL,
    Previsione VARCHAR(50) NOT NULL,
    PRIMARY KEY (Codice_Scommessa, Utente_CF, ID_Partita),
    FOREIGN KEY (Codice_Scommessa, Utente_CF) REFERENCES Schedina(Codice_Scommessa, Utente_CF),
    FOREIGN KEY (ID_Partita) REFERENCES Partita(ID_Partita)
);
