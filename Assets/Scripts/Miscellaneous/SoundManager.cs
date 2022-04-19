using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class SoundManager : MonoBehaviour
{
    public float thudVolume, metalVolume, clickVolume, jumpVolume, metalJumpVolume, moonJumpVolume, ambientEarthVolume, ambientMoonVolume, ambientVenusVolume;
    public float earthPitch, moonPitch, venusPitch;
    public AudioSource audioSourceNoise;
    public AudioSource audioSourceClick;
    public AudioSource audioSourceAmbient;

    public AudioClip thud, jump, moonJump, metalJump, metal, earthAmbient, moonAmbient, venusAmbient, click;

    public void PlayCollisionAudio(float magnitude, float dist, float volume, float pitch, AudioClip clip)
    {

        audioSourceNoise.clip = clip;
        audioSourceNoise.playOnAwake = false;
        audioSourceNoise.volume = magnitude * volume / (dist * dist);
        audioSourceNoise.pitch = pitch;
        audioSourceNoise.PlayOneShot(clip);
    }

    public void PlayAmbientAudio(AudioClip clip, float volume)
    {
        audioSourceAmbient.clip = clip;
        audioSourceAmbient.loop = true;
        audioSourceAmbient.volume = volume;
        audioSourceAmbient.Play();
    }

    public void PlayClickAudio(float magnitude, float dist, float volume, float pitch, AudioClip clip)
    {
        audioSourceClick.clip = clip;
        audioSourceClick.playOnAwake = false;
        audioSourceClick.volume = magnitude * volume / (dist * dist);
        audioSourceClick.pitch = pitch;
        audioSourceClick.PlayOneShot(clip);
    }
}



