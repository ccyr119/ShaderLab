// cite: https://docs.unity3d.com/Manual/SL-SetTexture.html
// 这个shader语法上没有问题，不过会导致unity异常，甚至电脑蓝屏
Shader "LTC/Self-Illumination2"
{
	Properties {
        //_IlluminCol ("Self-Illumination color (RGB)", Color) = (1,1,1,1)
        _MainTex ("Base (RGB) Self-Illumination (A)", 2D) = "white" {}
    }
    SubShader {
        Pass {
            // Set up basic white vertex lighting
            Material {
                Diffuse (1,1,1,1)
                Ambient (1,1,1,1)
            }
            Lighting On

            // Use texture alpha to blend up to white (= full illumination)
            SetTexture [_MainTex] {
                // Pull the color property into this blender
                //constantColor [_IlluminCol]
				constantColor (1,1,1,1)
                // And use the texture's alpha to blend between it and
                // vertex color
                combine constant lerp(texture) previous
            }
            // Multiply in texture
            SetTexture [_MainTex] {
                combine previous * texture
            }
        }
    }
}
