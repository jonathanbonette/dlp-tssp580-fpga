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

## Introdução

O projeto tem como objetivo a **implementação e simulação de um sistema de detecção de presença baseado em um sensor infravermelho TSSP580**. Vai ser utilizado um FPGA DE10-Lite para gerar um sinal de modulação (burst) de aproximadamente 38 kHz, que aciona um LED emissor, conforme mostra a documentação oficial. Esse sinal modulado é então utilizado para estimular um sensor IR através de um LED, na qual a resposta é processada por um filtro digital baseado em contagem no qual elimina ruídos transitórios e garante uma confiabilidade maior na detecção do sensor.<br>

Em resumo o desenvolvimento foi dividido em pequenas implementações, cada parte com seu objetivo específico:<br>

### Etapas do Projeto:

**Etapa 1 – Simulação do Módulo LED:** <br>
Implementação da lógica para gerar o sinal modulado (burst) com uma portadora de 38 kHz.

- Desenvolvimento do módulo [led_tx.vhd](vscode/led_tx.vhd).<br>
- Simulação com o testbench [tb_led_tx.vhd](vscode/tb_led_tx.vhd).
- Execução do script [tb_led_tx.do](vscode/tb_led_tx.do).
<p align="center">
  <img src="images/modelsim_burst.png" align="center" width="600" alt="Burst">
</p>

**Etapa 2 – Síntese do LED no FPGA e Testes de Bancada:** <br>
Implementação do arquivo top-level para a síntese e implementação do sistema no FPGA DE10-Lite. Integra os módulos do LED, sensor e filtro, e mapeia os sinais para os pinos físicos.

- Compilação e síntese do projeto no Quartus [de10_lite.vhd](quartus/de10_lite.vhd).
- **todo: adicionar foto do quartus**
- Montagem física do sensor e do LED no FPGA DE10-Lite.
<p align="center">
  <img src="images/fpga_1.jpeg" align="center" width="600" alt="Montagem">
</p>
- Verificação do sinal via osciloscópio.
<p align="center">
  <img src="images/scope_2.png" align="center" width="600" alt="Osciloscópio">
</p>

**Etapa 3 – Simulação do Sensor e dos Ruídos:** <br>
Implementação dos testbenchs para simular a resposta do sensor IR ao sinal de burst e simular ruídos no sinal do sensor, permitindo a avaliação do comportamento em condições adversas.

- Desenvolvimento do testbench [tb_sensor.vhd](vscode/tb_sensor.vhd) para simular a resposta do sensor ao burst e seu script de execução [tb_sensor.do](vscode/tb_sensor.do).
<p align="center">
  <img src="images/modelsim_sensor.png" align="center" width="600" alt="Sensor">
</p>

- Desenvolvimento do testbench [tb_noise.vhd](vscode/tb_noise.vhd) para simular os ruídos e execução dos scripts e seu script de execução [tb_noise.do](vscode/tb_noise.do). 

<p align="center">
  <img src="images/modelsim_noise.png" align="center" width="600" alt="Noise">
</p>

**Etapa 4 – Implementação do Filtro Digital:** <br>
Implementação do filtro digital baseado em contagem tem por objetivo eliminar os ruídos do sensor.

- Desenvolvimento do módulo [filter.vhd](vscode/filter.do) com a lógica de filtro por contagem.
- Simulação com o testbench [tb_filter.vhd](vscode/tb_filter.vhd).
- Execução do script [tb_filter.do](vscode/tb_filter.do).
<p align="center">
  <img src="images/modelsim_filter.png" align="center" width="600" alt="Filter">
</p>




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
