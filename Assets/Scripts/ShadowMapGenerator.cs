using UnityEngine;
using System.Collections;
using UnityEngine.Rendering;

public class ShadowMapGenerator : MonoBehaviour {

	[SerializeField] private Camera lightCamera;
	[SerializeField] private Shader depthShader;

	private Material renderMaterial;
	private RenderTexture renderTexture;

	public RenderTexture GetRenderTexture() {
		return renderTexture;
	}
		
	private void Awake() {
		renderMaterial = new Material (depthShader);
		renderTexture = new RenderTexture (2048, 2048, 24, RenderTextureFormat.ARGB32);
		renderTexture.Create ();

		lightCamera.depthTextureMode = DepthTextureMode.Depth;
		lightCamera.targetTexture = renderTexture;
	}

	private void OnRenderImage(RenderTexture src, RenderTexture dest) {
		Graphics.Blit (src, dest, renderMaterial, 0);
	}
}
