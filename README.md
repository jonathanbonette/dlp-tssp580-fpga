# dlp-tssp580-fpga


O projeto tem como objetivo a **implementação e simulação de um sistema de detecção de presença baseado em um sensor infravermelho TSSP580**. Vamos utilizar um FPGA DE10-Lite para gerar um sinal de modulação (burst) de aproximadamente 38 kHz, que aciona um LED emissor, conforme mostra a documentação oficial. Esse sinal modulado é então utilizado para estimular um sensor IR através de um LED, cuja resposta é processada por um filtro digital baseado em contagem no qual elimina ruídos transitórios e garante uma confiabilidade maior na detecção do sensor.<br>

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
<br>1.1- main.vhd
<br>1.2- tb_main.vhd
<br>1.3- do.do

<br>2- fazer a síntese no quartus do led e ver a resposta do sensor
<br>2.1- compilar
<br>2.2- montagem do sensor físico
<br>2.3- verificação no osciloscópio da resposta do sensor led -> sensor

<br>3- fazer a simulação no vscode do sensor
<br>3.1- fazer uma simulação do sinal do sensor (led ja feito, ou seja, a resposta)
<br>3.2- fazer uma simulação simulando o ruído do sensor

<br>4- implementar um filtro na implementação
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
