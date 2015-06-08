package com.sandinh.core;

//contains methods in develoment branch of haxe
class LambdaNext {
    /**
		Concatenate a list of lists.

		The order of elements is preserved.
	**/
	public static function flatten<A>( it : Iterable<Iterable<A>> ) : List<A> {
		var l = new List<A>();
		for (e in it)
			for (x in e)
				l.add(x);
		return l;
	}

	/**
		A composition of map and flatten.

		The order of elements is preserved.

		If `f` is null, the result is unspecified.
	**/
	public static function flatMap<A,B>( it : Iterable<A>, f: A -> Iterable<B> ) : List<B> {
		return flatten(Lambda.map(it, f));
	}
}

//Lambda for Iterator. The code is copy to Lambda class, then change Iterable to Iterator
class LambdaIterator {
	/**
		Creates an Array from Iterable `it`.

		If `it` is an Array, this function returns a copy of it.
	**/
	public static function array<A>( it : Iterator<A> ) : Array<A> {
		var a = new Array<A>();
		for(i in it)
			a.push(i);
		return a;
	}

	/**
		Creates a List form Iterable `it`.

		If `it` is a List, this function returns a copy of it.
	**/
	public static function list<A>( it : Iterator<A> ) : List<A> {
		var l = new List<A>();
		for(i in it)
			l.add(i);
		return l;
	}

	/**
		Creates a new List by applying function `f` to all elements of `it`.

		The order of elements is preserved.

		If `f` is null, the result is unspecified.
	**/
	public static function map<A,B>( it : Iterator<A>, f : A -> B ) : List<B> {
		var l = new List<B>();
		for( x in it )
			l.add(f(x));
		return l;
	}

	/**
		Similar to map, but also passes the index of each element to `f`.

		The order of elements is preserved.

		If `f` is null, the result is unspecified.
	**/
	public static function mapi<A,B>( it : Iterator<A>, f : Int -> A -> B ) : List<B> {
		var l = new List<B>();
		var i = 0;
		for( x in it )
			l.add(f(i++,x));
		return l;
	}

	/**
		Concatenate a list of lists.

		The order of elements is preserved.
	**/
	public static function flatten<A>( it : Iterator<Iterator<A>> ) : List<A> {
		var l = new List<A>();
		for (e in it)
			for (x in e)
				l.add(x);
		return l;
	}

	/**
		A composition of map and flatten.

		The order of elements is preserved.

		If `f` is null, the result is unspecified.
	**/
	public static inline function flatMap<A,B>( it : Iterator<A>, f: A -> Iterator<B> ) : List<B> {
		return flatten(map(it, f).iterator());
	}

	/**
		Tells if `it` contains `elt`.

		This function returns true as soon as an element is found which is equal
		to `elt` according to the `==` operator.

		If no such element is found, the result is false.
	**/
	public static function has<A>( it : Iterator<A>, elt : A ) : Bool {
		for( x in it )
			if( x == elt )
				return true;
		return false;
	}

	/**
		Tells if `it` contains an element for which `f` is true.

		This function returns true as soon as an element is found for which a
		call to `f` returns true.

		If no such element is found, the result is false.

		If `f` is null, the result is unspecified.
	**/
	public static function exists<A>( it : Iterator<A>, f : A -> Bool ) {
		for( x in it )
			if( f(x) )
				return true;
		return false;
	}

	/**
		Tells if `f` is true for all elements of `it`.

		This function returns false as soon as an element is found for which a
		call to `f` returns false.

		If no such element is found, the result is true.

		In particular, this function always returns true if `it` is empty.

		If `f` is null, the result is unspecified.
	**/
	public static function foreach<A>( it : Iterator<A>, f : A -> Bool ) {
		for( x in it )
			if( !f(x) )
				return false;
		return true;
	}

	/**
		Calls `f` on all elements of `it`, in order.

		If `f` is null, the result is unspecified.
	**/
	public static function iter<A>( it : Iterator<A>, f : A -> Void ) {
		for( x in it )
			f(x);
	}

	/**
		Returns a List containing those elements of `it` for which `f` returned
		true.

		If `it` is empty, the result is the empty List even if `f` is null.

		Otherwise if `f` is null, the result is unspecified.
	**/
	public static function filter<A>( it : Iterator<A>, f : A -> Bool ) {
		var l = new List<A>();
		for( x in it )
			if( f(x) )
				l.add(x);
		return l;
	}

	/**
		Functional fold on Iterator `it`, using function `f` with start argument
		`first`.

		If `it` has no elements, the result is `first`.

		Otherwise the first element of `it` is passed to `f` alongside `first`.
		The result of that call is then passed to `f` with the next element of
		`it`, and so on until `it` has no more elements.

		If `it` or `f` are null, the result is unspecified.
	**/
	public static function fold<A,B>( it : Iterator<A>, f : A -> B -> B, first : B ) : B {
		for( x in it )
			first = f(x,first);
		return first;
	}

	/**
		Returns the number of elements in `it` for which `pred` is true, or the
		total number of elements in `it` if `pred` is null.

		This function traverses all elements.
	**/
	public static function count<A>( it : Iterator<A>, ?pred : A -> Bool ) {
		var n = 0;
		if( pred == null )
			for( _ in it )
				n++;
		else
			for( x in it )
				if( pred(x) )
					n++;
		return n;
	}

	/**
		Tells if Iterator `it` does not contain any element.
	**/
	public static inline function empty<T>( it : Iterator<T> ) : Bool {
		return !it.hasNext();
	}

	/**
		Returns the index of the first element `v` within Iterator `it`.

		This function uses operator `==` to check for equality.

		If `v` does not exist in `it`, the result is -1.
	**/
	public static function indexOf<T>( it : Iterator<T>, v : T ) : Int {
		var i = 0;
		for( v2 in it ) {
			if( v == v2 )
				return i;
			i++;
		}
		return -1;
	}

	/**
		Returns the first element of `it` for which `f` is true.

		This function returns as soon as an element is found for which a call to
		`f` returns true.

		If no such element is found, the result is null.

		If `f` is null, the result is unspecified.
	**/
	public static function find<T>( it : Iterator<T>, f : T -> Bool ) : Null<T> {
		for( v in it ) {
			if(f(v)) return v;
		}
		return null;
	}

	/**
		Returns a new List containing all elements of Iterator `a` followed by
		all elements of Iterator `b`.

		If `a` or `b` are null, the result is unspecified.
	**/
	public static function concat<T>( a : Iterator<T>, b : Iterator<T> ) : List<T> {
		var l = new List();
		for( x in a )
			l.add(x);
		for( x in b )
			l.add(x);
		return l;
	}
}

class LambdaIteratorEx {
	public static function skip<T>(it : Iterator<T>, n: Int): Iterator<T> {
		for(i in 0...n) it.next();
		return it;
	}
}