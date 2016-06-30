Shader "d3cr1pt0r/DepthShader"
{
	Properties {
		_MainTex ("Main Texture (RGB)", 2D) = "white" {}
	}

  SubShader
  {
    Tags { "RenderType"="Opaque" }
 
    Pass
    {
 
      CGPROGRAM
      #pragma target 3.0
      #pragma vertex vert
      #pragma fragment frag
      #include "UnityCG.cginc"

      sampler2D _MainTex;
      uniform sampler2D _CameraDepthTexture;

      struct appdata
	  {
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;
	  };

      struct v2f
      {
        float4 pos : SV_POSITION;
        float2 uv : TEXCOORD0;
        float4 projPos : TEXCOORD1;
      };
 
      v2f vert(appdata v)
      {
        v2f o;
        o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
        o.projPos = ComputeScreenPos(o.pos);
        o.projPos.y = 1 - o.projPos.y;
        o.uv = v.uv;

        return o;
      }
 
      half4 frag(v2f i) : COLOR
      {
        float depth = (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)).r);
        return fixed4(0, depth, 0, 0);
      }
 
      ENDCG
    }
  }
}