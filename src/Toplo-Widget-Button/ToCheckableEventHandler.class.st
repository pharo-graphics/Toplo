Class {
	#name : #ToCheckableEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckableEventHandler >> checkableChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target group ifNotNil: [ :grp | grp checkableChangedEvent: anEvent ]
]

{ #category : #'event handling' }
ToCheckableEventHandler >> clickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target switchToNextCheckState 
]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ { ToCheckableChangedEvent. BlClickEvent  }
]
