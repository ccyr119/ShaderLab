Shader "ST/AlphaBlending"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader
	{
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Tags {Queue = Transparent}

		BindChannels
		{
			Bind "vertex", vertex
			Bind "Color", color
			Bind "texcoord1", texcoord
		}

		Pass 
		{
			SetTexture[_MainTex]  //{ Combine texture alpha }
		}
	}
}
