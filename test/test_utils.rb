require 'test_helper'
require 'tmail'
require 'tmail/utils'

class TestUtils < Test::Unit::TestCase

include TMail::TextUtils

  def _test_new_boundary
    a = new_boundary()
    b = new_boundary()
    c = new_boundary()
    assert_instance_of String, a
    assert_instance_of String, b
    assert_instance_of String, c
    assert(a != b)
    assert(b != c)
    assert(c != a)
  end

  def test_unquote
    mail = TMail::Mail.new
    assert_equal('Hello', mail.unquote('"Hello"'))
  end
  
  def test_unquote_without_quotes
    mail = TMail::Mail.new
    assert_equal('Hello', mail.unquote('Hello'))
  end

  def test_unquote_with_nil
    mail = TMail::Mail.new
    assert_equal(nil, mail.unquote(nil))
  end

  # before adding strip:
  #
  # before quote_boundary: 'multipart/related; boundary="----_=_NextPart_001_01CE0390.F97F1AD6" ; type="multipart/alternative"'
  #  after quote_boundary: 'multipart/related; boundary=""----_=_NextPart_001_01CE0390.F97F1AD6" "; type="multipart/alternative"'
  #
  def test_quote_boundary
    mail = TMail::Mail.new
    @body = 'boundary="----_=_NextPart_001_01CE0390.F97F1AD6" ; type="multipart/alternative"'
    mail.quote_boundary
    assert_equal('boundary="----_=_NextPart_001_01CE0390.F97F1AD6" ; type="multipart/alternative"',@body)
  end
end
