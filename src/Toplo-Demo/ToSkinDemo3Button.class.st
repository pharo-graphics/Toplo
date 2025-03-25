Class {
	#name : #ToSkinDemo3Button,
	#superclass : #BlElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'clicked'
	],
	#category : #'Toplo-Demo-Skin Demo - 3'
}

{ #category : #'as yet unclassified' }
ToSkinDemo3Button class >> exampleUsingTokens [

	self new
		position: 50 asPoint;
		initializeTokens;
		openInSpace
]

{ #category : #'as yet unclassified' }
ToSkinDemo3Button class >> exampleWithNewTheme [

	| space |
	space := BlSpace new.
	space toTheme: ToSkinDemoTheme new.
	
	space root addChild: (self new
		position: 50 asPoint;
		yourself).
	space show 
]

{ #category : #public }
ToSkinDemo3Button >> click [ 

	clicked := clicked not
]

{ #category : #public }
ToSkinDemo3Button >> clicked [ 

	^ clicked
]

{ #category : #initialization }
ToSkinDemo3Button >> initialize [

	super initialize.

	clicked := false.
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		self click ].

	self initializeForToplo.
]

{ #category : #'as yet unclassified' }
ToSkinDemo3Button >> initializeTokens [

	self addAllTokenProperties: {
			(#'background-clicked' -> Color lightGreen) asTokenProperty.
			(#'background-not-clicked' -> Color lightRed) asTokenProperty.
			(#'background-clicked-hovered' -> Color lightGreen darker)
				asTokenProperty.
			(#'background-not-clicked-hovered' -> Color lightRed darker)
				asTokenProperty }
]

{ #category : #'as yet unclassified' }
ToSkinDemo3Button >> newRawSkin [

	^ SkinDemo3ButtonSkin new
]

{ #category : #'as yet unclassified' }
ToSkinDemo3Button >> newSkinDemoSkin [ 

	^ SkinDemo3ButtonSkin new
]
