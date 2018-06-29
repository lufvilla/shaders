// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Game/Heightmap"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Offset("Offset", Range( 0 , 5)) = 0
		_Ramp("Ramp", 2D) = "white" {}
		_Tesselation("Tesselation", Range( 1 , 5)) = 0
		_MediumTexture("MediumTexture", 2D) = "white" {}
		_MediumTexture2("MediumTexture2", 2D) = "white" {}
		_LowTexture2("LowTexture2", 2D) = "white" {}
		_LowTexture("LowTexture", 2D) = "white" {}
		_HighTexture2("HighTexture2", 2D) = "white" {}
		_HighTexture("HighTexture", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Normal("Normal", Range( 0 , 2)) = 0
		_Noise("Noise", 2D) = "white" {}
		_NoiseMultiplier("NoiseMultiplier", Range( 0 , 3)) = 0.6149452
		_HighLerp("HighLerp", Range( 0 , 2)) = 0
		_LowLerp("LowLerp", Range( 0 , 1)) = 0
		_MediumLerp("MediumLerp", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
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

		uniform float _Normal;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform sampler2D _HighTexture;
		uniform float4 _HighTexture_ST;
		uniform sampler2D _HighTexture2;
		uniform float4 _HighTexture2_ST;
		uniform float _HighLerp;
		uniform sampler2D _Ramp;
		uniform float _NoiseMultiplier;
		uniform sampler2D _MediumTexture;
		uniform float4 _MediumTexture_ST;
		uniform sampler2D _MediumTexture2;
		uniform float4 _MediumTexture2_ST;
		uniform float _MediumLerp;
		uniform sampler2D _LowTexture;
		uniform float4 _LowTexture_ST;
		uniform sampler2D _LowTexture2;
		uniform float4 _LowTexture2_ST;
		uniform float _LowLerp;
		uniform float _Metallic;
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
			v.vertex.xyz += ( ( tex2Dlod( _Noise, uv_Noise ) * float4( v.normal , 0.0 ) ) * _Offset ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Noise, uv_Noise ) ,_Normal );
			float2 uv_HighTexture = i.uv_texcoord * _HighTexture_ST.xy + _HighTexture_ST.zw;
			float2 uv_HighTexture2 = i.uv_texcoord * _HighTexture2_ST.xy + _HighTexture2_ST.zw;
			float4 tex2DNode14 = tex2D( _Ramp, ( tex2D( _Noise, uv_Noise ) * _NoiseMultiplier ).xy );
			float2 uv_MediumTexture = i.uv_texcoord * _MediumTexture_ST.xy + _MediumTexture_ST.zw;
			float2 uv_MediumTexture2 = i.uv_texcoord * _MediumTexture2_ST.xy + _MediumTexture2_ST.zw;
			float2 uv_LowTexture = i.uv_texcoord * _LowTexture_ST.xy + _LowTexture_ST.zw;
			float2 uv_LowTexture2 = i.uv_texcoord * _LowTexture2_ST.xy + _LowTexture2_ST.zw;
			o.Albedo = ( ( ( lerp( tex2D( _HighTexture, uv_HighTexture ) , tex2D( _HighTexture2, uv_HighTexture2 ) , _HighLerp ) * tex2DNode14.r ) + ( lerp( tex2D( _MediumTexture, uv_MediumTexture ) , tex2D( _MediumTexture2, uv_MediumTexture2 ) , _MediumLerp ) * tex2DNode14.g ) ) + ( lerp( tex2D( _LowTexture, uv_LowTexture ) , tex2D( _LowTexture2, uv_LowTexture2 ) , _LowLerp ) * tex2DNode14.b ) ).rgb;
			float4 tex2DNode45 = tex2D( _Noise, uv_Noise );
			o.Metallic = ( _Metallic * tex2DNode45.r );
			o.Smoothness = ( tex2DNode45.r * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10001
1921;32;1906;1004;2396.718;567.5232;2.2;True;True
Node;AmplifyShaderEditor.SamplerNode;7;-1699.251,0.9235961;Float;True;Property;_Noise;Noise;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;61;-1666.494,228.4195;Float;False;Property;_NoiseMultiplier;NoiseMultiplier;11;0;0.6149452;0;3;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;17;-1470.021,-1506.364;Float;True;Property;_HighTexture;HighTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;52;-1469.053,-1308.977;Float;True;Property;_HighTexture2;HighTexture2;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;18;-1463.636,-1006.209;Float;True;Property;_MediumTexture;MediumTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;53;-1449.679,-1115.633;Float;False;Property;_HighLerp;HighLerp;11;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;54;-1468.716,-814.7687;Float;True;Property;_MediumTexture2;MediumTexture2;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1323.291,95.81933;Float;False;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;56;-1460.112,-611.1718;Float;False;Property;_MediumLerp;MediumLerp;11;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;58;-1462.943,-312.3837;Float;True;Property;_LowTexture2;LowTexture2;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;19;-1463.345,-512.5257;Float;True;Property;_LowTexture;LowTexture;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;51;-1062.95,-1283.974;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;57;-1459.037,-111.919;Float;False;Property;_LowLerp;LowLerp;11;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;14;-1157.48,15.47065;Float;True;Property;_Ramp;Ramp;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;55;-1072.117,-904.6678;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.NormalVertexDataNode;9;-952.7407,838.0733;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-807.4477,-910.4703;Float;True;2;0;COLOR;0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-771.4176,-1277.647;Float;True;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;48;-1062.092,636.337;Float;True;Property;_TextureSample1;Texture Sample 1;8;0;None;True;0;False;white;Auto;False;Instance;7;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;59;-1092.205,-378.1425;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;45;-817.4327,324.9115;Float;True;Property;_TextureSample0;Texture Sample 0;8;0;None;True;0;False;white;Auto;False;Instance;7;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-814.6215,-444.6693;Float;True;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-484.7272,-934.4528;Float;True;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;47;-797.9752,227.8874;Float;False;Property;_Metallic;Metallic;8;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;50;-760.7814,67.80058;Float;False;Property;_Normal;Normal;9;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-684.0243,642.3178;Float;True;2;0;FLOAT4;0.0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;40;-800.955,523.6553;Float;False;Property;_Smoothness;Smoothness;7;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;12;-710.218,919.2792;Float;False;Property;_Offset;Offset;1;0;0;0;5;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-346.7956,899.5477;Float;False;Property;_Tesselation;Tesselation;3;0;0;1;5;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-145.7277,-609.372;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-384,400;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-384,297.4771;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;49;-445.6524,-9.414185;Float;True;Property;_TextureSample2;Texture Sample 2;9;0;None;True;0;False;white;Auto;True;Instance;7;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-398.6591,641.3159;Float;True;2;0;FLOAT4;0.0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;Float;ASEMaterialInspector;0;Standard;Game/Heightmap;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;True;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;62;0;7;0
WireConnection;62;1;61;0
WireConnection;51;0;17;0
WireConnection;51;1;52;0
WireConnection;51;2;53;0
WireConnection;14;1;62;0
WireConnection;55;0;18;0
WireConnection;55;1;54;0
WireConnection;55;2;56;0
WireConnection;36;0;55;0
WireConnection;36;1;14;2
WireConnection;35;0;51;0
WireConnection;35;1;14;1
WireConnection;59;0;19;0
WireConnection;59;1;58;0
WireConnection;59;2;57;0
WireConnection;37;0;59;0
WireConnection;37;1;14;3
WireConnection;38;0;35;0
WireConnection;38;1;36;0
WireConnection;10;0;48;0
WireConnection;10;1;9;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;43;0;45;1
WireConnection;43;1;40;0
WireConnection;46;0;47;0
WireConnection;46;1;45;1
WireConnection;49;5;50;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;0;0;39;0
WireConnection;0;1;49;0
WireConnection;0;3;46;0
WireConnection;0;4;43;0
WireConnection;0;11;11;0
WireConnection;0;14;13;0
ASEEND*/
//CHKSM=F240A9240072393E039A0EF2D19DBB80B885A32C