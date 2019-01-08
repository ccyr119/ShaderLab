// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/CustomDepth" {
	Properties {
		_DepthTexture ("", 2D) = "white" {}
		_DepthLevel ("Depth Level", Range(1, 3)) = 0.15
	}

	SubShader {
		Tags { "RenderType"="Transparent" }
		Pass {
			CGPROGRAM
		    #pragma vertex vert
		    #pragma fragment frag
		    #include "UnityCG.cginc"
		    //提前定义
		    uniform sampler2D _DepthTexture;
			uniform fixed _DepthLevel;

		    struct uinput
		    {
			     float4 pos : POSITION;
				 half2 uv : TEXCOORD0;
		    };
		    struct uoutput
		    {
			     float4 pos : SV_POSITION;
				 half2 uv : TEXCOORD0;
		    };
		    
		    uoutput vert(uinput i)
		    {
			     uoutput o;
			     o.pos = UnityObjectToClipPos(i.pos);
				 o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, i.uv);
			     return o;
		    }
		    
		    fixed4 frag(uoutput o) : COLOR
		    {
			     //兼容问题
			     float depth = UNITY_SAMPLE_DEPTH(tex2D(_DepthTexture, o.uv));
			     depth = pow(Linear01Depth(depth), _DepthLevel);
                 return depth;
		    }
		    ENDCG
		}
	}
	Fallback Off
}