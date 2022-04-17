using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateWorldModels : MonoBehaviour
{
    float rotateSpeed = 45f;

    private void Update()
    {
        this.transform.Rotate(Vector3.up * rotateSpeed * Time.deltaTime);
    }
}
