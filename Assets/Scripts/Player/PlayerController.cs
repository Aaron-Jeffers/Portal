using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : EventHorizonTransition
{
    [SerializeField]
    [Header("Movement Variables", order = 0)]
    public float walkSpeed;
    public float sprintSpeed;
    public float strafeMultiplier;
    public float earthSpeedMultiplier, moonSpeedMultiplier, venusSpeedMultiplier, spaceStationSpeedMultiplier;
    float worldSpeedMultiplier;     
    Rigidbody rb;
    public string playerLocation = "earth";

    [SerializeField]
    [Header("Gravity Variables", order = 1)]
    public Transform spaceStationSingularity;
    Vector3 gravityDirection;
    bool gravityReversed; 
    public bool inSpace;

    [SerializeField]
    [Header("Jump Variables", order = 2)]
    public float jumpForce, spaceJumpForce;
    public float earthGravity;
    public float moonGravity;
    public float venusGravity;
    public float spaceStationGravity;
    public float spaceStationReverseGravity;
    float gravity;
    bool isGrounded;   

    [SerializeField]
    [Header("Camera Variables", order = 3)]
    public Transform cameraTransform;
    Camera firstPersonCam;
    public float mouseSensitivity; 
    public float pitchMin, pitchMax;
    float yaw, pitch;
  

    [SerializeField]
    [Header("Audio Variables", order = 4)]
    SoundManager audioManager;
    float audioLimit = 0.25f, audioTimer;

    private void Awake()
    {
        firstPersonCam = GetComponentInChildren<Camera>();
        audioManager = GameObject.FindGameObjectWithTag("AudioManager").GetComponent<SoundManager>();
        rb = GetComponent<Rigidbody>();
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void Update()
    {
        Movement();
        Rotate();
        Jump();
        audioTimer += Time.deltaTime;       
    }

    private void FixedUpdate()
    {
        rb.AddForce(gravityDirection * gravity * rb.mass);
    }
    private void Movement()
    {
        float speed = ((Input.GetKey(KeyCode.LeftShift)) ? sprintSpeed : walkSpeed) * worldSpeedMultiplier;
        float zVel = Input.GetAxisRaw("Vertical") * speed ;
        float xVel = Input.GetAxisRaw("Horizontal") * speed * strafeMultiplier ;
        if(isGrounded)
        {
            rb.velocity = (rb.velocity.y* transform.up) + (transform.forward * zVel) + (transform.right * xVel);
        }
        else
        {
            rb.velocity = rb.velocity;
        }
    }

    private void Rotate()
    {
        float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        yaw = mouseX;
        pitch -= mouseY;
        pitch = Mathf.Clamp(pitch, pitchMin, pitchMax);
       
        cameraTransform.localRotation = Quaternion.Euler(pitch, 0f, 0f);

        var newgravDir = gravityDirection;
        if (gravity > 3 )
        {
            gravityReversed = true;
            newgravDir *= -1;
        }
        else if (gravity < -1)
        {
            gravityReversed = false;
        }
        var myForward = Vector3.Cross(transform.right, newgravDir);
        var targetRot = Quaternion.LookRotation(myForward, newgravDir);
        transform.rotation = Quaternion.Lerp(transform.rotation, targetRot, 1f * Time.deltaTime);

        transform.Rotate(0, yaw, 0);
    }   

    private void Jump()
    {
        if(Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            var reverseGravity = 1;
            rb.transform.position += transform.up * 0.1f;
            if (gravityReversed)
            {
                reverseGravity *= -1;
            }
            if(playerLocation != "spaceStation")
            {
                rb.AddForce(jumpForce * ((gravityDirection * reverseGravity) + (firstPersonCam.transform.forward / 2)));
            }
            else if(playerLocation == "spaceStation")
            {
                rb.AddForce((firstPersonCam.transform.forward * jumpForce * 15));
                rb.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;
            }  
        }
    }
    public override void Transition(Transform fromPortal, Transform toPortal,string endPortal, Vector3 pos, Quaternion rot)
    {
        transform.position = pos;
        transform.rotation = rot;

        rb.velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.velocity));
        rb.angularVelocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.angularVelocity));
        Physics.SyncTransforms();
        firstPersonCam.GetComponent<FirstPersonCamera>().SwitchSkybox(endPortal);
    }

    void HandleCollisionAudio(float magnitude, float dist, float volume, float pitch, AudioClip clip)
    {
        audioManager.PlayCollisionAudio(magnitude, dist, volume, pitch, clip);
    }

    private void OnCollisionEnter(Collision collision)
    {      
        if(collision.collider.CompareTag("ground"))
        {
            isGrounded = true;
            rb.collisionDetectionMode = CollisionDetectionMode.Discrete;

            if(audioTimer < audioLimit || (collision.relativeVelocity.y < 2))
            {
                return;
            }

            switch (playerLocation)
            {
                case "earth":
                    if (collision.collider.name == "Base1" || collision.collider.name == "Base2" || collision.collider.name == "Base3")
                    {
                        HandleCollisionAudio(1, 1, audioManager.metalJumpVolume, audioManager.earthPitch, audioManager.metalJump);
                    }
                    else
                    {
                        HandleCollisionAudio(1, 1, audioManager.jumpVolume, audioManager.earthPitch, audioManager.jump);
                    }
                    break;
                case "venus":
                    if (collision.collider.name == "Base1" || collision.collider.name == "Base2" || collision.collider.name == "Base3")
                    {
                        HandleCollisionAudio(1, 1, audioManager.metalJumpVolume, audioManager.venusPitch, audioManager.metalJump);
                    }
                    else
                    {
                        HandleCollisionAudio(1, 1, audioManager.jumpVolume, audioManager.venusPitch, audioManager.jump);
                    }
                    break;
                case "moon":
                    HandleCollisionAudio(1, 1, audioManager.moonJumpVolume, audioManager.moonPitch, audioManager.moonJump);
                    break;
                case "spaceStation":
                    HandleCollisionAudio(1, 1, audioManager.moonJumpVolume, audioManager.moonPitch, audioManager.moonJump);
                    break;
                default:
                    break;
            }

        }
    }

    private void OnCollisionExit(Collision collision)
    {
        if(collision.collider.CompareTag("ground"))
        {
            audioTimer = 0;
            isGrounded = false;
        }
    }

    private void OnTriggerStay(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "spaceStationBoundary":
                gravityDirection = (spaceStationSingularity.position - transform.position).normalized;
                jumpForce = spaceJumpForce;
                //gravity = spaceStationGravity * (spaceStationSingularity.position-transform.position).sqrMagnitude / 100000;
                float regualar = spaceStationGravity * Mathf.Pow((Vector3.Distance(spaceStationSingularity.position,transform.position)), 2) / 100000;
                float reverse = spaceStationReverseGravity * (Mathf.Pow((Vector3.Distance(spaceStationSingularity.position, transform.position) - 100), 2) / 100000);
                //gravity += spaceStationReverseGravity * (spaceStationSingularity.position - transform.position).sqrMagnitude / 100000;

                gravity = regualar + reverse;                
                //Debug.Log(gravity + " "+ regualar + " " + reverse);

                break;
            case "portal":
                //gravityDirection = new Vector3(0, 1, 0);               
                jumpForce = 15000;
                break;
            case "earthBoundary":
                gravityDirection = new Vector3(0, 1, 0);
                jumpForce = 15000;
                gravity = earthGravity;
                break;
            case "moonBoundary":
                gravityDirection = new Vector3(0, 1, 0);
                jumpForce = 15000;
                gravity = moonGravity;
                break;
            case "venusBoundary":
                gravityDirection = new Vector3(0, 1, 0);
                jumpForce = 15000;
                gravity = venusGravity;
                break;
            
            default:
                break;
        }

    }

    private void OnTriggerEnter(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "earthBoundary":
                audioManager.PlayAmbientAudio(audioManager.earthAmbient, audioManager.ambientEarthVolume);
                playerLocation = "earth";
                worldSpeedMultiplier = earthSpeedMultiplier;
                inSpace = false;
                break;
            case "moonBoundary":
                audioManager.PlayAmbientAudio(audioManager.moonAmbient, audioManager.ambientMoonVolume);
                playerLocation = "moon";
                worldSpeedMultiplier = moonSpeedMultiplier;
                inSpace = false;               
                break;
            case "venusBoundary":
                audioManager.PlayAmbientAudio(audioManager.venusAmbient, audioManager.ambientVenusVolume);
                playerLocation = "venus";
                worldSpeedMultiplier = venusSpeedMultiplier;
                inSpace = false;
                break;
            case "spaceStationBoundary":
                audioManager.PlayAmbientAudio(audioManager.moonAmbient, audioManager.ambientMoonVolume);
                playerLocation = "spaceStation";
                worldSpeedMultiplier = spaceStationSpeedMultiplier;
                inSpace = true;
                break;
            default:
                break;
        }
    }
}
