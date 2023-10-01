#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"

struct v2g
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float2 uv0 : TEXCOORD0;
	float4 posWorld : TEXCOORD2;
	float3 normalDir : TEXCOORD3;
	float3 tangentDir : TEXCOORD4;
	float3 bitangentDir : TEXCOORD5;
	float4 pos : CLIP_POS;
	SHADOW_COORDS(6)
	UNITY_FOG_COORDS(7)
    fixed4 color : COLOR;
    #ifndef ARKTOON_ADD
        float3 lightColor0 : LIGHT_COLOR0;
        float3 lightColor1 : LIGHT_COLOR1;
        float3 lightColor2 : LIGHT_COLOR2;
        float3 lightColor3 : LIGHT_COLOR3;
        float4 ambientAttenuation : AMBIENT_ATTEN;
        float4 ambientIndirect : AMBIENT_INDIRECT;
    #endif
};


v2g vert(appdata_full v) {
	v2g o;
	o.uv0 = v.texcoord;
	o.normal = v.normal;
	o.tangent = v.tangent;
    o.color = v.color;
	o.normalDir = normalize(UnityObjectToWorldNormal(v.normal));
	o.tangentDir = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
	o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
	float4 objPos = mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
	o.posWorld = mul(unity_ObjectToWorld, v.vertex);
	float3 lightColor = _LightColor0.rgb;
	o.vertex = v.vertex;
	o.pos = UnityObjectToClipPos(v.vertex);
	TRANSFER_SHADOW(o);
	UNITY_TRANSFER_FOG(o, o.pos);

    #ifndef ARKTOON_ADD
        // 頂点ライティングが必要な場合に取得
        #if UNITY_SHOULD_SAMPLE_SH
            #if defined(VERTEXLIGHT_ON) && defined(USE_VERTEX_LIGHT)
                o.lightColor0 = unity_LightColor[0].rgb;
                o.lightColor1 = unity_LightColor[1].rgb;
                o.lightColor2 = unity_LightColor[2].rgb;
                o.lightColor3 = unity_LightColor[3].rgb;

                // Shade4PointLightsを展開して改変
                // {
                    // to light vectors
                    float4 toLightX = unity_4LightPosX0 - o.posWorld.x;
                    float4 toLightY = unity_4LightPosY0 - o.posWorld.y;
                    float4 toLightZ = unity_4LightPosZ0 - o.posWorld.z;
                    // squared lengths
                    float4 lengthSq = 0;
                    lengthSq += toLightX * toLightX;
                    lengthSq += toLightY * toLightY;
                    lengthSq += toLightZ * toLightZ;
                    // don't produce NaNs if some vertex position overlaps with the light
                    lengthSq = max(lengthSq, 0.000001);

                    // NdotL
                    float4 ndotl = 0;
                    ndotl += toLightX * o.normalDir.x;
                    ndotl += toLightY * o.normalDir.y;
                    ndotl += toLightZ * o.normalDir.z;
                    // correct NdotL
                    float4 corr = rsqrt(lengthSq);
                    ndotl = max (float4(0,0,0,0), ndotl * corr);
                    // attenuation
                    float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
                    float4 diff = ndotl * atten;
                // }

                o.ambientAttenuation = diff;
                o.ambientIndirect = sqrt(min(1,corr* atten));

            #else
                o.lightColor0 = 0;
                o.lightColor1 = 0;
                o.lightColor2 = 0;
                o.lightColor3 = 0;
                o.ambientIndirect = o.ambientAttenuation = 0;
            #endif
        #else
            o.lightColor0 = 0;
            o.lightColor1 = 0;
            o.lightColor2 = 0;
            o.lightColor3 = 0;
            o.ambientIndirect = o.ambientAttenuation = 0;
        #endif
    #endif

    return o;
}

struct VertexOutput {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float4 posWorld : TEXCOORD2;
    float3 normalDir : TEXCOORD3;
    float3 tangentDir : TEXCOORD4;
    float3 bitangentDir : TEXCOORD5;
    fixed4 col : COLOR0;
	bool isOutline : IS_OUTLINE;
    int faceSign : FACE_SIGN;
    SHADOW_COORDS(6)
    UNITY_FOG_COORDS(7)
    fixed4 color : COLOR1;
    #ifndef ARKTOON_ADD
        float3 lightColor0 : LIGHT_COLOR0;
        float3 lightColor1 : LIGHT_COLOR1;
        float3 lightColor2 : LIGHT_COLOR2;
        float3 lightColor3 : LIGHT_COLOR3;
        float4 ambientAttenuation : AMBIENT_ATTEN;
        float4 ambientIndirect : AMBIENT_INDIRECT;
    #endif
};

uniform float _OutlineWidth;
uniform float4 _OutlineColor;
uniform sampler2D _OutlineWidthMask; uniform float4 _OutlineWidthMask_ST;

[maxvertexcount(9)]
void geom(triangle v2g IN[3], inout TriangleStream<VertexOutput> tristream)
{
	VertexOutput o;
	#ifdef USE_OUTLINE
	for (int i = 2; i >= 0; i--)
	{
        #ifdef USE_OUTLINE_WIDTH_MASK
            float _OutlineWidthMask_var = tex2Dlod (_OutlineWidthMask,float4(IN[i].uv0, 0, 0));
            float width = _OutlineWidth * _OutlineWidthMask_var;
        #else
            float width = _OutlineWidth;
        #endif
		o.pos = UnityObjectToClipPos(IN[i].vertex + normalize(IN[i].normal) * (width * .01));
		o.uv0 = IN[i].uv0;
		o.col = fixed4( _OutlineColor.r, _OutlineColor.g, _OutlineColor.b, 1);
        o.color = IN[i].color;
		o.posWorld = mul(unity_ObjectToWorld, IN[i].vertex);
		o.normalDir = UnityObjectToWorldNormal(IN[i].normal);
		o.tangentDir = IN[i].tangentDir;
		o.bitangentDir = IN[i].bitangentDir;
		o.posWorld = mul(unity_ObjectToWorld, IN[i].vertex);
		o.isOutline = true;
        o.faceSign = -1;

		// Pass-through the shadow coordinates if this pass has shadows.
		#if defined (SHADOWS_SCREEN) || ( defined (SHADOWS_DEPTH) && defined (SPOT) ) || defined (SHADOWS_CUBE)
		o._ShadowCoord = IN[i]._ShadowCoord;
		#endif

		// Pass-through the fog coordinates if this pass has shadows.
		#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
		o.fogCoord = IN[i].fogCoord;
		#endif

        #ifndef ARKTOON_ADD
            o.lightColor0          = IN[i].lightColor0;
            o.lightColor1          = IN[i].lightColor1;
            o.lightColor2          = IN[i].lightColor2;
            o.lightColor3          = IN[i].lightColor3;
            o.ambientAttenuation   = IN[i].ambientAttenuation;
            o.ambientIndirect      = IN[i].ambientIndirect;
        #endif

		tristream.Append(o);
	}

	tristream.RestartStrip();
	#endif

	#ifdef DOUBLE_SIDED
	for (int iii = 2; iii >= 0; iii--)
	{
		o.pos = UnityObjectToClipPos(IN[iii].vertex);
		o.uv0 = IN[iii].uv0;
		o.col = fixed4(1., 1., 1., 0.);
        o.color = IN[iii].color;
		o.posWorld = mul(unity_ObjectToWorld, IN[iii].vertex);
		o.normalDir = UnityObjectToWorldNormal(IN[iii].normal);
		o.tangentDir = IN[iii].tangentDir;
		o.bitangentDir = IN[iii].bitangentDir;
		o.posWorld = mul(unity_ObjectToWorld, IN[iii].vertex);
		o.isOutline = false;
        o.faceSign = -1;

		// Pass-through the shadow coordinates if this pass has shadows.
		#if defined (SHADOWS_SCREEN) || ( defined (SHADOWS_DEPTH) && defined (SPOT) ) || defined (SHADOWS_CUBE)
		o._ShadowCoord = IN[iii]._ShadowCoord;
		#endif

		// Pass-through the fog coordinates if this pass has shadows.
		#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
		o.fogCoord = IN[iii].fogCoord;
		#endif

        #ifndef ARKTOON_ADD
            o.lightColor0          = IN[iii].lightColor0;
            o.lightColor1          = IN[iii].lightColor1;
            o.lightColor2          = IN[iii].lightColor2;
            o.lightColor3          = IN[iii].lightColor3;
            o.ambientAttenuation   = IN[iii].ambientAttenuation;
            o.ambientIndirect      = IN[iii].ambientIndirect;
        #endif

		tristream.Append(o);
	}

	tristream.RestartStrip();
	#endif

	for (int ii = 0; ii < 3; ii++)
	{
		o.pos = UnityObjectToClipPos(IN[ii].vertex);
		o.uv0 = IN[ii].uv0;
		o.col = fixed4(1., 1., 1., 0.);
        o.color = IN[ii].color;
		o.posWorld = mul(unity_ObjectToWorld, IN[ii].vertex);
		o.normalDir = UnityObjectToWorldNormal(IN[ii].normal);
		o.tangentDir = IN[ii].tangentDir;
		o.bitangentDir = IN[ii].bitangentDir;
		o.posWorld = mul(unity_ObjectToWorld, IN[ii].vertex);
		o.isOutline = false;
        o.faceSign = 1;

		// Pass-through the shadow coordinates if this pass has shadows.
		#if defined (SHADOWS_SCREEN) || ( defined (SHADOWS_DEPTH) && defined (SPOT) ) || defined (SHADOWS_CUBE)
		o._ShadowCoord = IN[ii]._ShadowCoord;
		#endif

		// Pass-through the fog coordinates if this pass has shadows.
		#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
		o.fogCoord = IN[ii].fogCoord;
		#endif

        #ifndef ARKTOON_ADD
            o.lightColor0          = IN[ii].lightColor0;
            o.lightColor1          = IN[ii].lightColor1;
            o.lightColor2          = IN[ii].lightColor2;
            o.lightColor3          = IN[ii].lightColor3;
            o.ambientAttenuation   = IN[ii].ambientAttenuation;
            o.ambientIndirect      = IN[ii].ambientIndirect;
        #endif

		tristream.Append(o);
	}

	tristream.RestartStrip();
}
