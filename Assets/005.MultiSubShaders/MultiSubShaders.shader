Shader "ST/MultiSubShaders"
{
	Properties
	{
		_MainTex ("Base (RGB) (A - Lightmap)", 2D) = "white" {}
		_BlendTex ("Blend (RGB) (A - Mask)", 2D) = "white" {}
	}

	Category
	{
		BindChannels {
			Bind "vertex", Vertex
			Bind "texcoord", texcoord0
			Bind "texcoord1", texcoord1
			Bind "texcoord", texcoord2
			Bind "texcoord1", texcoord3
		}

		// iPhone 3Gs and later
		SubShader
		{
			Pass
			{
				SetTexture[_MainTex] {Combine texture}
				//SetTexture[_BlendTex] { Combine previous, texture }
				SetTexture[_BlendTex] { Combine texture lerp(texture) previous }
				SetTexture[_MainTex] { Combine previous * texture alpha }
			}
		}

		// pre-3GS devices, including the september 2009 8GB iPod touch
		SubShader
		{
			Pass
			{
				SetTexture[_MainTex]
			}

			pass
			{
				Blend SrcAlpha OneMinusSrcAlpha
				SetTexture[_BlendTex]
				SetTexture[_BlendTex] { Combine previous, texture }
			}

			Pass
			{
				Blend Zero SrcAlpha

				BindChannels
				{
					Bind "Vertex", Vertex
					Bind "texcoord1", texcoord
				}

				SetTexture[_MainTex] // { Combine texture alpha }

				SetTexture[_MainTex]
			}
		}
	}	
}
