using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : EventHorizonTransition
{
    public Rigidbody rb;

    [Header("Movement Variables")]
    public float walkSpeed;
    public float sprintMultiplier;
    private float sprintSpeed;
    public float strafeMultiplier;
    public float gravity;
    private Vector3 smoothVelocity;
    public Vector3 xVelocity, yVelocity, zVelocity;

    [Header("Jump Variables")]
    public bool isGrounded;
    public Vector3 jumpForce;
    public float groundCheckRadius;
    public LayerMask groundMask;

    [Header("Camera Variables")]
    public Transform cameraTransform;
    public float mouseSensitivity;
    float pitch;
    public float pitchMin, pitchMax;
    public float smoothTimeRot;
    private float smoothYaw, yaw, smoothPitch, yawSmoothRef, pitchSmoothRef;

    private void Start()
    {
        sprintSpeed = walkSpeed * sprintMultiplier;
        rb = GetComponent<Rigidbody>();
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        Movement();
        Rotate();
    }

    public void Movement()
    {
        float forwardSpeed = (Input.GetKey(KeyCode.LeftShift)) ? sprintSpeed : walkSpeed;

        zVelocity = Input.GetAxisRaw("Vertical") * forwardSpeed * transform.forward;
        xVelocity = Input.GetAxisRaw("Horizontal") * forwardSpeed * strafeMultiplier * transform.right;
        yVelocity -= gravity * transform.up * Time.deltaTime;

        if (isGrounded)
        {
            yVelocity = Vector3.zero;
        }

        Vector3 targetVelocity = zVelocity + xVelocity + yVelocity;
      
        rb.velocity = targetVelocity;       
    }

    public void Rotate()
    {
        float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        //yaw += mouseX;
        pitch -= mouseY;
        pitch = Mathf.Clamp(pitch, pitchMin, pitchMax);

        yaw = mouseX;

        //smoothPitch = Mathf.SmoothDampAngle(smoothPitch, pitch, ref pitchSmoothRef, smoothTimeRot);
        //smoothYaw = Mathf.SmoothDampAngle(smoothYaw, mouseX, ref yawSmoothRef, smoothTimeRot);

        cameraTransform.localRotation = Quaternion.Euler(pitch, 0f, 0f);
        transform.Rotate(Vector3.up * yaw);
    }

    public override void Transition(Transform fromPortal, Transform toPortal, Vector3 pos, Quaternion rot)
    {
        transform.position = pos;
        //Vector3 eulerRot = rot.eulerAngles;
        //float delta = Mathf.DeltaAngle(smoothYaw, eulerRot.y);
        //yaw += delta;
        //smoothYaw += delta;
        //transform.Rotate(Vector3.up * smoothYaw);
        //transform.eulerAngles = Vector3.up * smoothYaw;
        //velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(velocity));
        Physics.SyncTransforms();
        isGrounded = true;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.CompareTag("ground"))
        {
            isGrounded = true;
        }
    }

    private void OnCollisionExit(Collision collision)
    {
        if (collision.collider.CompareTag("ground"))
        {
            isGrounded = false;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        isGrounded = true;
        yVelocity = Vector3.zero;
    }
    private void OnTriggerExit(Collider other)
    {
        isGrounded = true;
        yVelocity = Vector3.zero;
    }
    private void OnTriggerStay(Collider other)
    {
        isGrounded = true;
        yVelocity = Vector3.zero;
    }
}
