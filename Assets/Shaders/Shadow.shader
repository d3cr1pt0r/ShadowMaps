Shader "d3cr1pt0r/Shadow" {
    Properties {
        _CameraTex ("Camera texture", 2D) = "white" {}
    }
    SubShader {
        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            uniform sampler2D _CameraTex;
            uniform float4x4 lightMatrix;

            struct appdata {
                float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
        		float2 uv : TEXCOORD0;
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
                fixed4 coords = mul(lightMatrix, fixed4(i.worldPos, 1.0));
                coords /= coords.w;

                coords.x = (coords.x + 1.0) / 2.0;
                coords.y = (coords.y + 1.0) / 2.0;
                coords.z = (coords.z + 1.0) / 2.0;

                float lightDepth = tex2D(_CameraTex, fixed2(coords.x, 1.0 - coords.y)).g;
                float depth = coords.z;

                if (depth < lightDepth + 0.005) {
                    return fixed4(1.0, 1.0, 1.0, 1.0);
                } else {
                    return fixed4(0.3, 0.3, 0.3, 1.0);
                }
            }
            ENDCG

        }
    }
}