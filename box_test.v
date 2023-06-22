module geometry

fn test_box_create() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	println(b.string())
	assert b.anchor.x == 10
	assert b.anchor.y == 20
}

fn test_box_clone() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	mut g := b.clone()
	println(b.string())
	println(g.string())
	assert b.anchor.x == g.anchor.x
	assert b.anchor.y == g.anchor.y
}

fn test_box_corner() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	c := b.corner()
	println(b.string())
	println(c.string())
	assert b.anchor.x + b.size.x == c.x
	assert b.anchor.y + b.size.y == c.y
}

fn test_box_contains_point() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	a := b.anchor
	c := b.corner()
	pin := point_new(11, 21)
	pout := point_new(9, 19)
	assert b.contains_point(a)
	assert b.contains_point(c)
	assert b.contains_point(pin)
	assert !b.contains_point(pout)
}

fn test_box_contains_box() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	b2 := Box{point_new(20, 20), point_new(10, 10)}
	assert b.contains_box(b2)
}

fn test_box_intersects_box() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	b2 := Box{point_new(20, 20), point_new(10, 10)}
	b3 := Box{point_new(0, 0), point_new(40, 50)}
	assert b.intersects_box(b2)
	assert b.intersects_box(b3)
}

fn test_box_corners() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	c := b.corners()
	assert c.len == 4
	println(c[0].string())
	println(c[1].string())
	println(c[2].string())
	println(c[3].string())
	assert c[0] == b.anchor
	assert c[1] == point_new(10, 95)
	assert c[2] == b.corner()
	assert c[3] == point_new(110, 20)
}

fn test_box_for_each_slice() {
	b := Box{point_new(10, 20), point_new(100, 75)}
	println(b.string())
	mut count := 0

	for value in b.slices(20) {
		println('iter[]=[${value}]')
		count++
	}

	println(count)

	assert count == 40
}

fn test_box_all_slices() {
	bx := Box{point_new(10, 20), point_new(100, 75)}
	println(bx.string())
	slices := bx.all_slices(20)

	println(slices)

	assert slices.len == 40
}

fn test_box_iterator() {
	bi := BoxIterator{
		start: point_new(10, 20)
		end: point_new(100, 75)
		step: point_new(20, 20)
	}
	mut count := 0

	for value in bi {
		// println("iter[]=[${value}]")
		count++
	}

	println(count)

	assert count == 25
}
