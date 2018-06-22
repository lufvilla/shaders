using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
public class CameraTransition : MonoBehaviour
{
	public Material Material;

	[Range(0, 1)]
	public float CurrentTransition;

	public Camera SecondCamera;

	public void ChangeTransitionValue(Slider slider)
	{
		CurrentTransition = slider.value;
	}

	private void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		SecondCamera.gameObject.SetActive(CurrentTransition > 0);

		Material.SetFloat("_Transition", CurrentTransition);
		Graphics.Blit(src, dest, Material);
	}
}
