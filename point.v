module geometry

import math

pub type TransformerFn[T] = fn (T) T

[heap]
pub struct Transformer {
pub:
	x TransformerFn[f64] = unit_fn[f64]()
	y TransformerFn[f64] = unit_fn[f64]()
	z TransformerFn[f64] = unit_fn[f64]()
	t TransformerFn[f64] = unit_fn[f64]()
}

pub fn unit_fn[T]() TransformerFn[T] {
	return fn [T](x T) T {
		return x
	}
}

[heap]
pub struct Point {
pub:
	x   f64
	y   f64
	z   f64
	t   f64
	tag string
}

const (
	i = Point{1, 0, 0, 0, 'I'}
	j = Point{0, 1, 0, 0, 'J'}
	k = Point{0, 0, 1, 0, 'K'}
	l = Point{0, 0, 0, 1, 'L'}
)

pub fn point_new(x f64, y f64) Point {
	return Point{x, y, 0, 0, ''}
}

pub fn (p Point) clone() Point {
	mut q := Point{
		x: p.x
		y: p.y
		z: p.z
		t: p.t
		tag: p.tag
	}
	return q
}

pub fn (p Point) morph(v Transformer) Point {
	mut q := Point{
		x: v.x(p.x)
		y: v.y(p.y)
		z: v.z(p.z)
		t: v.t(p.t)
		tag: p.tag
	}
	return q
}

pub fn (p Point) isomorph(f fn (x f64) f64) Point {
	return p.morph(Transformer{f, f, f, f})
}

pub fn (p Point) add(o Point) Point {
	mut q := Point{
		x: p.x + o.x
		y: p.y + o.y
		z: p.z + o.z
		t: p.t + o.t
		tag: p.tag
	}
	return q
}

pub fn (p Point) sub(o Point) Point {
	mut q := Point{
		x: p.x - o.x
		y: p.y - o.y
		z: p.z - o.z
		t: p.t - o.t
		tag: p.tag
	}
	return q
}

pub fn (p Point) scale(o Point) Point {
	mut q := Point{
		x: p.x * o.x
		y: p.y * o.y
		z: p.z * o.z
		t: p.t * o.t
	}
	return q
}

pub fn (p Point) mul(n f64) Point {
	mut q := Point{
		x: p.x * n
		y: p.y * n
		z: p.z * n
		t: p.t * n
		tag: p.tag
	}
	return q
}

pub fn (p Point) dot(o Point) f64 {
	return p.x * o.x + p.y * o.y + p.z * o.z + p.t * o.t
}

pub fn (p Point) len2() f64 {
	q := p.scale(geometry.i.add(geometry.j))
	return q.dot(q)
}

pub fn (p Point) len3() f64 {
	q := p.scale(geometry.i.add(geometry.j))
	return q.dot(q)
}

pub fn (p Point) len() f64 {
	return math.sqrt(p.len2())
}

pub fn (p Point) norm() Point {
	r := p.len()
	return p.mul(1 / r)
}

pub fn (p Point) rad() f64 {
	a := math.atan2(p.y, p.x)
	if a > 0 {
		return a
	} else {
		return 2 * math.pi + a
	}
}

pub fn (p Point) deg() f64 {
	return math.degrees(p.rad())
}

pub fn (p Point) to_polar() Point {
	a := p.rad()
	r := p.len()
	return point_new(r, a)
}

pub fn (p Point) to_orthogonal() Point {
	x := p.x * math.cos(p.y)
	y := p.x * math.sin(p.y)
	return point_new(x, y)
}

pub fn (p Point) round(scale f64) Point {
	return p.isomorph(fn [scale] (x f64) f64 {
		return math.round(x / scale) * scale
	})
}

pub fn (p Point) floor(scale f64) Point {
	return p.isomorph(fn [scale] (x f64) f64 {
		return math.floor(x / scale) * scale
	})
}

pub fn (p Point) ceil(scale f64) Point {
	return p.isomorph(fn [scale] (x f64) f64 {
		return math.ceil(x / scale) * scale
	})
}

pub fn (p Point) string() string {
	return 'Point{${p.x},${p.y},${p.z},${p.t},${p.tag}}'
}
