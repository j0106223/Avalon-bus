#include <QCoreApplication>
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include "hps_audio.h"

#define SAMPLE_RATE 44100
#define CHANNELS 2
#define SAMPLE_SIZE 16


HPS_AUDIO::HPS_AUDIO()
{

}


bool HPS_AUDIO::PlayTone(TONE_ID ToneID, uint32_t dur_ms){
    bool bSuccess;
    float szToneFreq[] = {261.6, 293.7, 329.6, 349.2, 392.0, 440, 493.9, 523.3, 523.3};

    if (ToneID >= TONE_NUM)
        return false;

    bSuccess = PlayTone(szToneFreq[ToneID], dur_ms);

    return bSuccess;

}


bool HPS_AUDIO::PlayTone(float fToneFrequencyHz, uint32_t dur_ms){
    int i;
    int err;
    snd_pcm_t *playback_handle;
    snd_pcm_hw_params_t *hw_params;
    const char szDevice[] = "default";
    unsigned int actual_rate = SAMPLE_RATE;
    const int channels = CHANNELS;

    snd_pcm_uframes_t max_frames;
    short tone_value, *p;
    char *buff;
    unsigned int time_value, buff_size;
    int total_sample_num, played_sample_num, played_sample_num_cnt;
    float sample_num_per_tone;
    bool bSuccess=true;


    if ((err = snd_pcm_open (&playback_handle, szDevice, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
        fprintf (stderr, "cannot open audio device %s (%s)\n",
             szDevice,
             snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
        fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_any (playback_handle, hw_params)) < 0) {
        fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_set_access (playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
        fprintf (stderr, "cannot set access type (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_set_format (playback_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
        fprintf (stderr, "cannot set sample format (%s)\n",
             snd_strerror (err));
        exit (1);
    }



    if ((err = snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, &actual_rate, 0)) < 0) {
        fprintf (stderr, "cannot set sample rate (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    if ((err = snd_pcm_hw_params_set_channels (playback_handle, hw_params, channels)) < 0) {
        fprintf (stderr, "cannot set channel count (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    /* Write parameters */
    if ((err = snd_pcm_hw_params (playback_handle, hw_params)) < 0) {
        fprintf (stderr, "cannot set parameters (%s)\n",
             snd_strerror (err));
        exit (1);
    }

    snd_pcm_hw_params_free (hw_params);


    snd_pcm_hw_params_get_period_size(hw_params, &max_frames, 0);
    //printf("frames=%d\r\n",(int)max_frames);


    snd_pcm_hw_params_get_period_time(hw_params, &time_value, NULL);
    //printf("period_time=%d\r\n",time_value);

    if ((err = snd_pcm_prepare (playback_handle)) < 0) {
        fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
             snd_strerror (err));
        return false;
        //exit (1);
    }


    /* Allocate buffer to hold PCM waveform */

    sample_num_per_tone = (float)actual_rate / fToneFrequencyHz;


    total_sample_num = dur_ms * actual_rate/ 1000.0;




 //   frames = max_frames/sample_num_per_tone*sample_num_per_tone;


    buff_size = total_sample_num * channels * sizeof(tone_value) /* 2 -> sample size */;
    buff = (char *) malloc(buff_size);


    // generate desired tone (sine wave)

    p = (short *)buff;
    for(i=0;i<(int)total_sample_num;i++){
        tone_value = sin((float)i/sample_num_per_tone * 2.0 * M_PI)*32767.0*0.5; // 50% volume
        // left and right stereo channel
        *p++ = tone_value;
        *p++ = tone_value;
    }

    //for (i = 0; i < 10; ++i) {
    played_sample_num_cnt = 0;
    while(bSuccess && (played_sample_num_cnt < total_sample_num)){
        played_sample_num = total_sample_num - played_sample_num_cnt;
        if (played_sample_num > (int)max_frames)
                played_sample_num = (int)max_frames;
        err = snd_pcm_writei (playback_handle, buff+played_sample_num_cnt*channels*sizeof(tone_value), played_sample_num);
        if (err == -EPIPE){
            printf("XRUN.\n");
            snd_pcm_prepare(playback_handle);
        }else if (err != played_sample_num){
            fprintf (stderr, "write to audio interface failed (%s)\n",
                 snd_strerror (err));
            bSuccess = false;
        }
        played_sample_num_cnt += played_sample_num;
    }

    snd_pcm_drain(playback_handle);
    snd_pcm_close (playback_handle);
    free(buff);

    return bSuccess;

}
