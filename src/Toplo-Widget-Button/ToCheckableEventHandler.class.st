Class {
	#name : #ToCheckableEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckableEventHandler >> checkableChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target group ifNotNil: [ :grp | "A task is enqueued to ensure 
		that the group notification occurs *** after *** 
		other possible CheckableChangedEvent handler actions "
		target enqueueTask: (BlTaskAction new action: [ grp notifyChanged ]) ]
]

{ #category : #'event handling' }
ToCheckableEventHandler >> clickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target switchToNextCheckState.
	anEvent consume
]

{ #category : #'api - accessing' }
ToCheckableEventHandler >> eventsToHandle [

	^ { ToCheckableChangedEvent. BlClickEvent  }
]
