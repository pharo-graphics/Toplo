"
I'm a data item that behaves as a button. 
"
Class {
	#name : #ToGeneralButtonMenuItem,
	#superclass : #ToMenuItemElement,
	#traits : 'TToButtonHolder',
	#classTraits : 'TToButtonHolder classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToGeneralButtonMenuItem >> button [

	^ button
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> button: aButton [

	self button = aButton ifTrue: [ ^ self ].
	button ifNotNil: [ button removeFromParent ].
	button := aButton.
	button ifNotNil: [
		self addChild: button at: 1.
		aButton constraintsDo: [ :c | c linear vertical alignCenter ].
		aButton hMatchParent ]
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> initialize [

	super initialize.
	self initializeButtonHolder 
]
