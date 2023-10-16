# web_coding_challenge
Repository created to store the project from Stant's challenge

## Configurações necessárias
### Criação do usuário padrão para o banco de dados
<p>
Antes de criar o banco de dados e rodar as migrações é necessário criar o usuário padrão que possui acesso ao banco.
</br>
Execute o comando (Linux):
</br>
<strong>sudo -u postgres createuser -s tesla -P</strong>
</br>
Informe a senha <strong>'tesla123'</strong>.
</p>

### Criação do banco e migrações
<p>
Após criado o usuário crie o banco e execute as migrações com o comando:
<strong>
rails db:setup
</strong>
</br>ou
</br>
<strong>
rails db:create db:migrate
</strong>
</p>


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