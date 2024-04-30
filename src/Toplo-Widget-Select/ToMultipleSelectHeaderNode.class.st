Class {
	#name : #ToMultipleSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToMultipleSelectHeaderNode >> installRawStyle [ 

	super installRawStyle.
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3)
]

{ #category : #layout }
ToMultipleSelectHeaderNode >> isFullyVisible [

	| intersection bnds pbnds header |
	self measuredWidth isZero ifTrue: [^ true ].
	header := self headerNodeHolder headerElement.
	bnds := (self measuredBounds inParent: header) asRectangle.
	pbnds := (header measuredBounds) asRectangle.
	pbnds := pbnds withRight: (pbnds right - header textInputElement measuredWidth).
	intersection := bnds intersect: pbnds.
	^ intersection = bnds
]
