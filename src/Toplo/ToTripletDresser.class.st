Class {
	#name : #ToTripletDresser,
	#superclass : #ToDresser,
	#instVars : [
		'propertyChangedEventHandler',
		'filler'
	],
	#category : #'Toplo-Core-Triplet'
}

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

{ #category : #'api - install/uninstall  hook' }
ToTripletDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	filler := self newFiller
]

{ #category : #'event handling' }
ToTripletDresser >> propertyChangedEvent: anEvent in: anElement [

	| children |
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
