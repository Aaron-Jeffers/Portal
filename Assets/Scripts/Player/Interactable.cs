using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Interactable : MonoBehaviour
{
    Material material;

    private void Start()
    {
        material = gameObject.GetComponent<Renderer>().material;
        material.DisableKeyword("_EMISSION");
    }

    public void Highlight(bool Emmision)
    {
        switch (Emmision)
        {
            case true:
                material.EnableKeyword("_EMISSION");
                break;
            case false:
                material.DisableKeyword("_EMISSION");
                break;
            default:
                break;
        }
    }

    public GameObject GetGameObject()
    {
        return gameObject;
    }
}
