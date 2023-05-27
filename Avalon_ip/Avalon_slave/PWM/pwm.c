#define PWM_BASE (0x80008000)
struct pwm {
    int *base;
    int *control;
    int *period;
    int *duty;
};
void init_pwm(struct pwm *pwm_inst, int* base){
    pwm_inst->base    = base;
    pwm_inst->control = base;
    pwm_inst->period  = base + 4;
    pwm_inst->duty    = base + 8;
}   
void set_pwm_period(struct pwm *pwm_inst, int period){
    *(pwm_inst->period) = period;
}

int get_pwm_period(struct pwm *pwm_inst){
    return *(pwm_inst->period);
}
void set_pwm_duty(struct pwm *pwm_inst, int duty){
    *(pwm_inst->duty) = duty;
}
int get_pwm_duty(struct pwm *pwm_inst){
    return *(pwm_inst->duty);
}
void set_pwm_control(struct pwm *pwm_inst, int control){
    *(pwm_inst->control) = control;
}
int get_pwm_control(struct pwm *pwm_inst){
    return *(pwm_inst->control);
}
void enable_pwm(struct pwm *pwm_inst){
    int control;
    control = get_pwm_control(pwm_inst);
    control = control|0x00000001;
    set_pwm_control(pwm_inst, control);
}
void disable_pwm(struct pwm *pwm_inst){
    int control;
    control = get_pwm_control(pwm_inst);
    control = control & (~0x00000001);
    set_pwm_control(pwm_inst, control);
}