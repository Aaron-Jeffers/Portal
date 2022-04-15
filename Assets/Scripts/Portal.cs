using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Portal : MonoBehaviour
{
    public Portal endPortal;
    public MeshRenderer eventHorizon;

    Camera firstPersonCamera, portalCamera;

    RenderTexture viewTexture;

    List<EventHorizonTransition> transitionObjects;

    private void Awake()
    {
        firstPersonCamera = Camera.main;
        portalCamera = GetComponentInChildren<Camera>();
        portalCamera.enabled = false;
        transitionObjects = new List<EventHorizonTransition>();
    }

    private void LateUpdate()
    {
        Transitions();
    }

    void Transitions()
    {
        for (int i = 0; i < transitionObjects.Count; i++)
        {
            EventHorizonTransition transitioningObject = transitionObjects[i];
            Transform transitioningObjectTransform = transitioningObject.transform;
            var tranObjMatrix = endPortal.transform.localToWorldMatrix * transform.worldToLocalMatrix * transitioningObjectTransform.localToWorldMatrix;

            Vector3 eventHorizonOffset = transitioningObjectTransform.position - transform.position;
            int eventHorizonEntranceParallel = System.Math.Sign(Vector3.Dot(transitioningObject.lastEventHorizonOffset, transform.forward));
            int eventHorizonExitParallel = System.Math.Sign(Vector3.Dot(eventHorizonOffset, transform.forward));

            if (eventHorizonExitParallel != eventHorizonEntranceParallel)
            {
                transitioningObject.Transition(transform, endPortal.transform, tranObjMatrix.GetColumn(3), tranObjMatrix.rotation);

                endPortal.OnObjectPassEventHorizon(transitioningObject);
                transitionObjects.RemoveAt(i);
                i--;
            }
            else
            {
                transitioningObject.lastEventHorizonOffset = eventHorizonOffset;
            }

        }
    }

    public void Render()
    {
        eventHorizon.enabled = false;
        GenerateViewTexture();

        var portalCamMatrix = transform.localToWorldMatrix * endPortal.transform.worldToLocalMatrix * firstPersonCamera.transform.localToWorldMatrix;
        portalCamera.transform.SetPositionAndRotation(portalCamMatrix.GetColumn(3), portalCamMatrix.rotation);

        portalCamera.Render();
        eventHorizon.enabled = true;
    }

    public void RenderComplete()
    {
        HandlePlayerCamTransition(firstPersonCamera.transform.position);
    }

    void GenerateViewTexture()
    {
        if (viewTexture == null || viewTexture.width != Screen.width || viewTexture.height != Screen.height)
        {
            if (viewTexture != null)
            {
                viewTexture.Release();
            }

            viewTexture = new RenderTexture(Screen.width, Screen.height, 0);

            portalCamera.targetTexture = viewTexture;

            endPortal.eventHorizon.material.SetTexture("_MainTex", viewTexture);
        }
    }

    float HandlePlayerCamTransition(Vector3 cameraPosition)
    {
        float eventHorizonHeight, eventHorizonWidth, eventHorizonThickness;
        var nearClipPlane = firstPersonCamera.nearClipPlane;
        var FOV = firstPersonCamera.fieldOfView;
        var cameraAspect = firstPersonCamera.aspect;

        eventHorizonHeight = nearClipPlane * Mathf.Tan(Mathf.Deg2Rad * 0.5f * FOV);
        eventHorizonWidth = cameraAspect * eventHorizonHeight;
        eventHorizonThickness = new Vector3(eventHorizonWidth, eventHorizonHeight, nearClipPlane).magnitude;

        Transform horizonTransform = eventHorizon.transform;
        bool cameraRelativeDirection = Vector3.Dot(transform.forward, transform.position - cameraPosition) > 0;

        var scale = horizonTransform.localScale;
        var pos = horizonTransform.localPosition;

        horizonTransform.localScale = new Vector3(scale.x, scale.y, eventHorizonThickness);
        horizonTransform.localPosition = new Vector3(pos.x, pos.y, 0) + (Vector3.forward * (cameraRelativeDirection ? 0.5f : -0.5f) * eventHorizonThickness);

        return eventHorizonThickness;
    }

    void OnObjectPassEventHorizon (EventHorizonTransition obj)
    {
        if(!transitionObjects.Contains(obj))
        {
            obj.EnterEventHorizon();
            obj.lastEventHorizonOffset = obj.transform.position - transform.position;
            transitionObjects.Add(obj);
        }
    }

    

    private void OnTriggerEnter(Collider obj)
    {
        var transitioningObject = obj.GetComponent<EventHorizonTransition>();
        if(transitioningObject)
        {
            OnObjectPassEventHorizon(transitioningObject);
        }
    }

    private void OnTriggerExit(Collider obj)
    {
        var transitioningObject = obj.GetComponent<EventHorizonTransition>();
        if(transitioningObject && transitionObjects.Contains(transitioningObject))
        {
            transitioningObject.ExitEventHorizon();
            transitionObjects.Remove(transitioningObject);
        }
    }
}
