using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RockSpawner : MonoBehaviour
{
    [Range(0, 100)]
    public float maxDistance;
    [Range(-100, 0)]
    public float minDistance;

    public int numberOfRocks;

    public List<GameObject> rocks;

    private void Awake()
    {
        for(int i = 0; i < rocks.Count; i++)
        {
            SpawnRocks(rocks[i]);
        }
    }

    void SpawnRocks(GameObject obj)
    {
        for(int i = 0; i < numberOfRocks; i++)
        {
            float xSPawnPoint = Random.Range(minDistance,maxDistance);
            float zSpawnPoint = Random.Range(minDistance, maxDistance);
            Vector3 spawnPoint = new Vector3(xSPawnPoint,transform.localPosition.y,zSpawnPoint);
            transform.localPosition = spawnPoint;

            Instantiate(obj,transform);
            
        }
    }
}
