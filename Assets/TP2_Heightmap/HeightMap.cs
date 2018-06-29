using UnityEngine;
using UnityEngine.UI;

public class HeightMap : MonoBehaviour
{
    public Material Material;

    [Header("Biome Transitions")]
    [Range(0, 1)]
    public float BiomeTransition;
    [Range(0, 1)]
    public float HighTransition;
    [Range(0, 1)]
    public float MediumTransition;
    [Range(0, 1)]
    public float LowTransition;
    
    [Header("Heighmap Params")]
    [Range(1, 5)]
    public float Tesselation;
    [Range(0, 5)]
    public float Offset;

    public void OnBiomeChange(Slider slider)
    {
        BiomeTransition = slider.value;
        HighTransition = slider.value;
        MediumTransition = slider.value;
        LowTransition = slider.value;
        
        UpdateMaterial();
    }
    
    public void OnTesselationChange(Slider slider)
    {
        Tesselation = slider.value;
        
        UpdateMaterial();
    }
    
    public void OnOffsetChange(Slider slider)
    {
        Offset = slider.value;
        
        UpdateMaterial();
    }

    public void UpdateMaterial()
    {
        Material.SetFloat("_HighLerp", HighTransition);
        Material.SetFloat("_MediumLerp", MediumTransition);
        Material.SetFloat("_LowLerp", LowTransition);
        Material.SetFloat("_Tesselation", Tesselation);
        Material.SetFloat("_Offset", Offset);
    }
}