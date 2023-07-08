# This sed script is inteded to inserted the text shown below
# before the "chosen" section of the generated
# device tree source. This information should really go 
# into the board info file, but this is a temporary
# hack that should get the job done.
#
#       leds {
#               compatible = "gpio-leds";
#               led0 {
#                       gpios = <&led_pio 0 1>;
#                       label = "led0";
#               };
#               led1 {
#                       gpios = <&led_pio 1 1>;
#                       label = "led1";
#               };
#               led2 {
#                       gpios = <&led_pio 2 1>;
#                       label = "led2";
#               };
#               led3 {
#                       gpios = <&led_pio 3 1>;
#                       label = "led3";
#               };
#       };
#
#
s/^\schosen/\tleds {\n\t\tcompatible = "gpio-leds";\n\t\tfpga0 {\n\t\t\tgpios = <\&led_pio 0 1>;\n\t\t\tlabel = "fpga_led0";\n\t\t};\n\t\tfpga1 {\n\t\t\tgpios = <\&led_pio 1 1>;\n\t\t\tlabel = "fpga_led1";\n\t\t};\n\t\tfpga2 {\n\t\t\tgpios = <\&led_pio 2 1>;\n\t\t\tlabel = "fpga_led2";\n\t\t};\n\t\tfpga3 {\n\t\t\tgpios = <\&led_pio 3 1>;\n\t\t\tlabel = "fpga_led3";\n\t\t};\n\t\thps0 {\n\t\t\tgpios = <\&hps_0_gpio1 15 1>;\n\t\t\tlabel = "hps_led0";\n\t\t};\n\t\thps1 {\n\t\t\tgpios = <\&hps_0_gpio1 14 1>;\n\t\t\tlabel = "hps_led1";\n\t\t};\n\t\thps2 {\n\t\t\tgpios = <\&hps_0_gpio1 13 1>;\n\t\t\tlabel = "hps_led2";\n\t\t};\n\t\thps3 {\n\t\t\tgpios = <\&hps_0_gpio1 12 1>;\n\t\t\tlabel = "hps_led3";\n\t\t};\n\t};\n&/
#
# This little bit adds "arm,tag-latency = <1 1 1>;" and 
# "arm,data-latency = <2 1 1>;" to the L2 cache node.
s/\scache-unified;.*/&\n\t\t\tarm,tag-latency = <1 1 1>;\n\t\t\tarm,data-latency = <2 1 1>;/
