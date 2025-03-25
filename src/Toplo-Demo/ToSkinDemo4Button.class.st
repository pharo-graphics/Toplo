Class {
	#name : #ToSkinDemo4Button,
	#superclass : #BlElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'clicked'
	],
	#category : #'Toplo-Demo-Skin Demo - 4'
}

{ #category : #'as yet unclassified' }
ToSkinDemo4Button class >> exampleWithNewTheme [

	| space |
	space := BlSpace new.
	space toTheme: ToSkinDemoStyleSheetTheme new.

	space root addChild: (self new
			 position: 50 asPoint;
			 yourself).
	space show
]

{ #category : #public }
ToSkinDemo4Button >> click [ 

	clicked := clicked not
]

{ #category : #public }
ToSkinDemo4Button >> clicked [ 

	^ clicked
]

{ #category : #initialization }
ToSkinDemo4Button >> initialize [

	super initialize.

	clicked := false.
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		self click ].

	self initializeForToplo.
]
