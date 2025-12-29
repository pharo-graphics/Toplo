Class {
	#name : #ToCheckableEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckableEventHandler >> checkableChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target group ifNotNil: [ :grp | grp notifyChanged ]
]

{ #category : #'event handling' }
ToCheckableEventHandler >> clickEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryClickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]

]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ {
		  ToCheckableChangedEvent.
		  BlClickEvent }
]

{ #category : #'event handling' }
ToCheckableEventHandler >> primaryClickEvent: anEvent [

	| currentTarget |
	currentTarget := anEvent currentTarget.
	currentTarget switchToNextCheckStateOnClick ifFalse: [ ^ self ].
	currentTarget switchToNextCheckState
]
