using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : EventHorizonTransition
{
    private CharacterController controller;

    [Header("Movement Variables")]
    public float walkSpeed;
    public float sprintSpeed;
    public float strafeMultiplier;   
    public float gravity;
    public float jumpHeight;

    public Vector3 smoothVelocity;
    public Vector3 jumpForce;
    private Vector3 gravityVel;

    public Transform groundCheck;
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
        controller = GetComponent<CharacterController>();
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        Movement();
        Jump();
        Rotate();
    }

    public void Movement()
    {
        float forwardSpeed = (Input.GetKey(KeyCode.LeftShift)) ? sprintSpeed : walkSpeed;

        Vector3 forwardMovement = Input.GetAxisRaw("Vertical") * transform.forward * forwardSpeed;
        Vector3 sideMovement = Input.GetAxisRaw("Horizontal") * transform.right * walkSpeed * strafeMultiplier;

        gravityVel += gravity * transform.up * Time.deltaTime;

        if (controller.isGrounded)
        {
            gravityVel = 0 * transform.up;
        }

        if (controller.isGrounded && Input.GetButtonDown("Jump"))
        {
            gravityVel = Mathf.Sqrt(jumpHeight * gravity * -2f) * transform.up;
        }

        Vector3 targetVelocity = forwardMovement + sideMovement + gravityVel;

        controller.Move(targetVelocity * Time.deltaTime);
    }

    public void Rotate()
    {
        float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        //yaw += mouseX;
        pitch -= mouseY;
        pitch = Mathf.Clamp(pitch, pitchMin, pitchMax);

        smoothPitch = Mathf.SmoothDampAngle(smoothPitch, pitch, ref pitchSmoothRef, smoothTimeRot);
        smoothYaw = Mathf.SmoothDampAngle(smoothYaw, mouseX, ref yawSmoothRef, smoothTimeRot);

        cameraTransform.localRotation = Quaternion.Euler(smoothPitch, 0f, 0f);
        transform.Rotate(Vector3.up * smoothYaw);
    }

    public void Jump()
    {

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
    }
}
