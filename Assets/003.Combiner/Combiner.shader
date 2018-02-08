// 最简单的Shader
Shader "SLT/Combiner"
{	
	Properties
	{
		[Header(Albedo)]
		[Space(10)]
		_Color ("Main Color", Color) = (1, 0, 0)
		_MainTex ("Base (RGB)", 2D) = "bump" {}
	}

	SubShader
	{		
		Pass 
		{
			Color [_Color]
			SetTexture[_MainTex] { combine primary * texture }
		}
	}
}
