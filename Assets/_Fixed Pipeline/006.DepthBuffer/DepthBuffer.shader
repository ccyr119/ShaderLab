Shader "ST/DepthBuffer"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader
	{
		Blend One One
		ZWrite Off
		Tags {Queue = Transparent}

		BindChannels
		{
			Bind "vertex", vertex
			Bind "Color", color
		}

		Pass 
		{
			SetTexture[_MainTex]
		}
	}
}
