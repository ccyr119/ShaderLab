// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CG/Basics/Built-in Vertex Input Parameters 2"
{
	SubShader { 
      Pass { 
         CGPROGRAM 
 
         #pragma vertex vert  
         #pragma fragment frag
		 #include "UnityCG.cginc"
 
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 col : TEXCOORD0;
         };
 
         vertexOutput vert(appdata_full input) 
         {
            vertexOutput output;
 
            output.pos =  UnityObjectToClipPos(input.vertex);
            output.col = input.texcoord; // set the output color

            // other possibilities to play with:

            // output.col = input.vertex;
            // output.col = input.tangent;
             output.col = float4(input.normal, 1.0);
            // output.col = input.texcoord;
            // output.col = input.texcoord1;
            // output.col = input.texcoord2;
            // output.col = input.texcoord3;
            // output.col = input.color;
			output.col = float4(cross(input.normal, 
               input.vertex.xyz), 1.0); 

            return output;
         }
 
         float4 frag(vertexOutput input) : COLOR 
         {
            return input.col; 
         }
 
         ENDCG  
      }
   }
}
