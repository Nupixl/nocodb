import { extractProjectRolePower, hasMinimumRoleAccess } from 'social-pixl-sdk';
import { NcError } from 'src/helpers/catchError';
import type { ProjectRoles } from 'social-pixl-sdk';

// Re-export getProjectRole from social-pixl-sdk to keep backward compatibility
export { getProjectRole } from 'social-pixl-sdk';

/**
 * Get the power of the project role of the user.
 * @param user - The user object.
 * @returns The power of the project role of the user.
 */
export function getProjectRolePower(user: any) {
  return extractProjectRolePower(user, () => {
    NcError.badRequest('Forbidden');
  });
}

/**
 * Check if the user has the minimum role to access the resource.
 * @param user - The user object.
 * @param minimumRole - The minimum role to access the resource.
 * @returns True if the user has the minimum role, false otherwise.
 */
export function hasMinimumRole(user: any, minimumRole: ProjectRoles): boolean {
  return hasMinimumRoleAccess(user, minimumRole, () => {
    NcError.badRequest('Forbidden');
  });
}
