import { Database } from '@ladybugdb/core';

export function getLadybugRuntimeVersion(): string {
  return Database.getVersion();
}
