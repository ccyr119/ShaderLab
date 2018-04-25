using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetBlockProps : MonoBehaviour {
    public GameObject[] lstObjects1;
    public GameObject[] lstObjects2;
    public GameObject[] lstObjects3;


    private void SetBlockPros(GameObject[] lstObjects)
    {
        MaterialPropertyBlock props = new MaterialPropertyBlock();
        MeshRenderer renderer;

        foreach (GameObject obj in lstObjects)
        {
            float r = Random.Range(0.0f, 1.0f);
            float g = Random.Range(0.0f, 1.0f);
            float b = Random.Range(0.0f, 1.0f);
            props.SetColor("_Color", new Color(r, g, b));

            renderer = obj.GetComponent<MeshRenderer>();
            renderer.SetPropertyBlock(props);
        }
    }

    private void SetBlockProsFloat(GameObject[] lstObjects)
    {
        MaterialPropertyBlock props = new MaterialPropertyBlock();
        MeshRenderer renderer;
        float tilingX = 1 / 4f;
        foreach (GameObject obj in lstObjects)
        {            
            float arrowIdx = 0.25f * Random.Range(0, 3);
            float len = Random.Range(1f, 500f);
            float percent = Random.Range(0.0f, 1.0f);

            obj.transform.localScale = new Vector3(1f, len, 1f);
            props.SetFloat("_CurrentPos", percent);
            props.SetVector("_MainTex_ST", new Vector4(tilingX, len, arrowIdx, 1));

            renderer = obj.GetComponent<MeshRenderer>();
            renderer.SetPropertyBlock(props);
        }
    }

    // Use this for initialization
    void Start () {
        SetBlockPros(lstObjects1);
        SetBlockPros(lstObjects2);
        SetBlockProsFloat(lstObjects3);
        //StartCoroutine(UpdateColor());
    }

    // Update is called once per frame
    IEnumerator UpdateColor () {       
        while (true)
        {
            SetBlockPros(lstObjects1);
            SetBlockPros(lstObjects2);        
            yield return new WaitForSeconds(0.3f);
        }
    }
}
