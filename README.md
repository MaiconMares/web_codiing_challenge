# web_coding_challenge
Repository created to store the project from Stant's challenge

## Modelagem do Banco de Dados
### Modelo Entidade Relacionamento - MER

#### Entidades

- CONFERENCE (id, name, duration)
- TRACK (id, name)
- SCHEDULING (id, active, occurrenceDate)

#### Relacionamentos

TRACK - agenda - CONFERENCE
<p>Uma TRACK agenda uma ou mais CONFERENCEs e uma CONFERENCE pode estar associada a somente uma TRACK.</br>
Cardinalidade 1:n</p>

SCHEDULING - agrupa - TRACK
<p>Um SCHEDULING agrupa uma ou mais TRACKs e uma TRACK está associada a somente um SCHEDULING.
</br>
Cardinalidade: 1:n</p>


### Diagrama Entidade Relacionamento - DER
![DER_Web_Coding_Challenge](https://github.com/MaiconMares/web_coding_challenge/assets/47460478/dd9f65d9-35cb-4ee2-9867-f964cacbe1f1)

### Diagrama Lógico de Dados - DLD
![DLD_Web_Coding_Challenge](https://github.com/MaiconMares/web_coding_challenge/assets/47460478/56462bff-e970-4dbf-9ed6-655f208a9457)