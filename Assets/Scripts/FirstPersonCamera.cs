using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FirstPersonCamera : MonoBehaviour
{
    Portal[] portals;
    public Material defaultSkybox, secondarySkybox;
    bool defSkybox = true;

    private void Awake()
    {
        portals = FindObjectsOfType<Portal>();
    }

    private void Start()
    {
        SwitchSkybox();
    }
    private void OnPreCull()
    {
        foreach (var portal in portals)
        {
            portal.RenderPrep();
        }
        foreach (var portal in portals)
        {
            portal.Render();
        }
        foreach (var portal in portals)
        {
            portal.RenderComplete();
        }
    }

    public void SwitchSkybox()
    {
        RenderSettings.skybox = defSkybox ? defaultSkybox : secondarySkybox;
        defSkybox = !defSkybox;
    }
}
