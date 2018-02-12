Shader "ST/AlphaBlending2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = .5
	}

	SubShader
	{
		AlphaTest GEqual [_Cutoff]
		//Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		//Tags {Queue = Transparent}

		BindChannels
		{
			Bind "vertex", vertex
			Bind "Color", color
			Bind "texcoord1", texcoord
		}

		Pass 
		{
			SetTexture[_MainTex]  { Combine texture, texture * primary }
		}
	}
}
