// 最简单的Shader
Shader "SLT/SolidColor"
{	
	Properties
	{
		[Header(Albedo)]
		[Space(10)]
		_Color ("Main Color", Color) = (1, 0, 0)
	}

	SubShader
	{
		// Color (0, 1, 0)
		Color [_Color]		

		Pass {}
	}
}
