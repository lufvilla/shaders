using UnityEngine;
using UnityEngine.UI;

public class PaletteSwappingScript : MonoBehaviour
{
    public Material Material;

    public Texture2D[] Ramps;

    [Range(0, 3)]
    public int CurrentTexture;

    public void ChangeCurrentTexture(Slider slider)
    {
        CurrentTexture = (int)slider.value;
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Material.SetTexture("_Ramp", Ramps[CurrentTexture]);
        Graphics.Blit(src, dest, Material);
    }
}
