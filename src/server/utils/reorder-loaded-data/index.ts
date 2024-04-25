export function reorderLoadedData<T extends { id: string }>(
  ids: string[] | readonly string[],
  entities: T[]
): (T | null)[] {
  const map: Record<string, T> = entities.reduce((map, entity) => {
    if (map[entity.id] !== undefined) {
      throw new Error("Duplicate ids detected");
    }

    return {
      ...map,
      [entity.id]: entity,
    };
  }, {} as Record<string, T>);

  return ids.map((id) => map[id] ?? null);
}

export function reorderLoadedDataWithComplexKey<T>(
  ids: Partial<T>[] | readonly Partial<T>[],
  entities: T[],
  compareFn: (id: Partial<T>, item: T) => boolean
): (T | null)[] {
  return ids.map((id) => {
    return entities.find((e) => compareFn(id, e)) ?? null;
  });
}
