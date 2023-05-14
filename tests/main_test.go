package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSSelfManagedK8sModule(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t,
		&terraform.Options{
			TerraformDir: "../",
		},
	)
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

}
