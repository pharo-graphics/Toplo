Class {
	#name : #ToNode,
	#superclass : #BlElement,
	#traits : 'TToEnableable',
	#classTraits : 'TToEnableable classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #private }
ToNode >> endWidthGap [

	^ 0
]

{ #category : #initialization }
ToNode >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self padding: (BlInsets horizontal: 4).
	self setInitialLayoutConstraints 
]

{ #category : #testing }
ToNode >> isFullyVisible [

	| bnds list |
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list nodeContainer) asRectangle.
	^ self nodeContainerIntersection = bnds
]

{ #category : #testing }
ToNode >> isPartlyVisible [

	^ self nodeContainerIntersection isZero not
]

{ #category : #testing }
ToNode >> nodeContainerIntersection [

	| intersection bnds pbnds list |
	self measuredWidth isZero ifTrue: [ ^ true ].
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list nodeContainer) asRectangle.
	pbnds := list nodeContainer measuredBounds asRectangle.
	pbnds := pbnds withRight: pbnds right - self endWidthGap.
	intersection := bnds intersect: pbnds.
	^ intersection 
]

{ #category : #dependencies }
ToNode >> release [ 

	self removeChildren.
	super release.

]

{ #category : #initialization }
ToNode >> setInitialLayoutConstraints [

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]
