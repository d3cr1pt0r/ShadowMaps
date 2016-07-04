Shader "d3cr1pt0r/Shadow" {
    Properties {
        _CameraTex ("Camera texture", 2D) = "white" {}
        _ShadowIntensity("Shadow Intensity", Range(0, 1)) = 0.3
        _ShadowEdge("Shadow Edge", Range(-0.01, 0.01)) = 0.005
    }
    SubShader {
        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            uniform sampler2D _CameraTex;
            uniform float4x4 lightMatrix;
            fixed _ShadowIntensity;
            fixed _ShadowEdge;

            struct appdata {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
        		float3 worldPos : COLOR0;
            };

            v2f vert(appdata v)
	        {
		        v2f o;
		        o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		       	o.worldPos = mul(_Object2World, v.vertex).xyz;
		        return o;
	        }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 uvs = mul(lightMatrix, fixed4(i.worldPos, 1.0));

                uvs /= uvs.w;
                uvs.xyz = (uvs.xyz + 1.0) * 0.5;

                float lightDepth = tex2D(_CameraTex, fixed2(uvs.x, uvs.y)).g;
                float pixelDepth = uvs.z;

                fixed shadowAmount = step(pixelDepth, lightDepth + _ShadowEdge) + 1.0 - _ShadowIntensity;

                return fixed4(shadowAmount, shadowAmount, shadowAmount, 1.0);
            }
            ENDCG

        }
    }
}