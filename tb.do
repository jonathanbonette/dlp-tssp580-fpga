# Cria biblioteca do projeto
vlib work

# Compila projeto: todos os aquivo. Ordem é importante
# Sempre colocar todos os arquivos .vdh aqui em ordem
vcom tssp580_pwm.vhd
vcom tb_tssp580_pwm.vhd

# Simula
# Sempre mudar a entity aqui caso o nome da entity e arquivo forem diferentes
# ns é a resolução, portanto quanto < escala de tempo + lento fica
vsim -voptargs="+acc" -t ns work.tb_tssp580_pwm

# Mostra forma de onda    
view wave

# Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
# Adicionar aqui os nomes das labels usadas no tb_tssp580_pwm.vdh 
add wave -radix binary -label clk /clk
add wave -radix binary -label reset /reset
add wave -radix binary -label pwm_out /pwm_out
add wave -radix binary -label CLK_PERIOD /CLK_PERIOD

# Simula até 500ns
run 2000ns

wave zoomfull
write wave wave.ps
