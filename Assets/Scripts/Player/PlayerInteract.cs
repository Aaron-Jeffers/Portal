using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using SoundTest;

public class PlayerInteract : MonoBehaviour
{
    Camera playerCam;
    public bool isGrabbing = false;

    //Interactable Object Variables
    public GameObject placeholderHighlightObject;
    GameObject grabObj,highlightObj;
    public float throwForce;
    public float grabDistance;
    public Vector3 grabbedObjectOffset;

    //Portal Manager Variables
    string playerLocation;
    PortalManager portalManager;

    public SoundManager audioManager;

    private void Awake()
    {
        audioManager = FindObjectOfType<SoundManager>();
        highlightObj = placeholderHighlightObject;
        playerCam = GetComponentInChildren<Camera>();
        portalManager = FindObjectOfType<PortalManager>();
    }
    private void Update()
    {
        InputHandler();
        Grab(grabObj);
        HighlightRaycast();
    }

    private void FixedUpdate()
    {
        //HighlightRaycast();
    }

    void InputHandler()
    {
        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            var obj = Raycast(playerCam.transform.position, playerCam.transform.forward,grabDistance).collider;

            if(!obj)
            {
                return;
            }
            switch (obj.tag.ToString())
            {
                case "rock":
                    if(!isGrabbing)
                    {
                        grabObj = obj.gameObject;
                        isGrabbing = true;
                    }                    
                    break;
                case "button":
                    UpdatePortalAddress(obj.gameObject);
                    audioManager.metalJumpVolume = 0;
                    audioManager.jumpVolume = 0;

                    if(playerLocation == "moon")
                    {
                        StartCoroutine(ChangeVolume(0.1f));
                        return;
                    }
                    else if(playerLocation == "earth")
                    {
                        audioManager.PlayClickAudio(1, 1, audioManager.clickVolume, audioManager.earthPitch, audioManager.click);
                    }
                    else if (playerLocation == "venus")
                    {
                        audioManager.PlayClickAudio(1, 1, audioManager.clickVolume, audioManager.venusPitch, audioManager.click);
                    }

                    StartCoroutine(ChangeVolume(0.1f));
                    
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
        highlightObj.SendMessage("Highlight", false, SendMessageOptions.DontRequireReceiver);
        highlightObj = placeholderHighlightObject;
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

    private RaycastHit Raycast(Vector3 startPos, Vector3 direction, float distance)
    {
        RaycastHit hit;

        if (Physics.Raycast(startPos, direction, out hit, distance))
        {
            //Debug.DrawRay(startPos, direction, Color.cyan, distance);
            return hit;
        }
        return hit;
    }
    private void HighlightRaycast()
    {
        if(isGrabbing || !Raycast(playerCam.transform.position, playerCam.transform.forward, grabDistance).collider)
        {
            highlightObj.SendMessage("Highlight", false);
            //highlightObj.GetComponent<Interactable>().Highlight(false);
            return;
        }
       
        highlightObj.SendMessage("Highlight", false);
        //highlightObj.GetComponent<Interactable>().Highlight(false);

        var ray = Raycast(playerCam.transform.position, playerCam.transform.forward, grabDistance);

        if(ray.collider)
        {
            RaycastSwitch(ray);
        }        
    }

    void RaycastSwitch(RaycastHit ray)
    {
        var obj = ray.collider.gameObject;

        switch (obj.tag.ToString())
        {
            case "rock":
                highlightObj = obj;
                highlightObj.SendMessage("Highlight", true);
                //highlightObj.GetComponent<Interactable>().Highlight(true);
                break;

            case "button":
                highlightObj = obj;
                highlightObj.SendMessage("Highlight", true);
                //highlightObj.GetComponent<Interactable>().Highlight(false);
                break;

            case "portal":
                var portal = obj.GetComponent<Portal>();
                if(!portal)
                {
                    return;
                }
                Vector3 newRayPositionOffset = portal.endPortal.gameObject.transform.position - portal.gameObject.transform.position;

                float rayCloneDistance = grabDistance - ray.distance;
                Vector3 newRayPosition = ray.point + newRayPositionOffset;

                var raycastClone = Raycast(newRayPosition, playerCam.transform.forward, rayCloneDistance);
                
                if(raycastClone.collider && (raycastClone.collider.tag == "rock"))
                {
                    highlightObj = raycastClone.collider.gameObject;
                    highlightObj.SendMessage("Highlight", true);

                    if (!isGrabbing && Input.GetKey(KeyCode.Mouse0))
                    {
                        grabObj = highlightObj;
                        isGrabbing = true;
                    }
                }
                break;

            default: 
                break;
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

        obj.transform.position = playerCam.transform.position + (playerCam.transform.forward * 0.75f) + (playerCam.transform.up * 0.5f);
        obj.transform.rotation = playerCam.transform.rotation;

        Rigidbody rb = obj.GetComponent<Rigidbody>();
        rb.isKinematic = false;
        rb.AddForce(throwForce * playerCam.transform.forward);

        float minSpin = 0f, maxSpin = 500f;
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

    IEnumerator ChangeVolume(float time)
    {
        yield return new WaitForSeconds(time);
        audioManager.metalJumpVolume = 0.3f;
        audioManager.jumpVolume = 0.3f;
    }
}
