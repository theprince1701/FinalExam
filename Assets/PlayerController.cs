using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    [SerializeField] private Transform[] targets;
    [SerializeField] private float speed;

    private Transform _currentTarget;
    private int _currentTargetIndex;

    private void Update()
    {
        _currentTarget = targets[_currentTargetIndex];

        if (_currentTarget != null)
        {
            float dist = (_currentTarget.position - transform.position).magnitude;

            if (dist <= 1.5f)
            {
                _currentTargetIndex++;
                _currentTargetIndex %= targets.Length;
            }
            
            transform.position = Vector3.Lerp(transform.position, _currentTarget.position, speed * Time.deltaTime) ;
        }
    }
}
