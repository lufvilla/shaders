using UnityEngine;

public class PaletteSwappingScript : MonoBehaviour
{
    public Material Material;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, Material);
    }
}
