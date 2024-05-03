Class {
	#name : #ToElementBarNode,
	#superclass : #ToElement,
	#traits : 'TToElementWithTripletElement',
	#classTraits : 'TToElementWithTripletElement classTrait',
	#instVars : [
		'triplet',
		'holder'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #layout }
ToElementBarNode >> autoDistribute [

	self startFlexible: true.
	self endFlexible: true.
	self tripletElement constraintsDo: [ :c | c horizontal matchParent ].
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c linear weight: 1.
		c flow weight: 1 ]
]

{ #category : #accessing }
ToElementBarNode >> holder [

	^ holder 
]

{ #category : #accessing }
ToElementBarNode >> holder: aElementNodeHolder [

	holder := aElementNodeHolder
]

{ #category : #initialization }
ToElementBarNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self layout: BlLinearLayout horizontal.
	triplet := ToTripletElement new.
	self addChild: triplet.
	self childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self fitContent
]

{ #category : #skin }
ToElementBarNode >> installRawStyle [ 

	super installRawStyle.
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3)
]

{ #category : #layout }
ToElementBarNode >> isFullyVisible [

	| intersection bnds pbnds bar |
	self measuredWidth isZero ifTrue: [ ^ true ].
	bar := self holder elementBar.
	bnds := (self measuredBounds inParent: bar nodeContainer) asRectangle.
	pbnds := bar nodeContainer measuredBounds asRectangle.
	pbnds := pbnds withRight: pbnds right - bar textInputElement measuredWidth.
	intersection := bnds intersect: pbnds.
	^ intersection = bnds
]

{ #category : #testing }
ToElementBarNode >> isRemovable [

	^ false
]

{ #category : #'api - hooks' }
ToElementBarNode >> onInstalledIn: anElementBar [

]

{ #category : #'api - hooks' }
ToElementBarNode >> onUninstalledIn: anElementBar [

]

{ #category : #private }
ToElementBarNode >> removeFromBar [
	" 
	First, try to remove the node by deselecting the corresponding list node in the list (if found). 
	Second, if the data is not one of the actual list element data, remove the data through the select "

	|  bar  |
	bar := self holder elementBar.
	bar removeNode: self
]

{ #category : #'t - element with triplet element' }
ToElementBarNode >> tripletElement [

	^ triplet
]
