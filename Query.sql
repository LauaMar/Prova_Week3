-- Query

--Q1: Scrivere una query che restituisca i titoli degli album di Franco Battiato;

SELECT DISTINCT a.Titolo AS [Titolo album]
FROM Album a
INNER JOIN Band b
ON b.ID=a.BandID
WHERE b.Nome = 'Franco Battiato';

-- Una delle query (a scelta) deve essere realizzata come Stored Procedure con parametri.
EXEC sp_AlbumPerBand @NomeBand='Franco Battiato' 

-- Q2: Selezionare tutti gli album editi dalla casa editrice nell’anno specificato;
Select *
From Album a
Where a.CasaDiscografica = 'EMI'
	AND a.AnnoUscita =1988

-- Q3: Scrivere una query che restituisca tutti i titoli delle canzoni dei U2 
-- appartenenti ad album pubblicati prima del 1990;

Select DISTINCT br.Titolo as [Titolo Brano]
FROM (SELECT * FROM Album WHERE AnnoUscita<1990) a
INNER JOIN (SELECT * FROM Band WHERE Nome ='U2') b
ON b.ID=a.BandID
	INNER JOIN AlbumBrano ab
	ON ab.AlbumID=a.ID
		INNER JOIN Brano br
		ON br.ID = ab.BranoID


-- Q4: Individuare tutti gli album in cui è contenuta la canzone “Imagine”;

Select a.Titolo as [Titolo album]
From Album a
INNER JOIN AlbumBrano ab
ON a.ID=ab.AlbumID
	INNER JOIN Brano b
	ON ab.BranoID = b.ID
Where b.Titolo = 'Imagine'

-- Q5: Restituire il numero totale di canzoni eseguite dai Pooh; 

SELECT 
	b.Nome as [Nome Band],
	Count(DISTINCT br.Titolo) as [Totale canzoni]
FROM Album a
INNER JOIN Band b
ON b.ID=a.BandID
	INNER JOIN AlbumBrano ab
	ON ab.AlbumID=a.ID
		INNER JOIN Brano br
		ON br.ID = ab.BranoID
WHERE b.Nome = 'Pooh'
group by b.Nome


-- Q6: Contare per ogni album, la somma dei secondi dei brani contenuti

Select 
	distinct a.titolo as [Titolo Album],
	--a.supporto as [Supporto Album], -- se questa riga viene decommentata, nell'elenco compaiono anche gli Album presenti 
									  -- su più supporti
	SUM(b.Durata) as [Durata Totale in secondi]
from Album a
INNER JOIN AlbumBrano ab
ON a.ID = ab.AlbumID
	INNER JOIN Brano b
	ON ab.BranoID = b.ID
Group by a.titolo, a.Supporto
Order by a.Titolo

--Q7: Creare una view che mostri i dati completi dell’album, della band e dei brani contenuti in esso.

--chiamata alla view
SELECT * 
FROM DatiAlbum 

--Q8 : Scrivere una funzione utente che calcoli per ogni genere musicale quanti album sono inseriti in catalogo.

--Chiama la funzione
SELECT *
FROM dbo.ufnAlbumPerGenere('Pop')

--SELECT
--	a.Genere as [Genere Album],
--	Count(DISTINCT a.Titolo) as [Numero Album]
--FROM Album a
--WHERE a.Genere = 'Pop'
--Group by a.Genere