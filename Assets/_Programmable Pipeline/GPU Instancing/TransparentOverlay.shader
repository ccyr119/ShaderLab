Shader "Custom/TransparentOverlay"
{
	Properties
	{
		_MainTex("MainTex(RGBA)", 2D) = "white" {}
		_GrayTex("GrayTex(RGBA)",2D) = "white" {}
		_CurrentPos("CurrentPos",Range(0,1)) = 1
	}

		SubShader
		{
			LOD 100			
			Lighting Off 
			ZWrite Off 
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha

			Tags
			{
				"Queue" = "Overlay"
				"IgnoreProjector" = "True"
				"RenderType" = "Transparent"
			}

			Pass{
			CGPROGRAM
			#pragma vertex vert  
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"  

			#define TRANSFORM_TEX_INSTANCE(tex,name) (tex.xy * UNITY_ACCESS_INSTANCED_PROP(name##_ST).xy + UNITY_ACCESS_INSTANCED_PROP(name##_ST).zw)

			uniform sampler2D _MainTex;
			uniform sampler2D _GrayTex;

			UNITY_INSTANCING_CBUFFER_START(Props)
				UNITY_DEFINE_INSTANCED_PROP(float, _CurrentPos)
				UNITY_DEFINE_INSTANCED_PROP(float4, _MainTex_ST)
			UNITY_INSTANCING_CBUFFER_END
			//uniform float4 _MainTex_ST;

			struct vertexInput {
				float4 vertex : POSITION;
				float4 texcoord0 : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct fragmentInput {
				float4 position : SV_POSITION;
				float4  texcoord0 : TEXCOORD0;
				half2 uv:TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			fragmentInput vert(vertexInput i) {
				fragmentInput o;

				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_TRANSFER_INSTANCE_ID(i, o);

				o.position = UnityObjectToClipPos(i.vertex);
				o.texcoord0 = i.texcoord0;
				o.uv = TRANSFORM_TEX_INSTANCE(i.texcoord0, _MainTex);
				return o;
			}

			fixed4 frag(fragmentInput i) : SV_Target{
				UNITY_SETUP_INSTANCE_ID(i)

				if(i.texcoord0.y >= UNITY_ACCESS_INSTANCED_PROP(_CurrentPos))
					return tex2D(_GrayTex, i.uv);
				else
					return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
}