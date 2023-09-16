Class {
	#name : #ToTripletDresser,
	#superclass : #ToDresser,
	#instVars : [
		'propertyChangedEventHandler',
		'interspace'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'event handling' }
ToTripletDresser >> checkJustificationin: anElement [

	(anElement isJustified and: [anElement isHorizontal]) ifFalse: [
		interspace := nil.
		^ self ].
	interspace ifNil: [ interspace := self newInterspace ].
	anElement innerElement hMatchParent
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
ToTripletDresser >> newInterspace [

	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'event handling' }
ToTripletDresser >> propertyChangedEvent: anEvent in: anElement [

	| children |
	anElement ifNil: [ ^ self ].
	self checkJustificationin: anElement.
	anElement innerElement removeChildren.
	children := { anElement first. interspace. anElement second. anElement third } select: #notNil.
	children do: [ :child | 
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter.
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	anElement innerElement addChildren: children
]

{ #category : #'api - install/uninstall  hook' }
ToTripletDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: propertyChangedEventHandler.
	propertyChangedEventHandler := nil.
	super uninstallEventListenersIn: anElement

]
