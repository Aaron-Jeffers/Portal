using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Throwable : EventHorizonTransition
{
    Rigidbody rb;
    float earthGravity = -9.81f;
    float moonGravity = -1.62f;
    float venusGravity = -27.6f;
    float gravity;

    //Audio
    AudioManager audioManager;
    PlayerController player;
    public string environment;
    float audioDelay = -2f, delayLimit = 1f;

    private void Start()
    {
        player = FindObjectOfType<PlayerController>();
        audioManager = FindObjectOfType<AudioManager>();
        rb = GetComponent<Rigidbody>();
        rb.useGravity = false;
    }
    private void FixedUpdate()
    {
        rb.AddForce(Vector3.up * rb.mass * gravity);
        audioDelay += Time.deltaTime;        
    }

    public override void Transition(Transform fromPortal, Transform toPortal, string endPortal, Vector3 pos, Quaternion rot)
    {
        base.Transition(fromPortal, toPortal, endPortal, pos, rot);
        rb.velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.velocity));
        rb.angularVelocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.angularVelocity));
    }

    private void OnTriggerStay(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "earthBoundary":
                environment = "earth";
                gravity = earthGravity;
                break;
            case "moonBoundary":
                environment = "moon";
                gravity = moonGravity;
                break;
            case "venusBoundary":
                environment = "venus";
                gravity = venusGravity;
                break;
            default:
                break;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(environment == "moon" || audioDelay < delayLimit)
        {
            return;
        }
        float pitch;
        if(environment == "earth")
        {
            pitch = audioManager.earthPitch;
        }
        else
        {
            pitch = audioManager.venusPitch;
        }
        float collisionDistanceDropOff = Vector3.Distance(collision.GetContact(0).point, player.GetComponent<Transform>().position);
        switch (collision.gameObject.tag.ToString())
        {           
            case "ground":
                audioDelay = 0;
                audioManager.PlayCollisionAudio(collision.relativeVelocity.magnitude, collisionDistanceDropOff, audioManager.thudVolume, pitch,audioManager.thud);
                break;
            case "tree":
                audioDelay = 0;
                audioManager.PlayCollisionAudio(collision.relativeVelocity.magnitude, collisionDistanceDropOff, audioManager.thudVolume, pitch, audioManager.thud);
                break;
            case "rock":
                audioDelay = 0;
                audioManager.PlayCollisionAudio(collision.relativeVelocity.magnitude, collisionDistanceDropOff, audioManager.thudVolume, pitch, audioManager.thud);
                break;
            case "portal":
                audioDelay = 0;
                audioManager.PlayCollisionAudio(collision.relativeVelocity.magnitude, collisionDistanceDropOff, audioManager.metalVolume, pitch, audioManager.metal);
                break;
            default:
                break;
        }
    }
}
