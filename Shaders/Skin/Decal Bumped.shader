﻿// Alloy Physical Shader Framework
// Copyright 2013-2014 RUST LLC.
// http://www.alloy.rustltd.com/

Shader "Alloy/Skin/Decal Bumped" {
Properties {
	// Main Textures
	_Color 				("Main Color", Color) 						= (1,1,1,1)
	_MainTex 			("Base(RGB)", 2D) 							= "white" {}
	_BumpMap            ("Normalmap", 2D)                   		= "bump" {}
	_SkinMaterialMap 	("SSS Mask(R) AO(G) Transmission(B) Rough(A)", 2D)= "white" {}
	
	// Main Physical Properties
	_Specularity		("Specularity [0,1]", Float)				= 0.35
	_Roughness			("Roughness [0,1]", Float)					= 1
	
	// Character Properties
	_BRDFTex 			("BRDF Lookup (RGB)", 2D) 					= "gray" {}
	_SkinMaskWeight 	("Skin Mask Weight", Float) 				= 1
	_SssBias			("SSS Bias [0,1]", Float) 					= 0
	_SssScale			("SSS Scale [0,1]", Float) 					= 1
	_SssBumpIntensity	("SSS Bump Intensity [0,1]", Float) 		= 1
	_OcclusionSaturation("SSS Occlusion Saturation [0,1]", Float) 	= 1
	
	// Transmission Properties
	_TransColor 		("Transmission Color", Color) 				= (1,1,1,1)
	_TransDistortion 	("Transmission Distortion [0,1]", Float) 	= 0
	_TransScale	 		("Transmission Scale [0,1]", Float) 		= 0.5
	_TransPower 		("Transmission Power [0,n]", Float) 		= 1
		
	// Decal Mapping Properties
	_DecalTex 			("Decal(RGBA)", 2D) 						= "black" {}
    _DecalTexBumpMap    ("Decal Normalmap", 2D)             		= "bump" {}
    _DecalTexMaterialMap("Decal AO(G) Variance(A)", 2D)  			= "white" {}
    _DecalTexOffset   	("Decal Tiling(XY) Offset(ZW)", Vector) 	= (1,1,0,0)
	
	// Reflection Properties	
	[KeywordEnum(Rsrm, RsrmCube, Skyshop)] 
	_EnvironmentMapMode ("Environment Map Mode", Float) 			= 0
    _Rsrm               ("Radially-Symmetric Reflection Map", 2D)	= "black" {}
    _CubeExposureBoost	("Reflection Exposure Boost [0,n]", Float)	= 1
    _Cube 				("Reflection Cubemap", Cube) 				= "_Skybox" { TexGen CubeReflect }
	_SpecCubeIBL 		("Custom Specular Cube", Cube) 				= "black" {}		
}
 
SubShader{
	Tags { "Queue" = "Geometry" "RenderType" = "Opaque" }

CGPROGRAM
	#ifdef SHADER_API_OPENGL	
		#pragma glsl
	#endif
     
	#pragma target 3.0
    #pragma surface AlloySurf AlloyBrdf vertex:AlloyVert finalcolor:AlloyFinalColor exclude_path:prepass fullforwardshadows noambient nolightmap nodirlightmap
	#pragma multi_compile _ENVIRONMENTMAPMODE_RSRM _ENVIRONMENTMAPMODE_RSRMCUBE _ENVIRONMENTMAPMODE_SKYSHOP 

	// Skyshop directives
	#pragma multi_compile MARMO_BOX_PROJECTION_OFF MARMO_BOX_PROJECTION_ON
	#pragma multi_compile MARMO_GLOBAL_BLEND_OFF MARMO_GLOBAL_BLEND_ON
	#pragma multi_compile MARMO_SKY_BLEND_OFF MARMO_SKY_BLEND_ON
    
	//#define _TRANSMODE_TRANSLUCENT
	//#define _TRANSMODE_CUTOUT
	//#define _SELFILLUMIN_ON
	#define _DETAILMODE_DECAL
	//#define _DETAILMODE_DETAIL
	//#define _INCANDESCENCE_ON
	//#define _RIM_ON
	
	#include "Assets/Alloy/Shaders/Skin.cginc"
ENDCG
}
FallBack "Bumped Diffuse"
CustomEditor "AlloyBaseShaderEditor"
}