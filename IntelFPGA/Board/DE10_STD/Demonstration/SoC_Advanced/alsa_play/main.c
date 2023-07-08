#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include <math.h>


bool Play(float fToneFreq, int ms_dur){
    int i;
    int err;
    snd_pcm_t *playback_handle;
    snd_pcm_hw_params_t *hw_params;
    const char szDevice[] = "default";
    unsigned int actual_rate = 44100;
    const int channels = 2;

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

    sample_num_per_tone = (float)actual_rate / fToneFreq;


    total_sample_num = ms_dur * actual_rate/ 1000.0;




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


typedef struct{
    char szName[32];
    float fFreq;
}TONE_INFO;

typedef struct{
    int ToneID;
    int Dur;
}TONE_PLAY_INFO;

#define DUR 300

int main(int argc, char *argv[])
{
   // QCoreApplication a(argc, argv);
    int i, num, tone_id;
    TONE_INFO szPlayTone[] = {
        {"Do", 261.6},
        {"Re", 293.7},
        {"Mi", 329.6},
        {"Fa", 349.2},
        {"So", 392.0},
        {"La", 440.0},
        {"Si", 493.9},
        {"Do", 523.3} // 261.6x2
    };

    TONE_PLAY_INFO szSong[] = {
        {5, DUR},
        {3, DUR},
        {3, DUR*2},

        {4, DUR},
        {2, DUR},
        {2, DUR*2},

        {1, DUR},
        {2, DUR},
        {3, DUR},
        {4, DUR},

        {5, DUR},
        {5, DUR},
        {5, DUR*2}


    };


    printf("Play Audio\r\n");

    num = sizeof(szPlayTone)/sizeof(szPlayTone[0]);
    for(i=0;i<num;i++){
        printf("%s\r\n", szPlayTone[i].szName);
        Play(szPlayTone[i].fFreq, DUR);
    }


   // printf("Play Audio\r\n");

    num = sizeof(szSong)/sizeof(szSong[0]);
    for(i=0;i<num;i++){
        //printf("%s\r\n", szPlayTone[i].szName);
        tone_id = szSong[i].ToneID-1;
        Play(szPlayTone[tone_id].fFreq, szSong[i].Dur);
    }

    printf("Play done\r\n");

   // return a.exec();
}
