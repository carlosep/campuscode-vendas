# Vendas Locaweb

O sistema de Vendas Locaweb é responsável por manter uma base de dados com informações sobre produtos que são vendidos pelo time comercial, pedidos feitos pelo time comercial e os clientes atendidos por este time. Desta forma o time de Vendas Locaweb é capaz de oferecer produtos diferenciados para seus clientes, controlar os pedidos realizados e ter acesso rápido a dados de clientes.

## Descrição do Projeto

### Fluxos de Utilização
O sistema irá permitir diferentes fluxos para criação e manutenção de dados, sendo os principais:

#### Gerenciamento de Planos
Cadastro e manutenção de dados de produtos, prazos de duração de contratos, planos disponíveis e os respectivos valores praticados.

#### Gerenciamento de Clientes
Cadastro e edição de dados de clientes tais como nome, email, telefone, endereço etc, CPF/CNPJ, contato (caso pessoa juridica)

Envio de dados de cadastro via email.

#### Criação de Pedidos
Criação de um pedido contendo um plano e um cliente.

Visualização de pedidos já realizados e edição de status de pedidos.

Conclusão do pedido, notificando o cliente por email.

Cancelamento do pedido
* Pelo vendedor antes da conclusão.
* Pelo admin em qualquer momento.


### Perfis de Usuários

Três perfis diferentes interagem com o sistema direta ou indiretamente:
* **Administrador** : responsável por manter dados sensíveis, como dados de produtos (nome, detalhes, preços, período de uso), dados de vendedores (garantindo ou impedindo o acesso ao sistema) e dados de clientes (consultando e editando informações de clientes e seus pedidos).
* **Vendedor** : responsável por criar pedidos para clientes e por cadastrar e manter atualizados dados dos clientes.
* **Cliente** : recebe notificações sobre pedidos e alterações realizadas em seu cadastro. Eventualmente poderá acessar um painel contendo informações sobre os pedidos realizados.

#### Dados Armazenados

Os dados que serão armazenados e manipulados durante as interações com o sistema são:

* **Cliente** : nome, endereço, CPF/CNPJ, email, telefone, data de nascimento, razão social (opcional), contato (se for PJ).
* **Produto** : nome, descrição completa, ícone, categoria (?), contrato.
* **Categoria** : de Produto: nome, descrição completa. (?)
* **Periodicidade**: nome, período (em dias ou meses).
* **Plano**: produto, prazo de duração.
* **Preço**: plano, valor (em reais).
* **Pedido**: identificador, data de criação, status (aberto, concluído, cancelado), vendedor responsável, cliente, produto.
* **Usuário**: email, senha, perfil (vendedor, administrador).

### Controle de Acesso

O acesso a aplicação poderá ser feito por dois perfis diferentes: administrador ou vendedor. As funcionalidades e telas disponíveis deverão ser controladas de acordo com o perfil do usuário. O acesso será garantido através do uso de um email de identificação e de uma senha.

### Interfaces

O sistema terá toda sua interface regida pelas regras descritas na documentação do Locaweb Style (LocaStyle). Uma possibilidade é o uso de pequenas variações na interface de acordo com o perfil de usuário (administrador ou vendedor).
