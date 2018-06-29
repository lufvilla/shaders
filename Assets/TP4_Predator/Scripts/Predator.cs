using UnityEngine;
using UnityEngine.UI;

public class Predator : MonoBehaviour
{
    public Material Material;
    
    [Range(0, 1)]
    public float Transparency;

    public void OnTransparencyChange(Slider slider)
    {
        Transparency = slider.value;
        
        UpdateMaterial();
    }
    
    public void UpdateMaterial()
    {
        Material.SetFloat("_Opacity", Transparency);
    }
}
