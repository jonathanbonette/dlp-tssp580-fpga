<table align="center"><tr><td align="center" width="9999"><br>
<img src="images/logoifsc.png" align="center" width="250" alt="Logo IFSC">

# Implementação e simulação de um sistema de detecção de presença baseado em um sensor infravermelho TSSP580

Instituto Federal de Educação, Ciência e Tecnologia de Santa Catarina<br>
Campus Florianópolis<br>
Departamento Acadêmico de Eletrônica<br>
Dispositivo Lógico Programáveis</b>

*Jonathan Chrysostomo Cabral Bonette*<br>*Matheus Rodrigues Cunha*

#

A utilização de sensores infravermelhos (IR) em aplicações de presença e segurança tem se tornado cada vez mais comum dada sua capacidade de detectar objetos com alta sensibilidade e rapidez, mesmo em ambientes com baixa luminosidade, esses sensores são utilizados em diversas aplicações, como sistemas de alarme, controle de iluminação, detectores de movimento em segurança e interfaces interativas.

Porém em sistemas reais, os sensores IR frequentemente enfrentam desafios decorrentes de ruídos ambientais e interferências de luz ambiente, o que pode comprometer a precisão da detecção. Para reduzir esses problemas, técnicas de modulação e filtragem digital são essenciais. A modulação – no caso deste projeto, a geração de uma portadora de 38 kHz – permite que o sensor seja sensível somente aos sinais modulados, rejeitando grande parte das interferências. Além disso, a implementação de um filtro digital baseado em contagem assegura que somente sinais persistentes (indicativos de uma detecção verdadeira) sejam processados, descartando os ruídos que talvez podem ocorrer durante o burst.

O projeto tem como objetivo implementar e simular um sistema de detecção de presença utilizando o sensor infravermelho TSSP580, utilizando um FPGA DE10-Lite para gerar um sinal de modulação (burst) que aciona um LED emissor, estimulando o sensor IR, assim a resposta do sensor é então processada por um filtro que confirma uma detecção real e assim eliminando os falsos disparos causados por ruídos.

</table>

## Índice
1. [Introdução](#introdução)
2. [Introdução](#introdução)
3. [Revisão Bibliográfica e Fundamentação Teórica](#revisão-bibliográfica-e-fundamentação-teórica)
4. [Metodologia e Estrutura do Projeto](#metodologia-e-estrutura-do-projeto)
5. [Implementação](#implementação)
6. [Síntese e Implementação no FPGA](#síntese-e-implementação-no-fpga)
7. [Resultados e Discussão](#resultados-e-discussão)
8. [Conclusão e Trabalhos Futuros](#conclusão-e-trabalhos-futuros)
9. [Referências](#referências)
10. [Apêndices](#apêndices)

# Introdução
Como descrito, o projeto tem como objetivo a **implementação e simulação de um sistema de detecção de presença baseado em um sensor infravermelho TSSP580**. Vai ser utilizado um FPGA DE10-Lite para gerar um sinal de modulação (burst) de aproximadamente 38 kHz, que aciona um LED emissor, conforme mostra a documentação oficial. Esse sinal modulado é então utilizado para estimular um sensor IR através de um LED, na qual a resposta é processada por um filtro digital baseado em contagem no qual elimina ruídos transitórios e garante uma confiabilidade maior na detecção do sensor.<br>

Em resumo o desenvolvimento foi dividido em pequenas implementações, cada parte com seu objetivo específico:<br>

- O arquvivo principal ```led_tx.vhd```: é responsável pela base da implementação, no qual gera a portadora de 38 kHz e um sinal de burst para simular o disparo do LED.<br>
- O filtro digital ```filter.vhd```: baseado em contagem foi implementado para confirmar a detecção do sensor apenas quando o sinal de entrada permanecer em nível baixo por um número mínimo de ciclos, evitando falsos disparos devido a ruídos.<br>

Posteriormente foram desenvolvidos diversos testbenches para as simulações:<br>
- ```tb_led_tx.vhd```: O comportamento do burst em escala reduzida.<br>
- ```tb_sensor.vhd```: A resposta do sensor ao burst.<br>
- ```tb_noise.vhd```: A resposta do sensor ao burst com ruídos.<br>
- ```tb_filter.vhd```: O desempenho do filtro digital na remoção de ruídos.<br>

E por último o arquivo responsável pela implementação em FPGA ```de10lite.vhd```, integrado em um arquivo top-level e sintetizado no FPGA DE10-Lite, permitindo a verificação prática do sistema via osciloscópio.<br>

Este repositório contém todos os arquivos de código, scripts de simulação e documentação do projeto, proporcionando uma visão completa desde a simulação em ambiente de desenvolvimento (VSCode/ModelSim/Quartus) até a implementação real em hardware.<br>

#




#

#

#

#


**- Modelsim Simulation:**<br>
![img](images/simul_testbench_7_pulses.PNG)	

**- Optical Test:**<br>
![img](images/optical_test_signal.PNG)	

```code ref: test code: optical_test_signal.vhd```

**Cronograma:**<br>
<br>1- fazer a simulação no vscode do led
<br>1.1- led_tx.vhd
<br>1.2- tb_led_tx.vhd
<br>1.3- tb_led_tx.do

Primeiramente implementamos módulo led_tx.vhd para gerar uma portadora de 38 kHz e controlar o burst do LED, permitindo que o sinal seja transmitido.
O código led_tx.vhd gera um sinal infravermelho modulado a 38 kHz, ativando e desativando o LED IR em períodos específicos. Ele funciona com dois contadores: o primeiro gera a portadora de 38 kHz alternando o sinal a cada 13 ciclos, garantindo a frequência correta. O segundo contador controla a modulação do sinal.
Na próxima figura visualizamos a simulação no ModelSim.

![Captura de tela 2025-02-25 150307](https://github.com/user-attachments/assets/3870c294-ac85-4bae-87cf-3780f8b6246b)

<br>2- fazer a síntese no quartus do led e ver a resposta do sensor
<br>2.1- compilar
<br>2.2- montagem do sensor físico
<br>2.3- verificação no osciloscópio da resposta do sensor led -> sensor

<br>3- fazer a simulação no vscode do sensor
<br>3.1- fazer uma simulação do sinal do sensor (led ja feito, ou seja, a resposta)
<br>3.2- fazer uma simulação simulando o ruído do sensor

O código cria um sinal de clock de 1 MHz, um reset inicial e gera uma sequência de ruídos na entrada do 
sensor para verificar sua funcionalidade. O processo sensor_process gera sinais com ruído, alternando entre 0 e 1 por pequenos períodos.

![Captura de tela 2025-02-25 181513](https://github.com/user-attachments/assets/ca869584-6cfe-4e2b-ae89-322db2c77712)

<br>4- implementar um filtro na implementação

O módulo filter.vhd implementa um filtro digital para remover ruídos na entrada do sensor. Foi utilizado um contador para verificar se o sinal de entrada se mantém estável por um número mínimo de ciclos antes de atualizar a saída filtrada. Foi definido um THRESHOLD para ver quantos ciclos consecutivos o sinal deve permanecer alterado antes de ser validado como uma nova leitura. 
Se o sensor mudar de estado rapidamente por um tempo inferior ao definido, a saída permanecerá inalterada, reduzindo a influência de ruídos. O contador é sensível à borda de subida do clock.

![Captura de tela 2025-02-25 182609](https://github.com/user-attachments/assets/f7621ae1-54ea-4c1c-b75f-ddef0019004a)

<br>4.1- testar no osciloscópio (opcional)

<br>5- organizar o git
<br>5.1- renomear arquivos
<br>5.2- organizar folders

<br>6- documentação
<br>6.1- documentar os códigos
<br>6.2- criar documentação estrutural do projeto
<br>6.3- criar estrutura de folders para ser commitado no repositório da disciplina

**files org**:<br>
<br>```tb_led_tx.do``` : relacionado ao led, criando o burst de 38khz
<br>```tb_led_tx.vhd``` : testbench simulando o comportamento do burst em menor escala
<br>```led_tx.vhd``` : arquivo principal referente a implementação do burst

---

<br>```tb_sensor.do``` : relacionado ao sensor, criando a resposta ao burst, ou seja, o sensor de presença
<br>```tb_sensor.vhd``` : testbench simulando o comportamento do sensor em resposta ao burst em menor escala

---

<br>```tb_noise.do``` : relacionado ao ruído
<br>```tb_noise.vhd``` : testbench simulando ruídos durante a simulação em menor escala

---

<br>```tb_filter.do``` : relacionado ao filtro, removendo o ruído apresentado durante a simulação
<br>```tb_filter.vhd``` : testbench simulando o comportamento do filtro removendo ou tratando os ruídos
<br>```filter.vhd``` : arquivo principal referente a implementação do filtro por contagem
