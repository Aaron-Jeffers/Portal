// Compiled shader for WebGL

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "Skybox/Procedural" {
Properties {
[KeywordEnum(None, Simple, High Quality)]  _SunDisk ("Sun", Float) = 2.000000
 _SunSize ("Sun Size", Range(0.000000,1.000000)) = 0.040000
 _SunSizeConvergence ("Sun Size Convergence", Range(1.000000,10.000000)) = 5.000000
 _AtmosphereThickness ("Atmosphere Thickness", Range(0.000000,5.000000)) = 1.000000
 _SkyTint ("Sky Tint", Color) = (0.500000,0.500000,0.500000,1.000000)
 _GroundColor ("Ground", Color) = (0.369000,0.349000,0.341000,1.000000)
 _Exposure ("Exposure", Range(0.000000,8.000000)) = 1.300000
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" "PreviewType"="Skybox" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" "PreviewType"="Skybox" }
  ZWrite Off
  Cull Off
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_NONE 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles":
Shader Disassembly:
#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
attribute highp vec4 in_POSITION0;
varying mediump float vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlatb0 = u_xlat2.y>=0.0;
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat23 = u_xlat2.y * -50.0;
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    vs_TEXCOORD0 = u_xlat23;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
varying mediump float vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_SIMPLE 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles":
Shader Disassembly:
#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
attribute highp vec4 in_POSITION0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_10;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlatb0 = u_xlat2.y>=0.0;
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.25);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
    u_xlat16_10.xyz = clamp(u_xlat16_10.xyz, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_10.xyz * _LightColor0.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(27.0, 27.0, 27.0);
    vs_TEXCOORD3.xyz = u_xlat16_10.xyz / u_xlat16_3.xxx;
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_3.x = float(1.0) / _SunSize;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlatb2 = vs_TEXCOORD0.y<0.0;
    u_xlat16_0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_HIGH_QUALITY 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles":
Shader Disassembly:
#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
attribute highp vec4 in_POSITION0;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_10;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlatb0 = u_xlat2.y>=0.0;
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.25);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(15.0, 15.0, 15.0);
    vs_TEXCOORD3.xyz = u_xlat16_10.xyz / u_xlat16_3.xxx;
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
uniform 	mediump float _SunSizeConvergence;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = log2(_SunSize);
    u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
    u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
    u_xlat16_6 = log2(u_xlat16_6);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
    u_xlat16_3.x = u_xlat1.y * 50.0;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlatb1 = u_xlat1.y<0.0;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_NONE 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles3":
Constant Buffer "$Globals" (192 bytes) {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_MatrixVP at 80
  Vector4 _WorldSpaceLightPos0 at 0
  Float _Exposure at 144
  Vector3 _GroundColor at 160
  Vector3 _SkyTint at 176
  Float _AtmosphereThickness at 188
}

Shader Disassembly:
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump float vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat23 = u_xlat2.y * -50.0;
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    vs_TEXCOORD0 = u_xlat23;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump float vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_SIMPLE 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles3":
Constant Buffer "$Globals" (20 bytes) {
  Vector4 _WorldSpaceLightPos0 at 0
  Float _SunSize at 16
}
Constant Buffer "$Globals" (208 bytes) {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_MatrixVP at 80
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 _LightColor0 at 144
  Float _Exposure at 160
  Vector3 _GroundColor at 176
  Vector3 _SkyTint at 192
  Float _AtmosphereThickness at 204
}

Shader Disassembly:
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_10;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.25);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.xyz = min(max(u_xlat16_10.xyz, 0.0), 1.0);
#else
    u_xlat16_10.xyz = clamp(u_xlat16_10.xyz, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = u_xlat16_10.xyz * _LightColor0.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(27.0, 27.0, 27.0);
    vs_TEXCOORD3.xyz = u_xlat16_10.xyz / u_xlat16_3.xxx;
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_3.x = float(1.0) / _SunSize;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
#else
    u_xlatb2 = vs_TEXCOORD0.y<0.0;
#endif
    u_xlat16_0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: _SUNDISK_HIGH_QUALITY 
-- Hardware tier variant: Tier 1
-- Vertex shader for "gles3":
Constant Buffer "$Globals" (24 bytes) {
  Vector4 _WorldSpaceLightPos0 at 0
  Float _SunSize at 16
  Float _SunSizeConvergence at 20
}
Constant Buffer "$Globals" (208 bytes) {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_MatrixVP at 80
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 _LightColor0 at 144
  Float _Exposure at 160
  Vector3 _GroundColor at 176
  Vector3 _SkyTint at 192
  Float _AtmosphereThickness at 204
}

Shader Disassembly:
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_10;
vec3 u_xlat12;
float u_xlat14;
float u_xlat19;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat21 + u_xlat0.x;
        u_xlat7 = (-u_xlat0.y) * u_xlat21 + 1.0;
        u_xlat14 = u_xlat7 * 5.25 + -6.80000019;
        u_xlat14 = u_xlat7 * u_xlat14 + 3.82999992;
        u_xlat14 = u_xlat7 * u_xlat14 + 0.458999991;
        u_xlat7 = u_xlat7 * u_xlat14 + -0.00286999997;
        u_xlat7 = u_xlat7 * 1.44269502;
        u_xlat0.y = exp2(u_xlat7);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat22 = (-u_xlat21) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat21;
        u_xlat25 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat21 = u_xlat25 / u_xlat21;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat25 = u_xlat23 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat23 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat23 * u_xlat25 + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat25 + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat25 = u_xlat21 * 5.25 + -6.80000019;
        u_xlat25 = u_xlat21 * u_xlat25 + 3.82999992;
        u_xlat25 = u_xlat21 * u_xlat25 + 0.458999991;
        u_xlat21 = u_xlat21 * u_xlat25 + -0.00286999997;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.25;
        u_xlat21 = u_xlat23 * 0.25 + (-u_xlat21);
        u_xlat21 = u_xlat22 * u_xlat21 + u_xlat0.y;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = min(u_xlat21, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat21)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat21 = u_xlat0.z * u_xlat22;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat22 = (-u_xlat0.x) + 1.0;
        u_xlat22 = u_xlat22 * 230.831207;
        u_xlat22 = exp2(u_xlat22);
        u_xlat23 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat23 = u_xlat23 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat4.x = u_xlat23 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat23 * u_xlat4.x + 0.458999991;
        u_xlat23 = u_xlat23 * u_xlat4.x + -0.00286999997;
        u_xlat23 = u_xlat23 * 1.44269502;
        u_xlat23 = exp2(u_xlat23);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat23 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat22;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat21) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat23 = min(u_xlat2.y, -0.00100000005);
        u_xlat23 = -9.99999975e-05 / u_xlat23;
        u_xlat5.xyz = vec3(u_xlat23) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat19 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.y * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.y * u_xlat19 + 0.458999991;
        u_xlat12.x = u_xlat5.y * u_xlat19 + -0.00286999997;
        u_xlat12.x = u_xlat12.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat12.x);
        u_xlat19 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat19 = u_xlat5.x * u_xlat19 + 3.82999992;
        u_xlat19 = u_xlat5.x * u_xlat19 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat19 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat12.xz = vec2(u_xlat23) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat12.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat23 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat23 = sqrt(u_xlat23);
        u_xlat23 = (-u_xlat23) + 1.0;
        u_xlat23 = u_xlat23 * 230.831207;
        u_xlat23 = exp2(u_xlat23);
        u_xlat5.x = u_xlat23 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat23 = u_xlat12.z * u_xlat23;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat23);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    }
    u_xlat16_3.xyz = vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * vec3(_GroundColor.x, _GroundColor.y, _GroundColor.z);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.75 + 0.75;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD2.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_3.x = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.25);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(15.0, 15.0, 15.0);
    vs_TEXCOORD3.xyz = u_xlat16_10.xyz / u_xlat16_3.xxx;
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
uniform 	mediump float _SunSizeConvergence;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = log2(_SunSize);
    u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
    u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
    u_xlat16_6 = log2(u_xlat16_6);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
    u_xlat16_3.x = u_xlat1.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.y<0.0);
#else
    u_xlatb1 = u_xlat1.y<0.0;
#endif
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    SV_Target0.xyz = sqrt(u_xlat16_0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif


 }
}
CustomEditor "SkyboxProceduralShaderGUI"
Fallback Off
}