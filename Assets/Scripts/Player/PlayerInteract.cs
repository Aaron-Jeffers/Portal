using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInteract : MonoBehaviour
{
    Camera playerCam;
    public bool isGrabbing = false;

    //Interactable Object Variables
    public GameObject initHighlightObj;
    GameObject grabObj,highlightObj;
    public float throwForce;
    public float grabDistance;
    public Vector3 grabbedObjectOffset;

    //Portal Manager Variables
    string playerLocation;
    PortalManager portalManager;

    private void Awake()
    {
        highlightObj = initHighlightObj;
        playerCam = GetComponentInChildren<Camera>();
        portalManager = FindObjectOfType<PortalManager>();
    }
    private void Update()
    {
        InputHandler();
        HighlightRaycast();
        Grab(grabObj);
    }

    private void FixedUpdate()
    {
        //HighlightRaycast();
    }

    void InputHandler()
    {
        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            var obj = Raycast();

            switch (obj.collider.tag.ToString())
            {
                case "rock":
                    if(!isGrabbing)
                    {
                        grabObj = obj.collider.gameObject;
                        isGrabbing = true;
                    }                    
                    break;
                case "button":
                    UpdatePortalAddress(obj.collider.gameObject);
                    break;
                default:
                    break;
            }
        }

        if (Input.GetKeyDown(KeyCode.Mouse1) && isGrabbing)
        {
            Throw(grabObj);
        }
    }

    void UpdatePortalAddress(GameObject obj)
    {
        highlightObj.SendMessage("Highlight", false);
        highlightObj = initHighlightObj;
        bool linkCheck;
        switch (playerLocation)
        {
            case "earth":
                linkCheck = portalManager.portals[0].activeSelf;
                HandlePortalConnection(0, 1, 2, 3, linkCheck);
                break;
            case "moon":
                linkCheck = portalManager.portals[1].activeSelf;
                HandlePortalConnection(0, 1, 4, 5, linkCheck);
                break;
            case "venus":
                linkCheck = portalManager.portals[3].activeSelf;
                HandlePortalConnection(2, 3, 4, 5, linkCheck);
                break;
            default:
                break;
        }
    }
    void HandlePortalConnection(int a, int b, int c, int d, bool swap)
    {
        portalManager.portals[a].SetActive(!swap);
        portalManager.portals[b].SetActive(!swap);
        portalManager.portals[c].SetActive(swap);
        portalManager.portals[d].SetActive(swap);
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
            highlightObj.SendMessage("Highlight", false);
            return;
        }
       
        highlightObj.SendMessage("Highlight", false);        
        
        var temp = Raycast().collider.gameObject;

        switch (temp.tag.ToString())
        {
            case "rock":
                highlightObj = temp;
                highlightObj.SendMessage("Highlight", true);
                break;
            case "button":
                highlightObj = temp;
                highlightObj.SendMessage("Highlight", true);
                break;
            default: break;
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

        float minSpin = 0f, maxSpin = 10f;
        Vector3 spin = new Vector3(Random.Range(minSpin, maxSpin), Random.Range(minSpin, maxSpin), Random.Range(minSpin, maxSpin));
        rb.AddTorque(spin, ForceMode.Impulse);
    }

    private void OnTriggerStay(Collider other)
    {
        switch (other.tag.ToString())
        {
            case "earthBoundary":
                playerLocation = "earth";
                break;
            case "moonBoundary":
                playerLocation = "moon";
                break;
            case "venusBoundary":
                playerLocation = "venus";
                break;
            default:
                break;
        }
    }
}
