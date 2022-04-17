using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateWorldModels : MonoBehaviour
{
    float rotateSpeed = 45f;

    private void Update()
    {
        //var rot = System.Math.Round(rotateSpeed * Time.realtimeSinceStartup, 6);
        transform.rotation = Quaternion.Euler(0, rotateSpeed * Time.realtimeSinceStartup, 0);
    }
}
