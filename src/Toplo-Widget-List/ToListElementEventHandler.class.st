Class {
	#name : 'ToListElementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-List-Core',
	#package : 'Toplo-Widget-List',
	#tag : 'Core'
}

{ #category : 'mouse handlers' }
ToListElementEventHandler >> collectionRemoveRequest: anEvent [

	| target interval |
	self flag: 'Needed ? check the issue flagged in #example_contactList'.
	target := anEvent currentTarget.
	interval := anEvent interval.
	interval first to: interval last do: [ :idx |
	"target deselectIndex: idx" ]
]

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
		  " data events "
		  ToCollectionRemoveRequest.

		  " data source events "
		  ToDataEmptinessChangeEvent.
		  " infinite events "
		  ToInfiniteSelectionChangedEvent }
]

{ #category : 'infinite element events handling' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget dispatchEvent:
		(ToListElementSelectionChangedEvent new
			 newSelectedIndexes: anEvent newSelectedIndexes;
			 oldSelectedIndexes: anEvent oldSelectedIndexes;
			 yourself)
]

{ #category : 'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget infinite requestFocus
]
