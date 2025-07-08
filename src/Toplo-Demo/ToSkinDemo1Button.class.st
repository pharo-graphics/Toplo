Class {
	#name : #ToSkinDemo1Button,
	#superclass : #BlElement,
	#instVars : [
		'clicked'
	],
	#category : #'Toplo-Demo-Skin Demo - 1'
}

{ #category : #'as yet unclassified' }
ToSkinDemo1Button class >> exampleSimpleElementAsButton [

	self new position: 50 asPoint; openInSpace 
]

{ #category : #'as yet unclassified' }
ToSkinDemo1Button class >> exampleToElementWithSkinApplied [

	| button |
	button := ToElement new position: 50 asPoint.
button defaultRawSkin: ToSkinDemo1ButtonSkin new.
button openInSpace
]

{ #category : #public }
ToSkinDemo1Button >> click [ 

	clicked := clicked not.
	self background: (clicked ifTrue: [ Color lightGreen ] ifFalse: [ Color lightRed ])
]

{ #category : #initialization }
ToSkinDemo1Button >> initialize [

	super initialize.
	self extent: 100 @ 50.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self background: Color lightRed.
	self margin: (BlInsets all: 2).
	clicked := false.
	self addEventHandlerOn: BlClickEvent do: [ :e | self click ]
]
