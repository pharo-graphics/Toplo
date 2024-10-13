Class {
	#name : #ToTagBarEventHandler,
	#superclass : #ToBarElementEventHandler,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node bar event handling' }
ToTagBarEventHandler >> barNodeVisibilityEvent: anEvent [

	anEvent invisibleNodes ifNotEmpty: [ :in |
		anEvent currentTarget haveInvisibleNodes: in ]
]

{ #category : #'selection managing' }
ToTagBarEventHandler >> elementExtentChangedEvent: anEvent [

	| target |
	super elementExtentChangedEvent: anEvent.
	target := anEvent currentTarget.
	(target dataSource anySatisfy: [ :tagModel | tagModel isComposite ])
		ifFalse: [ ^ self ].
	target extentChanged
]

{ #category : #'api - accessing' }
ToTagBarEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementExtentChangedEvent.
		  ToBarNodeVisibilityEvent }
]
