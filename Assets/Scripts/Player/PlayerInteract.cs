using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

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
        var temp = GameObject.FindGameObjectWithTag("AudioManager");
        audioManager = temp.gameObject.GetComponent<SoundManager>();
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
        List<int> activePortals = ActivePortals();
        switch (playerLocation)
        {           
            case "earth":
                if(activePortals[0] == 0)
                {
                    activePortals.Add(1);
                    activePortals.Add(6);
                }
                else if(activePortals[0] == 1)
                {
                    activePortals.Add(2);
                    activePortals.Add(9);
                }
                else if (activePortals[0] == 2)
                {
                    activePortals.Add(0);
                    activePortals.Add(3);
                }
                
                break;
            case "moon":
                if (activePortals[0] == 0)
                {
                    activePortals.Add(4);
                    activePortals.Add(7);
                }
                else if (activePortals[0] == 4)
                {
                    activePortals.Add(5);
                    activePortals.Add(10);
                }
                else if (activePortals[0] == 5)
                {
                    activePortals.Add(0);
                    activePortals.Add(3);
                }
                break;
            case "venus":
                if (activePortals[0] == 1)
                {
                    activePortals.Add(4);
                    activePortals.Add(7);
                }
                else if (activePortals[0] == 4)
                {
                    activePortals.Add(8);
                    activePortals.Add(11);
                }
                else if (activePortals[0] == 8)
                {
                    activePortals.Add(1);
                    activePortals.Add(6);
                }
                break;
            case "spaceStation":
                if (activePortals[0] == 2)
                {
                    activePortals.Add(5);
                    activePortals.Add(10);
                }
                else if (activePortals[0] == 5)
                {
                    activePortals.Add(8);
                    activePortals.Add(11);
                }
                else if (activePortals[0] == 8)
                {
                    activePortals.Add(2);
                    activePortals.Add(9);
                }
                break;
            default:
                break;
        }

        HandlePortalConnection(activePortals[0], activePortals[1], activePortals[2], activePortals[3]);
    }

    List<int> ActivePortals()
    {
        List<int> activePortals = new List<int>();

        for (int i = 0; i < portalManager.portals.Count; i++)
        {
            if(portalManager.portals[i].activeSelf)
            {
                activePortals.Add(i);
            }
        }
        return activePortals;
    }
    void HandlePortalConnection(int active1, int active2, int nextActive1, int nextActive2)
    {
        portalManager.portals[active1].SetActive(false);
        portalManager.portals[active2].SetActive(false);
        portalManager.portals[nextActive1].SetActive(true);
        portalManager.portals[nextActive2].SetActive(true);
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
            case "spaceStationBoundary":
                playerLocation = "spaceStation";
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
