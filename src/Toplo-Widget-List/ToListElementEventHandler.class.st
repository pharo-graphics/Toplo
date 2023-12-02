Class {
	#name : 'ToListElementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-List-Core',
	#package : 'Toplo-Widget-List',
	#tag : 'Core'
}

{ #category : 'data source events handling' }
ToListElementEventHandler >> dataEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
]

{ #category : 'infinite element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
]

{ #category : 'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlMouseDownEvent.
		  " data source events "
		  ToDataEmptinessChangeEvent.
		  " infinite events "
		  ToInfiniteSelectionChangedEvent }
]

{ #category : 'infinite element events handling' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget dispatchEvent: ToListElementSelectionChangedEvent new
]

{ #category : 'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget infinite requestFocus
]
