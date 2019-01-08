Shader "Custom/Other/GrabPass_Test1" {	
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Opaque" }
		LOD 200
		
		GrabPass {"_GrabTex"}
		
		pass{		
            CGPROGRAM
            
            //计算该模型顶点在屏幕坐标的纹理信息，等价于unity封装的UnityCG.cginc代码中ComputeGrabScreenPos
            float4 myComputeGrabScreenPos(float4 pos) {
                // 【自动生成纹理】通过输出的pos计算的纹理信息
                // 【解决平台差异】D3D原点在顶部（本机需要让y缩放乘以-1），openGL在底部
                #if UNITY_UV_STARTS_AT_TOP
                    float scale = -1.0;
                #else
                    float scale = 1.0;
                #endif
                
                // pos的范围是【-1,1】+1为【0,2】，乘以0.5变成uv的范围【0,1】
                // 不清楚为什么这样写，但是标准的写法就是这样
                float4 o = pos * 0.5f;
                o.xy = float2(o.x, o.y*scale) + o.w;
                o.zw = pos.zw;
                return o;
            }
            //#define TRANSFORM_TEX(tex,name) (tex.xy * name##_ST.xy + name##_ST.zw)
            
            #pragma vertex vert
            #pragma fragment frag            
            #include "UnityCG.cginc"
    
            sampler2D _GrabTex;
            float4 _GrabTex_ST;
            
            struct a2v {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0; 
            };
            
            struct v2f {
                float4 pos : SV_POSITION;
                //float4 grabPos : TEXCOORD0;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(a2v v) {
                v2f o;
                // 从模型坐标-世界坐标-视坐标-（视觉平截体乘以投影矩阵并进行透视除法）-剪裁坐标
                o.pos = UnityObjectToClipPos(v.vertex);
                
                //计算该模型顶点在屏幕坐标的纹理信息             
//                o.grabPos = myComputeGrabScreenPos(o.pos);
                
                //计算该模型顶点在屏幕坐标的纹理信息: o.uv = v.texcoord *_MainTex_ST.xy+_MainTex_ST.zw
                o.uv = TRANSFORM_TEX(v.texcoord, _GrabTex);
                //o.uv = v.texcoord *_GrabTex_ST.xy+_GrabTex_ST.zw;
                #if UNITY_UV_STARTS_AT_TOP
                    float scale = -1.0;
                    o.uv.y = 1 - o.uv.y;                
                #endif                
                return o;
            }            
            
            half4 frag(v2f i) : SV_Target {
                // 对_GrabTex纹理进行取样，进行2D纹理映射查找，后面传入的一定要四元纹理坐标。
                // UNITY_PROJ_COORD传入四元纹理坐标用于给tex2Dproj读取，但是多数平台上，返回一样的值。
                // 【自动生成的纹理UV】类型是float4，使用如下方式进行2D纹理映射查找
                //half4 color = tex2Dproj(_GrabTex, i.grabPos);
                
                // 也可以使用tex2D进行采样，但是【自动生成的纹理UV】时必须要除以w转为齐次坐标
//                float last_x = i.grabPos.x / i.grabPos.w;
//                float last_y = i.grabPos.y / i.grabPos.w; 
//                half4 color = tex2D(_GrabTex, float2(last_x, last_y));

                // 颜色反相，便于观察效果
//                return 1 - color;
                
                half4 color = tex2D(_GrabTex, i.uv);
                
                // 颜色反相，便于观察效果
                return color;
            }
            ENDCG
		}
	}
	FallBack "Diffuse"
}
