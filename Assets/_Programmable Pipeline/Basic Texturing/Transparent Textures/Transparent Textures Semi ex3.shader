// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CG/Basic Texturing/Transparent Textures Semi ex3"
{
	Properties {
      _MainTex ("RGBA Texture Image", 2D) = "white" {} 
	  _Factor ("Factor", Range(0, 1)) = 0.5
   }
   SubShader {
      Tags {"Queue" = "Transparent"}

      Pass {	
         Cull Front // first render the back faces
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects
         Blend SrcAlpha OneMinusSrcAlpha 
            // blend based on the fragment's alpha value
         
         CGPROGRAM
 
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;
		 uniform float _Factor;
 
         struct vertexInput {
            float4 vertex : POSITION;
            float4 texcoord : TEXCOORD0;
         };
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.tex = input.texcoord;
            output.pos = UnityObjectToClipPos(input.vertex);
            return output;
         }

         float4 frag(vertexOutput input) : COLOR
         {
            float4 color =  tex2D(_MainTex, input.tex.xy);  
            if (color.a > 0.5) // opaque back face?
            {
               color = float4(0.0, 0.0, 0.2, 1.0); 
                  // opaque dark blue
            }
            else // transparent back face?
            {
               color = float4(0.0, 0.0, 1.0, 0.3); 
                  // semitransparent green
            }
            return color;
         }
 
         ENDCG
      }

      Pass {	
         Cull Back // now render the front faces
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects
         Blend SrcAlpha OneMinusSrcAlpha 
            // blend based on the fragment's alpha value
         
         CGPROGRAM
 
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;
		 uniform float _Factor;
 
         struct vertexInput {
            float4 vertex : POSITION;
            float4 texcoord : TEXCOORD0;
         };
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.tex = input.texcoord;
            output.pos = UnityObjectToClipPos(input.vertex);
            return output;
         }

         float4 frag(vertexOutput input) : COLOR
         {
            float4 color = tex2D(_MainTex, input.tex.xy);  
            if (color.a > 0.5) // opaque front face?
            {
               color = float4(_Factor * color.r, 1.0 - _Factor * (1.0 - color.g), _Factor * color.b, 1.0);
                  // opaque green
            }
            else // transparent front face
            {
               color = float4(0.0, 0.0, 1.0, 0.3); 
                  // semitransparent dark blue
            }
            return color;
        }
 
         ENDCG
      }
   }
   Fallback "Unlit/Transparent"
}