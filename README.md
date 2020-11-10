# Teste back-end - Credere

### Descrição

Uma sonda exploradora da NASA pousou em marte. O pouso se deu em uma área retangular, na qual a sonda pode navegar usando uma interface web. A posição da sonda é representada pelo seu eixo x e y, e a direção que ele está apontado pela letra inicial, sendo as direções válidas:

- `E` - Esquerda
- `D` - Direita
- `C` - Cima
- `B` - Baixo

A sonda aceita três comandos:

- `GE` - girar 90 graus à esquerda
- `GD` - girar 90 graus à direta
- `M` - movimentar. Para cada comando `M` a sonda se move uma posição na direção à qual sua face está apontada.

A sonda inicia no quadrante (x = 0, y = 0), o que se traduz como a casa mais inferior da esquerda; também inicia com a face para a direita.
Se pudéssemos visualizar a posição inicial, seria:

| (0,4) |  (1,4) | (2,4) |  (3,4) | (4,4) |
|:-----:|  ----  |  ---- |  ----  |  ---- |
| (0,3) |  (1,3) | (2,3) |  (3,3) | (4,3) |
| (0,2) |  (1,2) | (2,2) |  (3,2) | (4,2) |
| (0,1) |  (1,1) | (2,1) |  (3,1) | (4,1) |
| * >   |  (1,0) | (2,0) |  (3,0) | (4,0) |

`* Indica a direção inicial da nossa sonda`

A intenção é controlar a sonda enviando a direção e quantidade de movimentos que ela deve executar. A resposta deve ser sua coordenada final caso o ponto se encontre dentro do quadrante, caso o ponto não possa ser alcançado a resposta deve ser um erro indicando que a posição é inválida. Para a execução do teste as dimensões de 5x5 pode ser usado.

### Endpoints

Esperamos três endpoints, um que envie a sonda para a posição inicial (0,0); outro deve receber o movimento da sonda e responder com as coordenadas finais, caso o movimento seja válido ou erro caso o movimento seja inválido; e o terceiro deve responder apenas com as coordenadas atuais x e y da sonda.

Consideramos que um movimento para cima é o mesmo que dizer `(x + 1, y)` e um movimento para a direita é o mesmo que `(x, y + 1)`.

Cada comando aceita uma série de movimentos que a sonda pode executar. Uma sugestão seria um endpoint que recebe um array com uma sequência de movimentos (mas essa é apenas uma sugestão, fique à vontade para usar outra abordagem caso você encontre um motivo prático para isso).

Exemplo:

```
{
  movimentos: ['GE', 'M', 'M', 'M', 'GD', 'M', 'M']
}
```

A resposta deve ser:

```
{
  x: 2,
  y: 3
}
```

E a descrição da sequência de movimentos:

```a sonda girou para a esquerda, se moveu 3 casas no eixo y, virou para a direita e andou mais duas casas no eixo x.```

A visualização da posição após esses movimentos seria a seguinte:

| (0,4) |  (1,4) | (2,4) |  (3,4) | (4,4) |
| ----- |  ---- |:----:|  ---- | ---- |
| (0,3) |  (1,3) |   >   |  (3,3) | (4,3) |
| (0,2) |  (1,2) | (2,2) |  (3,2) | (4,2) |
| (0,1) |  (1,1) | (2,1) |  (3,1) | (4,1) |
| (0,0) |  (1,0) | (2,0) |  (3,0) | (4,0) |

**A visualização tem o intuíto de facilitar sua compreensão, ela não deve estar contida em nenhuma etapa do exercício e nem é necessária.**

Exemplos de movimento inválido seriam os seguintes:

```
{
  movimentos: ['GD', 'M', 'M']
}
```

ou

```
{
  movimentos: ['M', 'M', 'M', 'M', 'M', 'M']
}
```

A resposta pode ser algo como:

```
{
  "erro": "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"
}
```

O erro aconteceu porque no primeiro caso a sonda estava no ponto inicial e foi virada para a direção fora do limite do quadrante. No segundo caso a sonda ultrapassou o limite que era de cinco casas, tentando se mover para a posição y = 0, x= 6, passando do quadrante limite.  ~~Infelizmente nosso time de engenharia desenvolveu rodas muito sensíveis.~~

O outro enpoint deve indicar a posição e retornar algo como:

```
{
  x: 3,
  y: 2,
  face: E
}
```

O enpoint de resetar a posição pode não ter retorno, apenas indicando que a ação foi bem sucedida pelo cabeçalho da requisição.

### Entrega

É permitido fazer o teste em qualquer linguagem moderna de backend (C#, Javascript, Go, PHP, Python, Ruby, Java), assim como respectivos frameworks.

Iremos avaliar desde a lógica, passando pelos testes, número de dependências e boas práticas, desde nomeclatura até o uso correto dos verbos HTTP.

Gostaríamos que a solução contivesse as instruções de como ser executada localmente, além de ser deployada em algum serviço de hospedagem moderno como Heroku, AWS, Azure ou Digital Ocean. E claro, com a documentação para o uso da API, no formato desejado, podendo ser em markdown.

Também lembramos que testes automatizados são muito importantes para nós, então mesmo que não esteja habituado com essa prática gostaríamos de ver testes, sejam unitários ou de integração.

Não temos prazo para entrega. De qualquer maneira, se por algum motivo você não puder entregar o teste completo, fique à vontade para enviar, assim avaliaremos a parte entregue e consideraremos que a parte não entregue é opcional e não alguma falta de entendimento e/ou erro.
