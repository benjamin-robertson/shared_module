# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include shared_module
class shared_module {
  file { '/tmp/shared.txt':
    content => 'This content is from the shared module.',
  }
  file { '/blah.txt':
    content => 'blah content',
  }

  include shared_module::test
}
