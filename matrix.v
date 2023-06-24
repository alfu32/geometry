module geometry

import math

struct Matrix3 {
pub mut:
	a11 f64 = 1.0
	a12 f64 = 0.0
	a13 f64 = 0.0
	a21 f64 = 0.0
	a22 f64 = 1.0
	a23 f64 = 0.0
	a31 f64 = 0.0
	a32 f64 = 0.0
	a33 f64 = 1.0
}

pub fn identity() Matrix3 {
	return Matrix3{
		a11: 1.0
		a12: 0.0
		a13: 0.0
		a21: 0.0
		a22: 1.0
		a23: 0.0
		a31: 0.0
		a32: 0.0
		a33: 1.0
	}
}

pub fn create_transform_matrix(a f64, b f64, c f64, d f64, e f64, f f64) Matrix3 {
	return Matrix3{
		a11: a
		a12: b
		a13: c
		a21: d
		a22: e
		a23: f
		a31: 0.0
		a32: 0.0
		a33: 1.0
	}
}

pub fn (m Matrix3) amplify(n f64) Matrix3 {
	return Matrix3{
		a11: n * m.a11
		a12: n * m.a12
		a13: n * m.a13
		a21: n * m.a21
		a22: n * m.a22
		a23: n * m.a21
		a31: n * m.a31
		a32: n * m.a32
		a33: n * m.a33
	}
}

pub fn (m Matrix3) attenuate(n f64) Matrix3 {
	return Matrix3{
		a11: m.a11 / n
		a12: m.a12 / n
		a13: m.a13 / n
		a21: m.a21 / n
		a22: m.a22 / n
		a23: m.a23 / n
		a31: m.a31 / n
		a32: m.a32 / n
		a33: m.a33 / n
	}
}

pub fn (m Matrix3) adjust(b Matrix3) Matrix3 {
	return Matrix3{
		a11: b.a11 * m.a11
		a12: b.a12 * m.a12
		a13: b.a13 * m.a13
		a21: b.a21 * m.a21
		a22: b.a22 * m.a22
		a23: b.a23 * m.a23
		a31: b.a31 * m.a31
		a32: b.a32 * m.a32
		a33: b.a33 * m.a33
	}
}

pub fn (m Matrix3) transpose() Matrix3 {
	return Matrix3{
		a11: m.a11
		a12: m.a21
		a13: m.a31
		a21: m.a12
		a22: m.a22
		a23: m.a32
		a31: m.a13
		a32: m.a23
		a33: m.a33
	}
}

pub fn (m Matrix3) adjugate() Matrix3 {
	return Matrix3{
		a11: m.a22 * m.a33 - m.a23 * m.a32
		a12: -(m.a12 * m.a33 - m.a32 * m.a13)
		a13: m.a12 * m.a23 - m.a13 * m.a22
		a21: -(m.a21 * m.a33 - m.a23 * m.a31)
		a22: (m.a11 * m.a33 - m.a13 * m.a31)
		a23: -(m.a11 * m.a23 - m.a13 * m.a21)
		a31: (m.a21 * m.a32 - m.a22 * m.a31)
		a32: -(m.a11 * m.a32 - m.a12 * m.a31)
		a33: (m.a11 * m.a22 - m.a12 * m.a21)
	}
}

pub fn (m Matrix3) det() f64 {
	// q:=m.adjugate().adjust(m)
	// return q.a11+q.a12+q.a13+q.a21+q.a22+q.a23+q.a31+q.a32+q.a33
	return m.a11 * (m.a22 * m.a33 - m.a23 * m.a32) - m.a12 * (m.a21 * m.a33 - m.a23 * m.a31) +
		m.a13 * (m.a21 * m.a32 - m.a22 * m.a31)
	// 	- m.a21*(m.a12*m.a33-m.a32*m.a13) + m.a22*(m.a11*m.a33-m.a13*m.a31) - m.a23*(m.a11*m.a32-m.a12*m.a31)
	// 	+ m.a13*(m.a12*m.a23-m.a13*m.a22) - m.a23*(m.a11*m.a23-m.a13*m.a21) + m.a33*(m.a11*m.a22-m.a12*m.a21)
}

pub fn (m Matrix3) inverse() Matrix3 {
	mut inv := m.adjugate()
	inv = inv.attenuate(m.det())
	// return q.a11+q.a12+q.a13+q.a21+q.a22+q.a23+q.a31+q.a32+q.a33
	return inv
	// 	- m.a21*(m.a12*m.a33-m.a32*m.a13) + m.a22*(m.a11*m.a33-m.a13*m.a31) - m.a23*(m.a11*m.a32-m.a12*m.a31)
	// 	+ m.a13*(m.a12*m.a23-m.a13*m.a22) - m.a23*(m.a11*m.a23-m.a13*m.a21) + m.a33*(m.a11*m.a22-m.a12*m.a21)
}

pub fn (m Matrix3) mul(n Matrix3) Matrix3 {
	return Matrix3{
		a11: m.a11 * n.a11 + m.a12 * n.a21 + m.a13 * n.a31
		a12: m.a11 * n.a12 + m.a12 * n.a22 + m.a13 * n.a32
		a13: m.a11 * n.a13 + m.a12 * n.a23 + m.a13 * n.a33
		a21: m.a21 * n.a11 + m.a22 * n.a21 + m.a23 * n.a31
		a22: m.a21 * n.a12 + m.a22 * n.a22 + m.a23 * n.a32
		a23: m.a21 * n.a13 + m.a22 * n.a23 + m.a23 * n.a33
		a31: m.a31 * n.a11 + m.a32 * n.a21 + m.a33 * n.a31
		a32: m.a31 * n.a12 + m.a32 * n.a22 + m.a33 * n.a32
		a33: m.a31 * n.a13 + m.a32 * n.a23 + m.a33 * n.a33
	}
}

pub fn (m Matrix3) translate(x f64, y f64) Matrix3 {
	return Matrix3{
		a11: m.a11
		a12: m.a12
		a13: m.a13 + x
		a21: m.a21
		a22: m.a22
		a23: m.a23 + y
		a31: m.a31
		a32: m.a32
		a33: m.a33
	}
}

pub fn (m Matrix3) rotate(a f64) Matrix3 {
	sa := math.sin(a)
	ca := math.cos(a)
	m0 := Matrix3{
		a11: ca
		a12: -sa
		a13: 0.0
		a21: sa
		a22: ca
		a23: 0.0
		a31: 0.0
		a32: 0.0
		a33: 1.0
	}
	return m.mul(m0)
}

pub fn (m Matrix3) scale(x f64, y f64) Matrix3 {
	m0 := Matrix3{
		a11: x
		a12: 0.0
		a13: 0.0
		a21: 0.0
		a22: y
		a23: 0.0
		a31: 0.0
		a32: 0.0
		a33: 1.0
	}
	return m.mul(m0)
}

pub fn (mut m Matrix3) transform(a f64, b f64, c f64, d f64, e f64, f f64) Matrix3 {
	mut m0 := create_transform_matrix(a, b, c, d, e, f)
	return m.mul(m0)
}

pub fn (m Matrix3) to_pretty_string() string {
	return '
	┌                                                    ┐
	│ (${m.a11:14.2f}) (${m.a12:14.2f}) (${m.a13:14.2f}) │
	│ (${m.a21:14.2f}) (${m.a22:14.2f}) (${m.a23:14.2f}) │
	│ (${m.a31:14.2f}) (${m.a32:14.2f}) (${m.a33:14.2f}) │
	└                                                    ┘
	'.trim_indent()
}

pub fn (m Matrix3) to_string() string {
	return 'Matrix3{${m.a11},${m.a12},${m.a13},${m.a21},${m.a22},${m.a23},${m.a31},${m.a32},${m.a33}}'
}

pub fn (m Matrix3) to_svg_string() string {
	return '${m.a11} ${m.a12} ${m.a13} ${m.a21} ${m.a22} ${m.a23}'
}

pub fn (m Matrix3) transform_coordinates(x f64, y f64) (f64, f64) {
	return x * m.a11 + y * m.a12 + m.a13, x * m.a21 + y * m.a22 + m.a23 //,x*m.a31+y*m.a32+z*m.a33
}
