using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShadingInWS : MonoBehaviour {

    public Vector4 _Point = new Vector4(1.0f, 1.0f, 1.0f, 1.0f);
    public float _DistanceNear = 10.0f;
    public Color _ColorNear = Color.red;
    public Color _ColorFar = Color.white;

    private Material _sm;
    private bool _dirtyMaterial = true;

    void Start()
    {
        _sm = GetComponent<Renderer>().sharedMaterial;
        UpdateMaterial();
    }    

    private void UpdateMaterial()
    {
        if (_dirtyMaterial)
        {
            if (null != _sm) { 
                _sm.SetVector("_Point", _Point);
                _sm.SetFloat("_DistanceNear", _DistanceNear);
                _sm.SetColor("_ColorNear", _ColorNear);
                _sm.SetColor("_ColorFar", _ColorFar);
            }

            _dirtyMaterial = false;
        }
    }

    // Update is called once per frame
    void Update () {
        UpdateMaterial();
    }

    void OnValidate()
    {
        if (null == _sm)
            _sm = GetComponent<Renderer>().sharedMaterial;
        _dirtyMaterial = true;
        UpdateMaterial();
    }
}
