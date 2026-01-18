import type { SortType } from 'social-pixl-sdk';
import { builderGenerator } from '~/utils/data-transformation.builder';

export const sortBuilder = builderGenerator<SortType[], Partial<SortType>>({
  allowed: ['id', 'fk_column_id', 'direction'],
  mappings: {
    fk_column_id: 'field_id',
  },
});
