using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
public class PaletteSwappingScript : MonoBehaviour
{
    [Header("Ramps")]
    [Range(0, 3)]
    public int CurrentRamp;
    public Texture2D[] Ramps;
    public Material PostProcessMaterial;
    
    [Header("Textures")]
    [Range(0, 3)]
    public int CurrentTexture;
    public Texture2D[] Textures;
    public Material TextureMaterial;

    public void ChangeCurrentRamp(Slider slider)
    {
        CurrentRamp = (int)slider.value;
    }
    
    public void ChangeCurrentTexture(Slider slider)
    {
        CurrentTexture = (int)slider.value;
        TextureMaterial.SetTexture("_MainTex", Textures[CurrentTexture]);
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        PostProcessMaterial.SetTexture("_Ramp", Ramps[CurrentRamp]);
        Graphics.Blit(src, dest, PostProcessMaterial);
    }
}
