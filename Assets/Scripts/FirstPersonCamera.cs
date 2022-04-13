using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FirstPersonCamera : MonoBehaviour
{
    Portal[] portals;

    private void Awake()
    {
        portals = FindObjectsOfType<Portal>();
    }
    private void OnPreCull()
    {
        foreach(var portal in portals)
        {
            
            portal.Render();
        }
    }
}
