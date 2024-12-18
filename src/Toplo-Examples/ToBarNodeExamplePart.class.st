"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_bar`
"
Class {
	#name : #ToBarNodeExamplePart,
	#superclass : #ToBarNode,
	#instVars : [
		'triplet'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #initialization }
ToBarNodeExamplePart >> initialize [

	super initialize.
	triplet := ToTripletElement new.
	triplet
		hMatchParent;
		vFitContent.
	self addChild: triplet.
	self initializeRemoveButton
]

{ #category : #initialization }
ToBarNodeExamplePart >> initializeRemoveButton [

	| but |
	but := ToButton new.
	but withNullSkin.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but geometry: BlCircleGeometry new.

	but whenClickedDo: [ :event | self removeFromBar ].

	but id: #removeButton.
	triplet startElement: but.
	triplet startInterspace: 5
]

{ #category : #accessing }
ToBarNodeExamplePart >> label [

	^ triplet middleElement
]

{ #category : #accessing }
ToBarNodeExamplePart >> label: aLabel [

	triplet middleElement: aLabel.
	aLabel applyStyle
]

{ #category : #initialization }
ToBarNodeExamplePart >> removeFromBar [

	self holder listElement dataAccessor removeAt: self holder position
]
