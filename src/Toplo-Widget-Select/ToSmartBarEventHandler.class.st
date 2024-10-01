Class {
	#name : #ToSmartBarEventHandler,
	#superclass : #ToBarElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node bar event handling' }
ToSmartBarEventHandler >> barNodeVisibilityEvent: anEvent [

	anEvent invisibleNodes ifNotEmpty: [ :in |
		anEvent currentTarget haveFullyInvisibleNodes: in ]
]

{ #category : #'selection managing' }
ToSmartBarEventHandler >> elementExtentChangedEvent: anEvent [

	| target |
	super elementExtentChangedEvent: anEvent.
	target := anEvent currentTarget.
	(target dataSource anySatisfy: [ :item | item isComposite ])
		ifFalse: [ ^ self ].
	target refresh
]

{ #category : #'api - accessing' }
ToSmartBarEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementExtentChangedEvent.
		  ToBarNodeVisibilityEvent }
]
