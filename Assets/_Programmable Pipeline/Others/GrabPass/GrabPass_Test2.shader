Shader "Custom/Other/GrabPass_Test2" {	
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Opaque" }
		LOD 200
		
		GrabPass {"_GrabTex"}
		
		pass{		
            CGPROGRAM
                       
            
            #pragma vertex vert
            #pragma fragment frag            
            #include "UnityCG.cginc"
    
            sampler2D _GrabTex;           
            
            struct a2v {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0; 
            };
            
            struct v2f {
                float4 pos : SV_POSITION;
                float4 grabPos : TEXCOORD0;
            };
            
            v2f vert(a2v v) {
                v2f o;
                // 从模型坐标-世界坐标-视坐标-（视觉平截体乘以投影矩阵并进行透视除法）-剪裁坐标
                o.pos = UnityObjectToClipPos(v.vertex);
                
                //计算该模型顶点在屏幕坐标的纹理信息             
                o.grabPos = ComputeGrabScreenPos(o.pos);                                
                return o;
            }            
            
            half4 frag(v2f i) : SV_Target {
                // 对_GrabTex纹理进行取样，进行2D纹理映射查找，后面传入的一定要四元纹理坐标。
                // UNITY_PROJ_COORD传入四元纹理坐标用于给tex2Dproj读取，但是多数平台上，返回一样的值。
                // 【自动生成的纹理UV】类型是float4，使用如下方式进行2D纹理映射查找
                half4 color = tex2Dproj(_GrabTex, i.grabPos);

                // 颜色反相，便于观察效果
                return 1 - color;
            }
            ENDCG
		}
	}
	FallBack "Diffuse"
}
