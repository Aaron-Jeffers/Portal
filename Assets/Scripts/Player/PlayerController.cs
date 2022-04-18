using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : EventHorizonTransition
{
    [SerializeField]
    [Header("Movement Variables", order = 0)]
    public float walkSpeed;
    public float earthSpeedMultiplier, moonSpeedMultiplier, venusSpeedMultiplier;
    float worldSpeedMultiplier;
    public float sprintMultiplier;
    float sprintSpeed;
    public float strafeMultiplier;
    Rigidbody rb;
    public Vector3 xVelocity, yVelocity, zVelocity;

    [SerializeField]
    [Header("Jump Variables", order = 1)]
    public bool isGrounded;
    float earthGravity = -9.81f;
    float moonGravity = -1.62f;
    float venusGravity = -27.6f;
    float gravity;
    public float jumpForce;

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
    AudioManager audioManager;

    private void Start()
    {
        audioManager = FindObjectOfType<AudioManager>();
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
    }

    private void FixedUpdate()
    {
        rb.AddForce(Vector3.up * gravity * rb.mass);
    }
    private void Movement()
    {
        float forwardSpeed = ((Input.GetKey(KeyCode.LeftShift)) ? sprintSpeed : walkSpeed) * worldSpeedMultiplier;

        zVelocity = Input.GetAxisRaw("Vertical") * forwardSpeed * transform.forward;
        xVelocity = Input.GetAxisRaw("Horizontal") * forwardSpeed * strafeMultiplier * transform.right;
        //yVelocity -= gravity * transform.up * Time.deltaTime;

        yVelocity = new Vector3(0, rb.velocity.y, 0);

        Vector3 targetVelocity = zVelocity + xVelocity + yVelocity;     
        rb.velocity = targetVelocity;        
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
        transform.Rotate(Vector3.up * yaw);
    }

    private void Jump()
    {
        if(Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rb.AddForce(Vector3.up * jumpForce);
        }
    }

    public override void Transition(Transform fromPortal, Transform toPortal,string endPortal, Vector3 pos, Quaternion rot)
    {
        transform.position = pos;
        Physics.SyncTransforms();
        isGrounded = true;
        playerCam.GetComponent<FirstPersonCamera>().SwitchSkybox(endPortal);
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
                isGrounded = false;
                break;
        }
    }

    private void OnTriggerStay(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "portal":
                //isGrounded = true;
                //yVelocity = Vector3.zero;
                break;
            case "earthBoundary":                
                gravity = earthGravity;
                break;
            case "moonBoundary":                
                gravity = moonGravity;
                break;
            case "venusBoundary":               
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
                break;
            case "moonBoundary":
                audioManager.PlayAmbientAudio(audioManager.moonAmbient, audioManager.ambientMoonVolume);
                playerLocation = "moon";
                worldSpeedMultiplier = moonSpeedMultiplier;
                break;
            case "venusBoundary":
                audioManager.PlayAmbientAudio(audioManager.venusAmbient, audioManager.ambientVenusVolume);
                playerLocation = "venus";
                worldSpeedMultiplier = venusSpeedMultiplier;
                break;
            default:
                break;
        }
    }
}
