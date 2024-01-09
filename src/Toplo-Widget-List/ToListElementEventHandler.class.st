Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'mouse handlers' }
ToListElementEventHandler >> collectionRemoveRequest: anEvent [

	| target interval |
	self flag: 'Needed ? check the issue flagged in #example_contactList'.
	target := anEvent currentTarget.
	interval := anEvent interval.
	interval first to: interval last do: [ :idx |
	"target deselectIndex: idx" ]
]

{ #category : #'data source events handling' }
ToListElementEventHandler >> dataEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'api - accessing' }
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

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dispatchEvent: (ToListSelectionChangedEvent new
			 currentIndexes: anEvent currentIndexes;
			 previousIndexes: anEvent previousIndexes;
			 yourself)
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestFocusOnMouseDown ifFalse: [ ^ self ].
	target requestFocus
]

{ #category : #'data source events handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement data ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
