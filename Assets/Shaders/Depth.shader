Shader "d3cr1pt0r/DepthShader"
{
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

      uniform sampler2D _CameraDepthTexture;

      struct appdata
	  {
		float4 vertex : POSITION;
	  };

      struct v2f
      {
        float4 pos : SV_POSITION;
        float4 projPos : TEXCOORD1;
      };
 
      v2f vert(appdata v)
      {
        v2f o;
        o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
        o.projPos = ComputeScreenPos(o.pos);
        o.projPos.y = 1 - o.projPos.y;

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