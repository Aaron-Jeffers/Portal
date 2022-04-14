using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Throwable : EventHorizonTransition
{
    Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }
    public override void Transition(Transform fromPortal, Transform toPortal, Vector3 pos, Quaternion rot)
    {
        base.Transition(fromPortal, toPortal, pos, rot);
        rb.velocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.velocity));
        rb.angularVelocity = toPortal.TransformVector(fromPortal.InverseTransformVector(rb.angularVelocity));
        rb.useGravity = !rb.useGravity;
    }
}
