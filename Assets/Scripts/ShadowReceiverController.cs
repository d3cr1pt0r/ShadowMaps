using UnityEngine;
using System.Collections;

public class ShadowReceiverController : MonoBehaviour {

	[SerializeField] private ShadowMapGenerator shadowMapGenerator;
	[SerializeField] private Renderer rend;
	[SerializeField] private Camera lightCamera;

	private void LateUpdate() {
		if (shadowMapGenerator.GetRenderTexture () != null) {
			rend.material.SetTexture ("_CameraTex", shadowMapGenerator.GetRenderTexture ());
		}

		Matrix4x4 lightMatrix = lightCamera.projectionMatrix * lightCamera.worldToCameraMatrix;
		rend.material.SetMatrix ("lightMatrix", lightMatrix);
	}

}
