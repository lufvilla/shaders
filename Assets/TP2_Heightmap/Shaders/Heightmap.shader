// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Game/Heightmap"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Noise("Noise", 2D) = "white" {}
		_Offset("Offset", Range( 0 , 5)) = 0
		_Tesselation("Tesselation", Range( 1 , 5)) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_LowTexture("LowTexture", 2D) = "white" {}
		_HighTexture("HighTexture", 2D) = "white" {}
		_MediumTexture("MediumTexture", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction nolightmap 
		struct Input
		{
			float2 uv_texcoord;
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform sampler2D _HighTexture;
		uniform float4 _HighTexture_ST;
		uniform sampler2D _Ramp;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform sampler2D _MediumTexture;
		uniform float4 _MediumTexture_ST;
		uniform sampler2D _LowTexture;
		uniform float4 _LowTexture_ST;
		uniform float _Smoothness;
		uniform float _Offset;
		uniform float _Tesselation;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			float4 temp_cast_2 = (_Tesselation).xxxx;
			return temp_cast_2;
		}

		void vertexDataFunc( inout appdata v )
		{
			float4 uv_Noise = float4(v.texcoord * _Noise_ST.xy + _Noise_ST.zw, 0 ,0);
			float4 tex2DNode7 = tex2Dlod( _Noise, uv_Noise );
			v.vertex.xyz += ( _Offset * ( tex2DNode7 * float4( v.normal , 0.0 ) ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_HighTexture = i.uv_texcoord * _HighTexture_ST.xy + _HighTexture_ST.zw;
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float4 tex2DNode7 = tex2D( _Noise, uv_Noise );
			float4 tex2DNode14 = tex2D( _Ramp, tex2DNode7.xy );
			float4 temp_output_35_0 = ( tex2D( _HighTexture, uv_HighTexture ) * tex2DNode14.r );
			float2 uv_MediumTexture = i.uv_texcoord * _MediumTexture_ST.xy + _MediumTexture_ST.zw;
			float2 uv_LowTexture = i.uv_texcoord * _LowTexture_ST.xy + _LowTexture_ST.zw;
			o.Albedo = ( ( temp_output_35_0 + ( tex2D( _MediumTexture, uv_MediumTexture ) * tex2DNode14.g ) ) + ( tex2D( _LowTexture, uv_LowTexture ) * tex2DNode14.b ) ).rgb;
			float4 temp_output_41_0 = ( temp_output_35_0 * _Smoothness );
			o.Metallic = temp_output_41_0.r;
			o.Smoothness = temp_output_41_0.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10001
41;572;966;486;2299.186;603.8566;3.563546;True;False
Node;AmplifyShaderEditor.SamplerNode;7;-1383.721,398.9203;Float;True;Property;_Noise;Noise;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;17;-1012.228,-453.7338;Float;True;Property;_HighTexture;HighTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;14;-1012.228,122.2661;Float;True;Property;_Ramp;Ramp;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;18;-1012.228,-261.7338;Float;True;Property;_MediumTexture;MediumTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;19;-1012.228,-69.73393;Float;True;Property;_LowTexture;LowTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-665.1576,-244.0906;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.NormalVertexDataNode;9;-1273.803,588.2906;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-664.8278,-455.4642;Float;True;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-417.9376,-343.4733;Float;True;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;12;-1008,400;Float;False;Property;_Offset;Offset;1;0;0;0;5;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1014.01,492.2753;Float;True;2;0;FLOAT4;0.0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-657.6312,-29.68987;Float;True;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;40;-521.8802,213.4253;Float;False;Property;_Smoothness;Smoothness;7;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-155.7722,-25.06887;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;13;-327.0172,536.7274;Float;False;Property;_Tesselation;Tesselation;3;0;0;1;5;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-203.7108,76.22681;Float;False;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-672,464;Float;True;2;0;FLOAT;0.0;False;1;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;Float;ASEMaterialInspector;0;Standard;Game/Heightmap;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;True;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;7;0
WireConnection;36;0;18;0
WireConnection;36;1;14;2
WireConnection;35;0;17;0
WireConnection;35;1;14;1
WireConnection;38;0;35;0
WireConnection;38;1;36;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;37;0;19;0
WireConnection;37;1;14;3
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;41;0;35;0
WireConnection;41;1;40;0
WireConnection;11;0;12;0
WireConnection;11;1;10;0
WireConnection;0;0;39;0
WireConnection;0;3;41;0
WireConnection;0;4;41;0
WireConnection;0;11;11;0
WireConnection;0;14;13;0
ASEEND*/
//CHKSM=F8B4481075BCDC0EE60EB30BAA322675A5C17A6E