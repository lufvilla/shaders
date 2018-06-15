using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CameraTransition : MonoBehaviour
{
	public Material Material;

	[Range(0, 1)]
	public float CurrentTransition;

	public void ChangeTransitionValue(Slider slider)
	{
		CurrentTransition = (int)slider.value;
	}

	private void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		Material.SetFloat("_Transition", CurrentTransition);
		Graphics.Blit(src, dest, Material);
	}
}
