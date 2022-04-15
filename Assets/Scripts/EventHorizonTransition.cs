using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventHorizonTransition : MonoBehaviour
{
    public Vector3 lastEventHorizonOffset {get;set;}

    public virtual void Transition (Transform beginningPortal, Transform endPortal, Vector3 pos, Quaternion rot)
    {
        transform.position = pos;
        transform.rotation = rot;
    }

    public virtual void EnterEventHorizon()
    {

    }
    public virtual void ExitEventHorizon()
    {

    }
}
