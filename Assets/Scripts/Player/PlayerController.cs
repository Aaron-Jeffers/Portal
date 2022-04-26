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
    public Transform earthSingularity;
    public Transform moonSingularity;
    public float earthGravity;
    public float moonGravity;
    public float venusGravity;
    public float spaceStationGravityToEdge;
    public float spaceStationGravityToCore;
    public float spaceStationGravityToEarth;
    public float spaceStationGravityToMoon;
    //float gravity;
    //Vector3 gravityDirection;
    bool gravityReversed; 
    public bool inSpace;

    [SerializeField]
    [Header("Jump Variables", order = 2)]
    public float regularJumpForce;
    public float spaceJumpForce;
    private float jumpForce;
    
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

    private void FixedUpdate()
    {
        rb.AddForce(CalculateGravity()[0]);
        Movement();
        Rotate();
        Jump();
        audioTimer += Time.deltaTime;
    }

    private Vector3[] CalculateGravity()
    {
        Vector3[] gravity_gravityDirection;
        Vector3 gravity;
        Vector3 gravityDirection = Vector3.up;

        switch (playerLocation)
        {
            case "earth":
                gravityDirection = Vector3.up;
                gravity = gravityDirection * earthGravity * rb.mass;              
                break;
            case "venus":
                gravityDirection = Vector3.up;
                gravity = gravityDirection * venusGravity * rb.mass;
                
                break;
            case "moon":
                gravityDirection = Vector3.up;
                gravity = gravityDirection * moonGravity * rb.mass;
                break;
            case "spaceStation":                              
                Vector3 gravityDirectionToCore = (spaceStationSingularity.position - transform.position).normalized;
                Vector3 gravityDirectionToEdge = (transform.position - spaceStationSingularity.position).normalized;

               
                //Vector3 gravityDirectionToEarth = (earthSingularity.position - transform.position).normalized;
                //Vector3 gravityDirectionToMoon = (moonSingularity.position - transform.position).normalized;

                float distanceSmooth = 100000;

                float gravityToEdge = spaceStationGravityToEdge * Mathf.Pow((Vector3.Distance(spaceStationSingularity.position, transform.position)), 2) / distanceSmooth;
                float gravityToCore = spaceStationGravityToCore * (Mathf.Pow((Vector3.Distance(spaceStationSingularity.position, transform.position) - 100), 2) / distanceSmooth);

                //Debug.Log("core: " + gravityToCore + "edge: " + gravityToEdge);
                //float gravityToEarth = spaceStationGravityToEarth * Mathf.Pow((Vector3.Distance(earthSingularity.position, transform.position)), 2 - 3500) / distanceSmooth;
                //float gravityToMoon = spaceStationGravityToMoon * Mathf.Pow((Vector3.Distance(moonSingularity.position, transform.position)) - 1800, 2) / distanceSmooth; ;

                Vector3 gravityForce = (gravityDirectionToEdge * gravityToEdge) + (gravityDirectionToCore * gravityToCore);

                float[] gravityStrengths = { gravityToEdge, gravityToCore};
                Vector3[] gravityDirections = { gravityDirectionToEdge, gravityDirectionToCore};

                float max = 0;

                for (int i = 0; i < gravityStrengths.Length; i++)
                {
                    if(Mathf.Sqrt(Mathf.Pow(gravityStrengths[i], 2)) > max)
                    {
                        gravityDirection = gravityDirections[i] * -1;
                        max = gravityStrengths[i];
                    }
                }

                gravity = gravityForce * rb.mass;
                break;
            case "adrift":
                gravity = Vector3.zero;
                gravityDirection = transform.up;
                break;
            default:
                gravityDirection = Vector3.up;
                gravity = gravityDirection * earthGravity * rb.mass;
                break;
        }
        gravity_gravityDirection = new[] {gravity, gravityDirection};

        return gravity_gravityDirection;
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

        
        var myForward = Vector3.Cross(transform.right, CalculateGravity()[1]);
        var targetRot = Quaternion.LookRotation(myForward, CalculateGravity()[1]);
        transform.rotation = Quaternion.Lerp(transform.rotation, targetRot, 1f * Time.deltaTime);           
        
        transform.Rotate(0, yaw, 0);

    }   

    private void Jump()
    {
        if(Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rb.transform.position += transform.up * 0.1f;
    
            if(playerLocation != "spaceStation")
            {
                rb.AddForce(jumpForce * (Vector3.up + (firstPersonCam.transform.forward / 2)));
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

    private void OnCollisionStay(Collision collision)
    {
        if (collision.collider.CompareTag("ground"))
        {
            isGrounded = true;
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

    private void OnTriggerEnter(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "earthBoundary":
                jumpForce = regularJumpForce;
                audioManager.PlayAmbientAudio(audioManager.earthAmbient, audioManager.ambientEarthVolume);
                playerLocation = "earth";
                worldSpeedMultiplier = earthSpeedMultiplier;
                inSpace = false;
                break;
            case "moonBoundary":
                jumpForce = regularJumpForce;
                audioManager.PlayAmbientAudio(audioManager.moonAmbient, audioManager.ambientMoonVolume);
                playerLocation = "moon";
                worldSpeedMultiplier = moonSpeedMultiplier;
                inSpace = false;               
                break;
            case "venusBoundary":
                jumpForce = regularJumpForce;
                audioManager.PlayAmbientAudio(audioManager.venusAmbient, audioManager.ambientVenusVolume);
                playerLocation = "venus";
                worldSpeedMultiplier = venusSpeedMultiplier;
                inSpace = false;
                break;
            case "spaceStationBoundary":
                jumpForce = spaceJumpForce;
                audioManager.PlayAmbientAudio(audioManager.moonAmbient, audioManager.ambientMoonVolume);
                playerLocation = "spaceStation";
                worldSpeedMultiplier = spaceStationSpeedMultiplier;
                inSpace = true;
                break;
            case "portal":             
                jumpForce = regularJumpForce;
                break;
            default:
                break;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "innerSpaceStation":
                playerLocation = "adrift";
                rb.freezeRotation = false;
                rb.angularVelocity = rb.angularVelocity;
                break;
            default:
                break;
        }
    }
}
