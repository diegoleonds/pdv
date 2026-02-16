# pdv

### Build:
Pode ser buildado com AS, VSCode ou via terminal como abaixo:
```shell
flutter run  
```

## Items:
Mocks gerados ao criar o banco de dados utilizando o json no arquivo [assets/seed.json](https://github.com/diegoleonds/pdv/blob/main/assets/seed.json)

### Cobertura:
Html foi gerado da seguinte maneira:
```shell
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html  
```
Após disso o relatório pode ser encontrado em coverage/html/index.html

<img width="2244" height="619" alt="image" src="https://github.com/user-attachments/assets/4e34cd6b-7347-468d-a173-5503c192f0c3" />
