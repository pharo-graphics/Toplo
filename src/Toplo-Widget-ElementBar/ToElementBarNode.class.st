Class {
	#name : #ToElementBarNode,
	#superclass : #ToTripletElement,
	#classTraits : 'TToElementWithTripletElement classTrait',
	#instVars : [
		'holder'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #layout }
ToElementBarNode >> autoDistribute [

	self startFlexible: true.
	self endFlexible: true.
	self constraintsDo: [ :c |
		self holder elementBar isHorizontal
			ifTrue: [ c horizontal matchParent ]
			ifFalse: [ c vertical matchParent ].
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
	self applySkinInstallerOnFirstRequest: true
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
	pbnds := pbnds withRight: pbnds right - self rightWidthGap.
	intersection := bnds intersect: pbnds.
	^ intersection = bnds
]

{ #category : #testing }
ToElementBarNode >> isRemovable [

	^ false
]

{ #category : #'api - hooks' }
ToElementBarNode >> onInstalledIn: aNodeContainer [

]

{ #category : #'api - hooks' }
ToElementBarNode >> onUninstalledIn: aNodeContainer [

]

{ #category : #layout }
ToElementBarNode >> rightWidthGap [

	^ 0
]
