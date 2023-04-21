// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Waves" 
{
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
    _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
    _BumpMap ("Normalmap", 2D) = "bump" {}
    _ScrollSpeed("ScrollSpeed", Float) = 1
    _Amplitude("Amp", Range(0, 2)) = 0.2
    _Speed("Speed", Range(10, 100)) = 10
}
 
SubShader {
    Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
    Cull Off
    LOD 300
   
 
CGPROGRAM
#pragma surface surf Lambert alpha vertex:vert
 
sampler2D _MainTex;
sampler2D _BumpMap;
samplerCUBE _Cube;

float _ScrollSpeed;
float _Amplitude;
float _Speed;
fixed4 _Color;
fixed4 _ReflectColor;
 
struct Input
{
    float2 uv_MainTex;
    float2 uv_BumpMap;
    float3 worldRefl;
    INTERNAL_DATA
};
 
void vert (inout appdata_full v)
{
    float phase = _Time *_Speed;
    float4 wpos = mul( unity_ObjectToWorld, v.vertex);
    float offset = (wpos.x + (wpos.z * 0.9)) * 0.5;
    wpos.y = sin(phase + offset) * _Amplitude;
                v.vertex = mul(unity_WorldToObject, wpos);
}
 
void surf (Input IN, inout SurfaceOutput o)
{
    float2 scrollUvMap = float2(IN.uv_BumpMap.x * _ScrollSpeed, IN.uv_BumpMap.y);
    
    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
    fixed4 c = tex * _Color;
    o.Albedo = c.rgb;
   
    o.Normal = UnpackNormal(tex2D(_BumpMap, scrollUvMap));
   
    float3 worldRefl = WorldReflectionVector (IN, o.Normal);
    fixed4 reflcol = texCUBE (_Cube, worldRefl);
    o.Emission = reflcol.rgb * _ReflectColor.rgb;
    o.Alpha = reflcol.a * 0.9;
}
ENDCG
}
 
FallBack "Reflective/VertexLit"
}