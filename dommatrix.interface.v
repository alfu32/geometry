module geometry

pub interface DOMMatrixInit {
	is_2d bool
	m13 f64
	m14 f64
	m23 f64
	m24 f64
	m31 f64
	m32 f64
	m33 f64
	m34 f64
	m43 f64
	m44 f64
}

pub interface DOMMatrix {
	a f64
	b f64
	c f64
	d f64
	e f64
	f f64
	m11 f64
	m12 f64
	m13 f64
	m14 f64
	m21 f64
	m22 f64
	m23 f64
	m24 f64
	m31 f64
	m32 f64
	m33 f64
	m34 f64
	m41 f64
	m42 f64
	m43 f64
	m44 f64
	flip_x() DOMMatrix
	flip_y() DOMMatrix
	inverse() DOMMatrix
	multiply(other DOMMatrixInit) DOMMatrix
	rotate(rot_x f64, rot_y f64, rot_z f64) DOMMatrix
	rotate_axis_angle(x f64, y f64, z f64, angle f64) DOMMatrix
	rotate_from_vector(x f64, y f64) DOMMatrix
	scale(scale_x f64, scale_y f64, scale_z f64, origin_x f64, origin_y f64, origin_z f64) DOMMatrix
	scale3d(scale f64, origin_x f64, origin_y f64, origin_z f64) DOMMatrix
	//* @deprecated
	scale_non_uniform(scale_x f64, scale_y f64) DOMMatrix
	skew_x(sx f64) DOMMatrix
	skew_y(sy f64) DOMMatrix
	to_float32_array() []f32
	to_float64_array() []f64
	to_json() string
	transform_point(x f64, y f64, z f64) (f64, f64, f64)
	translate(tx f64, ty f64, tz f64) DOMMatrix
	to_string() string
	invert_self() DOMMatrix
	multiply_self(other DOMMatrixInit) DOMMatrix
	pre_multiply_self(other DOMMatrixInit) DOMMatrix
	rotate_axis_angle_self(x f64, y f64, z f64, angle f64) DOMMatrix
	rotate_from_vector_self(x f64, y f64) DOMMatrix
	rotate_self(rot_x f64, rot_y f64, rot_z f64) DOMMatrix
	scale3d_self(scale f64, origin_x f64, origin_y f64, origin_z f64) DOMMatrix
	scale_self(scale_x f64, scale_y f64, scale_z f64, origin_x f64, origin_y f64, origin_z f64) DOMMatrix
	set_matrix_value(transform_list string) DOMMatrix
	skew_x_self(sx f64) DOMMatrix
	skew_y_self(sy f64) DOMMatrix
	translate_self(tx f64, ty f64, tz f64) DOMMatrix
}
