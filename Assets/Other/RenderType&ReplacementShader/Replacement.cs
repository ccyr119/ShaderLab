using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class Replacement : MonoBehaviour
{

    public Shader rpShader;
    // Use this for initialization
    void OnEnable()
    {
        //全部替换渲染
        //GetComponent<Camera> ().SetReplacementShader(rpShader,"");
        //RenderType="rpShader中RenderType"的sunshader进行渲染，
        GetComponent<Camera>().SetReplacementShader(rpShader, "RenderType");
    }
}