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

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ { ToPreCheckableChangedEvent. ToCheckableChangedEvent }
]

{ #category : #'event handling' }
ToCheckableEventHandler >> preCheckableChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target group ifNotNil: [ :grp | grp checkChangePreNotification: anEvent ].
	anEvent accepted ifTrue: [ target privateChecked: anEvent checked ]
]
