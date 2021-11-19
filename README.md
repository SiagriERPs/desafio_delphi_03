# Desafio Controle de Negociação

Quer fazer parte da transformação do campo ~~escrevendo~~ codando o futuro do agronegócio?

Se deseja participar do nosso processo seletivo, siga as instruções deste desafio e execute os seguintes passos: 

* Nos mande sua resolução em um *pull request* neste repositório.


# Sobre a Aliare

A [Aliare](https://www.aliare.co) está entre as maiores empresas de software para agronegócio do país. Nascemos no agro e somos especialistas em levar tecnologia para gestão de empresas e propriedades rurais.

Estamos com nossos clientes, pra fazer o campo acontecer. Temos orgulho de ajudar a construir o presente e o futuro do agronegócio.

# O desafio

Um determinado produtor, precisa comprar insumos para a próxima safra, fertilizantes, agrotóxicos, sementes etc. O processo de compra é realizado alguns meses antes do início do plantio e para garantir bons preços e permitir que a distribuidora de insumos organize seu estoque, geralmente o produtor faz uma negociação de compra com o distribuidor.
Levando em consideração o cenário descrito, deverá ser desenvolvido um aplicativo para controle de negociações, onde será permitido cadastrar negociações entre um produtor e um distribuidor, bem como informar os produtos, quantidades e preços presentes nesta negociação.

### Requisitos

* Deverá ser criado um cadastro de produtor, onde será informado o nome do produtor e seu CPF/CNPJ. Também será possível no cadastro do produtor, informar o limite de crédito que ele tem com cada distribuidor. Lembrando que um produtor pode ter diversos limites de crédito com diversos distribuidores.
* Deverá ser criado um cadastro de distribuidor onde será informado o nome e CNPJ do distribuidor.
* Deverá ser criado um cadastro de produto onde o usuário informará o nome, e seu preço de venda.
* Deverá ser criado uma tela de manutenção de negociação onde o usuário poderá informar os dados para realizar o cadastro ou alteração de uma negociação. Nesta tela o usuário poderá informar o produtor, o distribuidor e os itens da negociação. Deverá ter um campo totalizando a negociação e um informando o status daquela negociação.
* A negociação possui apenas 4 status possíveis, “Pendente”, “Aprovada”, “Concluir” e “Cancelada”. Sempre que uma negociação for gravada o status padrão dela será “Pendente”. Para aprovar, concluir ou cancelar esta negociação existirá uma tela para manutenção de negociação, onde o usuário irá informar o código da negociação pendente e então ele poderá aprovar, concluir ou cancelar.
* O produtor deve possuir crédito para realizar uma negociação, sendo assim no cadastro dos dados do produtor será informado o limite de crédito em reais que ele tem com um determinado distribuidor. Dessa forma caso o produtor deseje efetuar uma negociação que ultrapasse o seu limite de crédito o sistema deverá bloquear.
* Para validar o crédito de um produtor na geração da negociação, o sistema deverá considerar também as negociações aprovadas, assim caso um produtor queira fazer uma negociação no valor de R$ 50.000,00 com um distribuir e ele possuir um limite de R$ 60.000,00 com este distribuidor o sistema deverá permitir, porém se este produto possuir uma outra negociação aprovada de R$ 20.000,00 então o sistema deverá bloquear visto que o limite geral será ultrapassado.
* Deverá ser criado uma tela de consulta de negociações que permita filtrar as negociações de um determinado produtor ou distribuidor, nesta tela também poderemos imprimir um relatório referente as negociações filtradas.
* O relatório deverá exibir o nome do produtor, o nome do distribuidor, o código do contrato, a data de cadastro, a data de aprovação, a data de conclusão, a data de cancelamento caso exista e o valor total do contrato.

  
  Siga abaixo a estrutura de diretórios  já criada para este projeto:
  
![image](https://user-images.githubusercontent.com/28271306/138889763-cfb52e98-4a38-44f0-8cb8-48404732ddd2.png)

	bin: Todos os binários do projeto devem ficar na pasta bin.
	data: Local onde fica o arquivo fdb referente ao banco de dados.
	docs: Neste diretório devem ficar os documentos como scripts para criação da estrutura de tabelas e outros documentos que achar necessário.
	src: Neste diretório deve ficar o código fonte.

## Recomendações

* Utilize [Delphi Community Edition](https://www.embarcadero.com/br/products/delphi/starter);
* Utilize apenas componentes nativos do Delphi Community Edition;
* Para banco de dados utilize Firebird versão 2.1. Pode ser baixado [clicando aqui](http://sourceforge.net/projects/firebird/files/firebird-win32/2.1.7-Release/Firebird-2.1.7.18553_0_Win32.exe/download);
* Utilize boas práticas de codificação, isso será avaliado;
* Desenvolva a aplicação de forma que ela compile facilmente em qualquer equipamento, sem a necessidade de iteração com configurações;
* Mostre que você manja dos paranauê do Delphi;
* Código limpo (clean code), organizado e documentado (quando necessário);
* Use e abuse de:
  * SOLID, GOF, entre outros;
  * Reaproveitamento de código;
  * Criatividade;
  * Performance;
  * Manutenabilidade;
  * Testes Unitários (quando necessário)
  * ... pois avaliaremos tudo isso!
