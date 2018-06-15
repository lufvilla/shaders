Shader "Game/Transition"
{
	Properties
	{
	    [HideInInspector]
	    _MainTex ("Texture", 2D) = "white" {}
		_World2 ("World2", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
		_Transition("Transition", Range( 0 , 1)) = 0
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _World2;
			sampler2D _Mask;
			float _Transition;

			fixed4 frag (v2f i) : SV_Target
			{
			    fixed4 col1 = tex2D(_MainTex, i.uv);
				fixed4 col2 = tex2D(_World2, i.uv);
				//fixed mask = (tex2D(_Mask, i.uv).r + 0.5f) * _Transition;
				//mask = clamp(mask, 0, 1);
				return lerp(col1, col2, _Transition);
			}
			ENDCG
		}
	}
}
