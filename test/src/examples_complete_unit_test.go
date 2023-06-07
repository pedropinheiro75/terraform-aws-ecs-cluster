//go:build unit
// +build unit

package test

import (
	"github.com/gruntwork-io/terratest/modules/random"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestECSCompleteValidation(t *testing.T) {
	t.Parallel()

	rootFolder := "../../"
	randID := strings.ToLower(random.UniqueId())
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"enabled": "true",
			"suffix":  randID,
		},
	}

	output := terraform.InitAndPlan(t, terratestOptions)
	assert.Contains(t, output, "2 to add, 0 to change, 0 to destroy", "Plan OK and should attempt to create 2 resources")
}
