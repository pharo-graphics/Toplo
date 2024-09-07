Class {
	#name : #ToMultiSelectBarEventHandler,
	#superclass : #ToBarElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node bar event handling' }
ToMultiSelectBarEventHandler >> barNodeVisibilityEvent: anEvent [

	anEvent invisibleNodes ifNotEmpty: [ :in |
		anEvent currentTarget haveFullyInvisibleNodes: in ]
]

{ #category : #'element handlers' }
ToMultiSelectBarEventHandler >> elementExtentChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	(target dataSource anySatisfy: [ :item | item isComposite ])
		ifFalse: [ ^ self ].
	target refresh
]

{ #category : #'api - accessing' }
ToMultiSelectBarEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementExtentChangedEvent.
		  ToBarNodeVisibilityEvent }
]
