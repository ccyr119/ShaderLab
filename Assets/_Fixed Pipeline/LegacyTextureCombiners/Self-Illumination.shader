Shader "LTC/Self-Illumination"
{
	Properties
	{		
		_MainTex ("Texture", 2D) = "white" {}		
	}
	SubShader
	{
		Pass
		{
			// Set up basic white vertex Lighting
			Material {
				Diffuse (1, 1, 1, 1)
				Ambient (1, 1, 1, 1)
			}
			Lighting On

			// Use texture alpha to blend up to white (= full illumination)
			SetTexture [_MainTex] { 
				constantColor (1, 1, 1, 1)
				combine constant lerp (texture) previous
			}

			// Multiply in texture
			SetTexture [_MainTex] { combine previous * texture }
		}
	}
}
