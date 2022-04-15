using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInteract : MonoBehaviour
{
    Camera playerCam;
    public bool isGrabbing = false;

    //Interactable Object Variables
    GameObject interactObj, highlightObj;
    public float throwForce;
    public float grabDistance;
    public Vector3 grabbedObjectOffset;

    private void Start()
    {
        playerCam = GetComponentInChildren<Camera>();
    }
    private void Update()
    {
        InputHandler();
        HighlightRaycast();
        Grab(interactObj);
    }

    void InputHandler()
    {
        if (Input.GetKeyDown(KeyCode.Mouse0) && !isGrabbing)
        {
            var obj = Raycast();

            if (obj.collider.CompareTag("cube"))
            {
                interactObj = obj.collider.gameObject;
                isGrabbing = true;
            }             
        }

        if (Input.GetKeyDown(KeyCode.Mouse1) && isGrabbing)
        {
            Throw(interactObj);
        }
    }

    private RaycastHit Raycast()
    {
        RaycastHit hit;

        if (Physics.Raycast(playerCam.transform.position, playerCam.transform.forward, out hit, grabDistance))
        {
            return hit;
        }
        return hit;
    }
    private void HighlightRaycast()
    {
        if(isGrabbing || !Raycast().collider)
        {
            return;
        }
        
        if(Raycast().collider.CompareTag("cube"))
        {
            highlightObj = Raycast().collider.gameObject;
            highlightObj.GetComponent<Renderer>().material.EnableKeyword("_EMISSION");
        }

        else if (highlightObj)
        {           
            highlightObj.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
        }
    }

    void Grab(GameObject obj)
    {
        if(obj == null || !isGrabbing)
        {
            return;
        }

        obj.transform.position = playerCam.transform.position + (playerCam.transform.right * grabbedObjectOffset.x) - (playerCam.transform.up * grabbedObjectOffset.y) + (playerCam.transform.forward * grabbedObjectOffset.z);
        obj.transform.rotation = playerCam.transform.rotation;
        obj.GetComponent<Rigidbody>().isKinematic = true;
        highlightObj.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
    }

    void Throw(GameObject obj)
    {
        highlightObj.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
        isGrabbing = false;

        obj.transform.position = playerCam.transform.position + (playerCam.transform.forward * 1.5f) + (playerCam.transform.up * 0.5f);
        obj.transform.rotation = playerCam.transform.rotation;

        Rigidbody rb = obj.GetComponent<Rigidbody>();
        rb.isKinematic = false;
        rb.AddForce(throwForce * playerCam.transform.forward);
    }
}
