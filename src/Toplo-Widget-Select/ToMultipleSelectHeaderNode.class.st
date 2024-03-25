Class {
	#name : #ToMultipleSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToMultipleSelectHeaderNode >> installRawStyle [ 

	super installRawStyle.
	middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3)
]

{ #category : #layout }
ToMultipleSelectHeaderNode >> isFullyVisible [

	| intersection bnds pbnds select |
	self measuredWidth isZero ifTrue: [^ true ].
	select := self selectHolder select.
	bnds := (self measuredBounds inParent: select) asRectangle.
	pbnds := (select headerElement measuredBounds inParent: select) asRectangle.
	pbnds := pbnds withRight: (pbnds right - select textInputElement measuredWidth).
	intersection := bnds intersect: pbnds.
	^ intersection = bnds
]

{ #category : #layout }
ToMultipleSelectHeaderNode >> isFullyVisibleInBounds: aRectangle [

	| intersection bnds select |
	self measuredWidth isZero ifTrue: [^ true ].
	select := self selectHolder select.
	bnds := (self measuredBounds inParent: select) asRectangle.
	intersection := bnds intersect: aRectangle.
	^ intersection = bnds
]
