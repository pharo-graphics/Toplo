Class {
	#name : #ToTripletDresser,
	#superclass : #ToDresser,
	#instVars : [
		'propertyChangedEventHandler',
		'interspace',
		'layoutConstraintsChangedEventHandler'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'event handling' }
ToTripletDresser >> checkJustificationin: anElement [

	anElement isJustified ifFalse: [ ^ self ].
	(anElement first isNil or: [ anElement second isNil ]) ifTrue: [ 
		interspace ifNil: [ ^ self ].
		interspace removeFromParent.
		interspace := nil.
		^ self ].
	interspace ifNil: [ interspace := self newInterspace ]

]

{ #category : #'api - install/uninstall  hook' }
ToTripletDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	propertyChangedEventHandler := BlEventHandler 
		on: ToPropertyChangedEvent 
		do: [ :event | self propertyChangedEvent: event in: anElement ].
	layoutConstraintsChangedEventHandler := BlEventHandler 
		on: ToLayoutConstraintsChangedEvent  
		do: [ :event | self layoutConstraintsChangedEvent: event in: anElement ].
	anElement addEventHandler: propertyChangedEventHandler.
	anElement addEventHandler: layoutConstraintsChangedEventHandler.


]

{ #category : #'event handling' }
ToTripletDresser >> layoutConstraintsChangedEvent: anEvent in: anElement [

	anElement innerElement ifNotNil: [ :in |
		in constraints horizontal resizer: anElement constraints horizontal resizer.
		in constraints vertical resizer: anElement constraints vertical resizer].
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
	anElement removeEventHandler: layoutConstraintsChangedEventHandler.
	propertyChangedEventHandler := nil.
	layoutConstraintsChangedEventHandler := nil.
	super uninstallEventListenersIn: anElement

]
