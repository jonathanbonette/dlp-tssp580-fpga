# Cria biblioteca do projeto
vlib work

# Compila projeto: todos os aquivo. Ordem é importante
# Sempre colocar todos os arquivos .vdh aqui em ordem
vcom optical_test_signal.vhd
vcom tb_optical_test_signal.vhd

# Simula
# Sempre mudar a entity aqui caso o nome da entity e arquivo forem diferentes
# ns é a resolução, portanto quanto < escala de tempo + lento fica
vsim -voptargs="+acc" -t ns work.tb_optical_test_signal

# Mostra forma de onda    
view wave

# Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
# Adicionar aqui os nomes das labels usadas no tb_optical_test_signal.vdh 
add wave -radix binary -label clk /clk
add wave -radix binary -label reset /reset
add wave -radix binary -label test_sig /test_sig
add wave -radix binary -label CLK_PERIOD /CLK_PERIOD

# Simula até 500ns
run 60ms

wave zoomfull
write wave wave.ps
