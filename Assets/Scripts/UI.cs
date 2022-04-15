using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UI : MonoBehaviour
{
    public Text text1, text2;

    bool textActive = true;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Tab))
        {
            textActive = !textActive;
        }

        text1.GetComponent<Text>().enabled = textActive;
        text2.GetComponent<Text>().enabled = textActive;
    }
}
