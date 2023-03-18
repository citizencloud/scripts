package foo

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_Foo(t *testing.T) {
	assert.Equal(t, zanzibar(), "mamamia")
}
