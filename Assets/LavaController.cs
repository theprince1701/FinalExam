using UnityEngine;


public class LavaController : MonoBehaviour
{
    [SerializeField] private float normalScrollSpeed;
    [SerializeField] private float transitionSpeed;
    [SerializeField] private Material material;
    [SerializeField] private LavaState[] states;

    [System.Serializable]
    public class LavaState
    {
        public enum LavaTypes
        {
            Calm,
            Intense
        }

        public LavaTypes type;
        public float amp;
        public float speed;
    }

    private LavaState _currentLava;
    private int _currentLavaIndex;

    private float _currentAmp;
    private float _currentSpeed;
    
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Tab))
        {
            _currentLavaIndex++;
            _currentLavaIndex %= states.Length;
        }

        _currentLava = states[_currentLavaIndex];

        _currentAmp = Mathf.Lerp(_currentAmp, _currentLava.amp, Time.deltaTime * transitionSpeed);
        _currentSpeed = Mathf.Lerp(_currentSpeed, _currentLava.speed, Time.deltaTime * transitionSpeed);
        
        material.SetFloat("_ScrollSpeed", normalScrollSpeed * Time.deltaTime);
        material.SetFloat("_Amplitude", _currentAmp);
        material.SetFloat("_Speed", _currentSpeed);
    }
}
