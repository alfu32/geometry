module geometry

pub fn test_new() {
	mut a := new_matrix()
	mut b := new_matrix()
	assert a.to_string() == b.to_string()
}

pub fn test_create() {
	mut a := create_matrix(1, 2, 3, 4, 5, 6)
	println(a.to_string())
	assert a.to_string() == 'Matrix3{1.0,2.0,3.0,4.0,5.0,6.0,0.0,0.0,1.0}'
}

pub fn test_mul1() {
	mut a := new_matrix()
	mut b := new_matrix()
	mut c := a.mul(b)
	println(a.to_string())
	println(b.to_string())
	println(c.to_string())
	assert a.to_string() == c.to_string()
	assert b.to_string() == c.to_string()
}

pub fn test_mul2() {
	mut a := create_matrix(1, 2, 3, 4, 5, 6)
	mut b := new_matrix()
	mut c := a.mul(b)
	println(a.to_string())
	println(b.to_string())
	println(c.to_string())
	assert a.to_string() == c.to_string()
}

pub fn test_mul3() {
	mut a := Matrix3{1, 1, 1, 1, 1, 1, 1, 1, 1}
	mut b := Matrix3{1, 1, 1, 1, 1, 1, 1, 1, 1}
	mut c := a.mul(b)
	println(a.to_string())
	println(b.to_string())
	println(c.to_string())
	assert c.to_string() == 'Matrix3{3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0}'
}

pub fn test_adjugate() {
	mut a := create_matrix(1, 2, 3, 4, 5, 6)
	c := a.adjugate()
	m := a.mul(c)
	println(a.to_pretty_string())
	println(c.to_pretty_string())
	println(m.to_pretty_string())

	mut b := new_matrix()
	mut d := b.adjugate()
	println(b.to_pretty_string())
	println(d.to_pretty_string())
}

pub fn test_determinant() {
	mut a := create_matrix(1, 2, 3, 4, 5, 6)
	c := a.det()
	println(a.to_string())
	println(c)

	mut b := new_matrix()
	mut d := b.det()
	println(b.to_string())
	println(d)
}

pub fn test_inverse() {
	mut a := create_matrix(1, 2, 3, 4, 5, 6)
	a1 := a.inverse()
	aa1 := a.mul(a1)
	println(a.to_pretty_string())
	println(a1.to_pretty_string())
	println(aa1.to_pretty_string())

	mut b := new_matrix()
	mut b1 := b.inverse()
	bb1 := b.mul(b1)
	println(b.to_pretty_string())
	println(b1.to_pretty_string())
	println(bb1.to_pretty_string())
}
