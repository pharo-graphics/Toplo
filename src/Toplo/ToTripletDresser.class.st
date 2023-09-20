Class {
	#name : 'ToTripletDresser',
	#superclass : 'ToDresser',
	#instVars : [
		'propertyChangedEventHandler',
		'filler'
	],
	#category : 'Toplo-Core-Triplet',
	#package : 'Toplo',
	#tag : 'Core-Triplet'
}

{ #category : 'event handling' }
ToTripletDresser >> checkJustificationin: anElement [

	anElement justified ifFalse: [
		filler := nil.
		^ self ].
	filler ifNil: [ filler := self newFiller ]
]

{ #category : 'api - install/uninstall  hook' }
ToTripletDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	propertyChangedEventHandler := BlEventHandler 
		on: ToPropertyChangedEvent 
		do: [ :event | self propertyChangedEvent: event in: anElement ].
	anElement addEventHandler: propertyChangedEventHandler

]

{ #category : 'event handling' }
ToTripletDresser >> newFiller [

	^ ToElement new
		  matchParent;
		  styleTag: #'triplet-filler';
		  yourself
]

{ #category : 'event handling' }
ToTripletDresser >> propertyChangedEvent: anEvent in: anElement [

	| children |
	anElement ifNil: [ ^ self ].
	self checkJustificationin: anElement.
	anElement innerElement removeChildren.
	children := { anElement first. filler. anElement second. anElement third } select: #notNil.
	anElement innerElement addChildren: children
]

{ #category : 'api - install/uninstall  hook' }
ToTripletDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: propertyChangedEventHandler.
	propertyChangedEventHandler := nil.
	super uninstallEventListenersIn: anElement

]
