using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FirstPersonCamera : MonoBehaviour
{
    public Portal[] portals;
    public Material earthSkybox, moonSkybox, venusSkybox;

    private void Start()
    {
        SwitchSkybox("Moon2Earth");
    }
    
    private void OnPreCull()
    {
        foreach (var portal in portals)
        {
            portal.Render();
            portal.RenderComplete();
        }
    }

    public void SwitchSkybox(string portalDirection)
    {
        switch (portalDirection)
        {
            case "Earth2Moon":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Earth2Venus":
                RenderSettings.skybox = venusSkybox;
                break;
            case "Earth2Station":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Moon2Earth":
                RenderSettings.skybox = earthSkybox;
                break;
            case "Moon2Venus":
                RenderSettings.skybox = venusSkybox;
                break;
            case "Moon2Station":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Venus2Earth":
                RenderSettings.skybox = earthSkybox;
                break;
            case "Venus2Moon":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Venus2Station":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Station2Earth":
                RenderSettings.skybox = earthSkybox;
                break;
            case "Station2Moon":
                RenderSettings.skybox = moonSkybox;
                break;
            case "Station2Venus":
                RenderSettings.skybox = venusSkybox;
                break;
            default:
                break;
        }
    }
}
