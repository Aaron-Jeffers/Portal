using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RockInitialise : MonoBehaviour 
{
    Vector2 newScaleRange= new Vector2(0.8f,1.2f);
    Rigidbody rb;

    private void Start()
    {
        float oldScale = transform.localScale.x;               
        transform.localScale *= Random.Range(newScaleRange.x, newScaleRange.y);
        float newScale = transform.localScale.x;

        float scaleRatio = Mathf.Pow(newScale, 3) / Mathf.Pow(oldScale, 3);
        rb = GetComponent<Rigidbody>();
        rb.mass *= scaleRatio;
        rb.mass = Mathf.RoundToInt(rb.mass);
    }
}
