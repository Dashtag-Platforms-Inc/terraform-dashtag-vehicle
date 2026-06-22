package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// TestVehicle applies examples/complete — creating a throwaway vehicle with
// albums, a maintenance record, and a modification against the live API —
// asserts the outputs, then destroys everything.
// Requires DASHTAG_API_TOKEN in the environment.
func TestVehicle(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir: "../examples/complete",
		NoColor:      true,
	}
	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	assert.NotEmpty(t, terraform.Output(t, opts, "vehicle_id"))
	require.Len(t, terraform.OutputMap(t, opts, "album_ids"), 2)
	require.Len(t, terraform.OutputMap(t, opts, "maintenance_ids"), 1)
	require.Len(t, terraform.OutputMap(t, opts, "modification_ids"), 1)
}
