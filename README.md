# Arquitetura:
Divida nas seguintes camadas:

## Camada de dados (data):
  Contém lógica de acesso ao banco de dados, divida da seguinte forma:
  - [AppDatabase](https://github.com/diegoleonds/pdv/blob/main/lib/data/database/app_database.dart): gerencia a instância do banco feito utilizando Drift
  - Dao's: realizam as queries do banco.
  - Repositories: expõe para as demais camadas acesso ao banco. Utilizam os dao's para facilitar refatoração em caso de mudar a lib do banco, além de assim poder incluir outras fontes de dados (ex cache) e gerenciar no mesmo ponto.
  
  <img width="600" height="342" alt="image" src="https://github.com/user-attachments/assets/d731caed-dfe3-4d93-9ff4-cd5d27742759" />

## Domain:
  Contém lógica de negócio, pontes com o nativo e modelos com seus mappers.

## Presentation:
  Contém lógica das telas: feita utilizando Bloc.

# Build:
Pode ser buildado com AS, VSCode ou via terminal como abaixo:
```shell
flutter run  
```

## Items:
Mocks gerados ao criar o banco de dados utilizando o json no arquivo [assets/seed.json](https://github.com/diegoleonds/pdv/blob/main/assets/seed.json)

# Cobertura:
Html foi gerado da seguinte maneira:
```shell
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html  
```
Após disso o relatório pode ser encontrado em coverage/html/index.html

<img width="2244" height="619" alt="image" src="https://github.com/user-attachments/assets/4e34cd6b-7347-468d-a173-5503c192f0c3" />
