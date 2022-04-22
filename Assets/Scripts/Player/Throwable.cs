using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class Throwable : EventHorizonTransition
{
    Rigidbody rb;
    float earthGravity = -9.81f;
    float moonGravity = -1.62f;
    float venusGravity = -27.6f;
    float spaceStationGravity = -15f;
    float spaceStationReverseGravity = 100f;
    float gravity;
    public Transform spaceStationSingularity;
    public Vector3 gravityDirection;

    //Audio
    public SoundManager audioManager;
    PlayerController player;
    public string environment;
    float audioDelay = -2f, delayLimit = 0.1f;

    private void Awake()
    {
        spaceStationSingularity = GameObject.FindGameObjectWithTag("singularity").transform;
        var temp = GameObject.FindGameObjectWithTag("AudioManager");
        audioManager = temp.gameObject.GetComponent<SoundManager>();
    }
    private void Start()
    {
        player = FindObjectOfType<PlayerController>();        
        rb = GetComponent<Rigidbody>();
        rb.useGravity = false;
    }
    private void FixedUpdate()
    {
        if (environment == "spaceStation")
        {
            gravityDirection = (spaceStationSingularity.position - transform.position).normalized;
        }

        else
        {
            gravityDirection = Vector3.up;
        }
        rb.AddForce(gravityDirection * rb.mass * gravity);
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
            case "spaceStationBoundary":
                environment = "spaceStation";

                //gravity = spaceStationGravity * (spaceStationSingularity.position - transform.position).sqrMagnitude / 100000;

                float regualar = spaceStationGravity * Mathf.Pow((Vector3.Distance(spaceStationSingularity.position, transform.position)), 2) / 100000;
                float reverse = spaceStationReverseGravity * (Mathf.Pow((Vector3.Distance(spaceStationSingularity.position, transform.position) - 100), 2) / 100000);
                //gravity += spaceStationReverseGravity * (spaceStationSingularity.position - transform.position).sqrMagnitude / 100000;

                gravity = regualar + reverse;
                break;
            default:
                break;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(environment == "moon" || environment == "spaceStation" || audioDelay < delayLimit)
        {
            return;
        }
        float pitch;
        if(environment == "earth")
        {
            pitch = audioManager.earthPitch;
        }
        else if (environment == "venus")
        {
            pitch = audioManager.venusPitch;
        }
        else
        {
            pitch = 1;
        }
        float collisionDistanceDropOff = Vector3.Distance(collision.GetContact(0).point, player.GetComponent<Transform>().position);
        switch (collision.gameObject.tag.ToString())
        {           
            case "ground":
                audioDelay = 0;
                audioManager.PlayCollisionAudio(collision.relativeVelocity.magnitude, collisionDistanceDropOff, audioManager.thudVolume, pitch ,audioManager.thud);
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
