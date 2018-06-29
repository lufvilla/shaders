// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Game/Matcap"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Texture1("Texture1", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
		_Texture3("Texture3", 2D) = "white" {}
		_Texture4("Texture4", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_Splatmap("Splatmap", 2D) = "white" {}
		_TextureSample4("Texture Sample 4", 2D) = "white" {}
		_TextureSample5("Texture Sample 5", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
		};

		uniform sampler2D _Splatmap;
		uniform float4 _Splatmap_ST;
		uniform sampler2D _Texture4;
		uniform sampler2D _TextureSample5;
		uniform float4 _TextureSample5_ST;
		uniform sampler2D _Texture1;
		uniform sampler2D _TextureSample4;
		uniform float4 _TextureSample4_ST;
		uniform sampler2D _Texture2;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform sampler2D _Texture3;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Splatmap = i.uv_texcoord * _Splatmap_ST.xy + _Splatmap_ST.zw;
			float4 tex2DNode11 = tex2D( _Splatmap, uv_Splatmap );
			float3 temp_cast_0 = (0.5).xxx;
			float3 temp_output_5_0 = ( temp_cast_0 + ( 0.5 * mul( UNITY_MATRIX_V , float4( i.worldNormal , 0.0 ) ) ) );
			float2 uv_TextureSample5 = i.uv_texcoord * _TextureSample5_ST.xy + _TextureSample5_ST.zw;
			float4 tex2DNode38 = tex2D( _TextureSample5, uv_TextureSample5 );
			float3 temp_cast_3 = (0.5).xxx;
			float2 uv_TextureSample4 = i.uv_texcoord * _TextureSample4_ST.xy + _TextureSample4_ST.zw;
			float4 tex2DNode37 = tex2D( _TextureSample4, uv_TextureSample4 );
			float3 temp_cast_6 = (0.5).xxx;
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float3 temp_cast_9 = (0.5).xxx;
			o.Albedo = ( ( ( ( tex2DNode11.r * tex2DNode11.g ) * tex2D( _Texture4, temp_output_5_0.xy ) ) + ( ( tex2DNode38.r * ( 1.0 - tex2DNode38.g ) ) * tex2D( _Texture1, temp_output_5_0.xy ) ) ) + ( ( ( ( 1.0 - tex2DNode37.r ) * tex2DNode37.g ) * tex2D( _Texture2, temp_output_5_0.xy ) ) + ( tex2D( _TextureSample3, uv_TextureSample3 ).b * tex2D( _Texture3, temp_output_5_0.xy ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.texcoords01.xy;
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10001
452;94;1018;693;1934.029;1907.78;3.018006;True;False
Node;AmplifyShaderEditor.CommentaryNode;35;-2826.742,-672.3421;Float;False;1201.595;599.9545;;6;7;5;4;3;2;1;Matcap;0;0
Node;AmplifyShaderEditor.ViewMatrixNode;2;-2721.394,-412.6578;Float;False;0;1;FLOAT4x4
Node;AmplifyShaderEditor.WorldNormalVector;1;-2774.093,-325.9578;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-2503.292,-381.5575;Float;False;2;0;FLOAT4x4;0,0,0;False;1;FLOAT3;0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;7;-2286.967,-575.7444;Float;False;Constant;_Multiplier;Multiplier;1;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-2174.497,-441.5578;Float;True;2;0;FLOAT;0.0,0,0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;37;-1424,-736;Float;True;Property;_TextureSample4;Texture Sample 4;2;0;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;38;-1424,-1168;Float;True;Property;_TextureSample5;Texture Sample 5;2;0;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;29;-1104,-1088;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;11;-1424,-1584;Float;True;Property;_Splatmap;Splatmap;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;31;-1104,-720;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-1885.725,-577.3414;Float;True;2;0;FLOAT;0.0,0,0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;39;-1424,-1392;Float;True;Property;_Texture4;Texture4;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-880,-704;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1081.165,-1557.472;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;18;-1426.175,-116.5319;Float;True;Property;_Texture3;Texture3;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;6;-1424,-976;Float;True;Property;_Texture1;Texture1;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;17;-1424,-544;Float;True;Property;_Texture2;Texture2;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;34;-1424,-304;Float;True;Property;_TextureSample3;Texture Sample 3;2;0;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-896,-1152;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-608,-560;Float;True;2;0;FLOAT;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-608,-176;Float;True;2;0;FLOAT;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-656,-992;Float;True;2;0;FLOAT;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-640,-1408;Float;True;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-320,-368;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-320,-1177.964;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-48,-720;Float;True;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;335.7619,-689.5053;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;Game/Matcap;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;4;0;7;0
WireConnection;4;1;3;0
WireConnection;29;0;38;2
WireConnection;31;0;37;1
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;39;1;5;0
WireConnection;32;0;31;0
WireConnection;32;1;37;2
WireConnection;33;0;11;1
WireConnection;33;1;11;2
WireConnection;18;1;5;0
WireConnection;6;1;5;0
WireConnection;17;1;5;0
WireConnection;28;0;38;1
WireConnection;28;1;29;0
WireConnection;12;0;32;0
WireConnection;12;1;17;0
WireConnection;14;0;34;3
WireConnection;14;1;18;0
WireConnection;13;0;28;0
WireConnection;13;1;6;0
WireConnection;40;0;33;0
WireConnection;40;1;39;0
WireConnection;15;0;12;0
WireConnection;15;1;14;0
WireConnection;42;0;40;0
WireConnection;42;1;13;0
WireConnection;43;0;42;0
WireConnection;43;1;15;0
WireConnection;0;0;43;0
ASEEND*/
//CHKSM=BF4F689E08312DB0EC8FBB7AB3094373B5E7B226