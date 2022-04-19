using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : EventHorizonTransition
{
    [SerializeField]
    [Header("Movement Variables", order = 0)]
    public float walkSpeed;
    public float earthSpeedMultiplier, moonSpeedMultiplier, venusSpeedMultiplier, spaceStationSpeedMultiplier;
    float worldSpeedMultiplier;
    public float sprintMultiplier;
    float sprintSpeed;
    public float strafeMultiplier;
    Rigidbody rb;
    public Vector3 xVelocity, yVelocity, zVelocity;
    public Transform spaceStationSingularity;
    public Vector3 gravityDirection;
    bool gravityReversed;
    Camera firstPersonCam;
    public bool inSpace;

    [SerializeField]
    [Header("Jump Variables", order = 1)]
    public bool isGrounded;
    float earthGravity = -9.81f;
    float moonGravity = -1.62f;
    float venusGravity = -27.6f;
    float spaceStationGravity = -15f;
    float spaceStationReverseGravity = 60f;
    float gravity;
    public float jumpForce, spaceJumpForce;

    [SerializeField]
    [Header("Camera Variables", order = 2)]
    public Transform cameraTransform;
    Camera playerCam;   
    public float mouseSensitivity;
    float pitch;
    public float pitchMin, pitchMax;
    public float smoothTimeRot;
    float yaw;
    public string playerLocation = "earth";

    //Audio
    public SoundManager audioManager;
    float audioLimit = 0.25f, audioTimer;

    private void Awake()
    {
        firstPersonCam = GetComponentInChildren<Camera>();
        var temp = GameObject.FindGameObjectWithTag("AudioManager");
        audioManager = temp.gameObject.GetComponent<SoundManager>();
    }
    private void Start()
    {
        playerCam = GetComponentInChildren<Camera>();
        sprintSpeed = walkSpeed * sprintMultiplier;
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
        float forwardSpeed = ((Input.GetKey(KeyCode.LeftShift)) ? sprintSpeed : walkSpeed) * worldSpeedMultiplier;

        //zVelocity = Input.GetAxisRaw("Vertical") * forwardSpeed * transform.forward;
        //xVelocity = Input.GetAxisRaw("Horizontal") * forwardSpeed * strafeMultiplier * transform.right;

        float zVel = Input.GetAxisRaw("Vertical") * forwardSpeed ;
        float xVel = Input.GetAxisRaw("Horizontal") * forwardSpeed * strafeMultiplier ;
        //yVelocity -= gravity * transform.up * Time.deltaTime;

        //yVelocity = new Vector3(0, rb.velocity.y, 0);           ///////undo
        //yVelocity = rb.velocity.y * transform.up;
        Vector3 targetVelocity = zVelocity + xVelocity + yVelocity;

        //rb.velocity = targetVelocity;

        if(isGrounded)
        {
            rb.velocity = (rb.velocity.y* transform.up) + (transform.forward * zVel) + (transform.right * xVel);

            //transform.Translate(xVel, 0, zVel);
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


        //yaw += mouseX;
        pitch -= mouseY;
        pitch = Mathf.Clamp(pitch, pitchMin, pitchMax);
        yaw = mouseX;

        cameraTransform.localRotation = Quaternion.Euler(pitch, 0f, 0f);

        /////////transform.Rotate(transform.up * yaw);
        var newgravDir = gravityDirection;
        if(gravity > 3)
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
        transform.rotation = Quaternion.Lerp(transform.rotation, targetRot, 2.5f * Time.deltaTime);

        transform.Rotate(0, yaw, 0);
    }

    private void Jump()
    {
        if(Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            var reverseGravity = 1;
                   
            if (gravityReversed)
            {
                reverseGravity *= -1;
            }
            rb.AddForce((gravityDirection * jumpForce * reverseGravity));
            StartCoroutine(JumpForward(0.01f));                     
        }
    }
    IEnumerator JumpForward(float time)
    {
        yield return new WaitForSeconds(time);
        if(inSpace)
        {
            rb.AddForce((firstPersonCam.transform.forward * jumpForce * 15));
        }
        else
        {
            rb.AddForce((firstPersonCam.transform.forward * jumpForce / 2));
        }
        
    }
    public override void Transition(Transform fromPortal, Transform toPortal,string endPortal, Vector3 pos, Quaternion rot)
    {
        transform.position = pos;
        Physics.SyncTransforms();
        rb.velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.velocity));
        rb.angularVelocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.angularVelocity));
        isGrounded = true;
        playerCam.GetComponent<FirstPersonCamera>().SwitchSkybox(endPortal);
    }

    private void OnCollisionEnter(Collision collision)
    {
        AudioClip jump = audioManager.jump;
        float jumpVolume = audioManager.jumpVolume;

        switch (collision.collider.tag.ToString())
        {
            case "ground":
                isGrounded = true;
                if(collision.collider.name == "Base1"  || collision.collider.name == "Base2" || collision.collider.name == "Base3")
                {
                    jump = audioManager.metalJump;
                    jumpVolume = audioManager.metalJumpVolume;
                }
                if(audioTimer < audioLimit)
                {
                    return;
                }
                if(!(collision.relativeVelocity.y < 2))
                {
                    switch (playerLocation)
                    {
                        case "earth":
                            audioManager.PlayCollisionAudio(1, 1, jumpVolume, audioManager.earthPitch, jump);
                            break;
                        case "venus":
                            audioManager.PlayCollisionAudio(1, 1, jumpVolume, audioManager.venusPitch, jump);
                            break;
                        case "moon":
                            audioManager.PlayCollisionAudio(1, 1, audioManager.moonJumpVolume, audioManager.moonPitch, audioManager.moonJump);
                            break;
                        case "spaceStation":
                            audioManager.PlayCollisionAudio(1, 1, audioManager.moonJumpVolume, audioManager.moonPitch, audioManager.moonJump);
                            break;
                        default:
                            break;
                    }
                }
                 break;
        }
    }

    private void OnCollisionStay(Collision collision)
    {
        switch (collision.collider.tag.ToString())
        {
            case "ground":
                isGrounded = true;
                break;
        }
    }

    private void OnCollisionExit(Collision collision)
    {
        switch (collision.collider.tag.ToString())
        {
            case "ground":
                audioTimer = 0;
                isGrounded = false;
                break;
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
                gravityDirection = new Vector3(0, 1, 0);
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
