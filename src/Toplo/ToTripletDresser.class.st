Class {
	#name : #ToTripletDresser,
	#superclass : #ToDresser,
	#instVars : [
		'propertyChangedEventHandler',
		'filler'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'event handling' }
ToTripletDresser >> checkJustificationin: anElement [

	filler ifNil: [ filler := self newFiller ].
	"anElement justified
		ifTrue: [ filler matchParent ]
		ifFalse: [ filler size: 0 @ 0 ]"
]

{ #category : #'api - install/uninstall  hook' }
ToTripletDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	propertyChangedEventHandler := BlEventHandler 
		on: ToPropertyChangedEvent 
		do: [ :event | self propertyChangedEvent: event in: anElement ].
	anElement addEventHandler: propertyChangedEventHandler

]

{ #category : #'event handling' }
ToTripletDresser >> newFiller [

	^ ToElement new
		  styleTag: #'triplet-filler-1';
		  size: 0 @ 0;
		  yourself
]

{ #category : #'event handling' }
ToTripletDresser >> propertyChangedEvent: anEvent in: anElement [

	| children |
	anElement ifNil: [ ^ self ].
	self checkJustificationin: anElement.
	anElement innerElement removeChildren.
	children := { anElement first. filler. anElement second. anElement third } select: #notNil.
	anElement innerElement addChildren: children
]

{ #category : #'api - install/uninstall  hook' }
ToTripletDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: propertyChangedEventHandler.
	propertyChangedEventHandler := nil.
	super uninstallEventListenersIn: anElement

]
