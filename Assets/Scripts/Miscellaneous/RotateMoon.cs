using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateMoon : MonoBehaviour
{
    float rotateSpeed = 1f;
    public Transform rotationCentre;
    private void Update()
    {
        //var rot = System.Math.Round(rotateSpeed * Time.realtimeSinceStartup, 6);
        //transform.rotation = Quaternion.Euler(0, rotateSpeed * Time.realtimeSinceStartup, 0);
        transform.RotateAround(rotationCentre.position, rotationCentre.up , rotateSpeed * Time.deltaTime);
    }
}
