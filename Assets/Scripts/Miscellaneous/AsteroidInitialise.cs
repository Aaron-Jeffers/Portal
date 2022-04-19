using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AsteroidInitialise : MonoBehaviour
{
    Vector2 newScaleRange = new Vector2(0.9f, 1.1f);
    Rigidbody rb;
    public Transform trajectory;
    Vector3 initialSpin = new Vector3(25000 , 18000 ,30000);
    float initialForce = 50000000;

    private void Start()
    {
        float oldScale = transform.localScale.x;
        transform.localScale *= Random.Range(newScaleRange.x, newScaleRange.y);
        float newScale = transform.localScale.x;

        float scaleRatio = Mathf.Pow(newScale, 3) / Mathf.Pow(oldScale, 3);
        rb = GetComponent<Rigidbody>();
        rb.mass *= scaleRatio;
        rb.mass = Mathf.RoundToInt(rb.mass);

        rb.AddForce(initialForce * (trajectory.transform.position - transform.position).normalized);
        rb.AddTorque(initialSpin, ForceMode.Impulse);
    }
}
