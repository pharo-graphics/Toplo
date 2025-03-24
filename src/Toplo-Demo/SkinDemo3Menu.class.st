Class {
	#name : #SkinDemo3Menu,
	#superclass : #BlElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'container'
	],
	#category : #'Toplo-Demo-Skin Demo - 3'
}

{ #category : #accessing }
SkinDemo3Menu >> container [ 

	^ container
]

{ #category : #initialization }
SkinDemo3Menu >> initialize [

	super initialize.
	self size: 100 @ 50.
	self margin: (BlInsets all: 2).
	self clipChildren: false.
	self initializeMenuItems.
	self initializeForToplo.
	self initializeTokens
]

{ #category : #initialization }
SkinDemo3Menu >> initializeMenuItems [

	container := BlElement new
		             background: Color lightGray muchLighter ;
						 geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		             constraintsDo: [ :c |
			             c vertical fitContent.
			             c horizontal fitContent.
			             c padding: (BlInsets all: 5) ];
		             layout: BlLinearLayout vertical;
		             position: 105 @ 0;
						 visibility: BlVisibility gone.

	1 to: 5 do: [ :i | container addChild: ToSkinDemo3Button new ].

	self addChild: container
]

{ #category : #initialization }
SkinDemo3Menu >> initializeTokens [

	self addAllTokenProperties: {
			(#'background-not-clicked' -> Color lightBlue) asTokenProperty.
			(#'background-not-clicked-hovered' -> Color lightBlue darker)
				asTokenProperty }
]

{ #category : #'as yet unclassified' }
SkinDemo3Menu >> newRawSkin [  

	^ SkinDemo3MenuSkin new
]
