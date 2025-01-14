Class {
	#name : #ToTripletElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletElement',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait',
	#instVars : [
		'properties'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToTripletElement >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #initialization }
ToTripletElement >> initialize [

	super initialize.
	self initializeAsTripletElement 
]

{ #category : #skin }
ToTripletElement >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : #'t - orientable - accessing' }
ToTripletElement >> layoutStrategy [

	^ self layout
]

{ #category : #layout }
ToTripletElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self configureLayout.
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'t - triplet element - private - accessing' }
ToTripletElement >> properties [

	^ properties
]

{ #category : #'t - triplet element - private - accessing' }
ToTripletElement >> properties: aTripletElementProperties [

	properties ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	properties := aTripletElementProperties
]

{ #category : #dependencies }
ToTripletElement >> release [ 

	super release.
	properties release.
	properties := nil
]
