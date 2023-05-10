#define SYS_FREQ 50000000
void set_clk_freq(double target_freq){
     int clk_div =  SYS_FREQ/((target_freq * 2)-1);
     //set slave clk_div register
}