using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Throwable : EventHorizonTransition
{
    Rigidbody rb;
    float earthGravity = -9.81f;
    float moonGravity = -1.62f;
    float gravity;
    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        rb.useGravity = false;
    }
    private void FixedUpdate()
    {
        rb.AddForce(Vector3.up * rb.mass * gravity);
    }
    public override void Transition(Transform fromPortal, Transform toPortal, Vector3 pos, Quaternion rot)
    {
        base.Transition(fromPortal, toPortal, pos, rot);
        rb.velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.velocity));
        rb.angularVelocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.angularVelocity));
        //rb.useGravity = !rb.useGravity;
    }

    private void OnTriggerStay(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "earthBoundary":
                gravity = earthGravity;
                break;
            case "moonBoundary":
                gravity = moonGravity;
                break;
            default:
                break;
        }
    }
}
