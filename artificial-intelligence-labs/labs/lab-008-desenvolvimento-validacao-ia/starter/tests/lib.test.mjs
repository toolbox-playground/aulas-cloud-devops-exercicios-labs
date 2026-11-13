import {test} from 'node:test';
import assert from 'node:assert/strict';
import {formatHora} from '../lib.mjs';

test('formatHora mostra HH:MM em UTC', () => {
  assert.equal(formatHora('2026-11-13T09:05:00Z'), '09:05 UTC');
});
