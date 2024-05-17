Class {
	#name : #ToListElementEventHandler,
	#superclass : #ToBasicListElementEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  ToListHiddenSelectionChangedEvent.
		  ToListUnselectableSelectionChangedEvent.
		  ToListDisabledSelectionChangedEvent.
		  ToListClickOnNodePreNotificationEvent }
]

{ #category : #'element events handling' }
ToListElementEventHandler >> listClickOnNodePreNotificationEvent: anEvent [

	| listElement node |
	listElement := anEvent currentTarget.
	node := anEvent sourceEvent sourceEvent currentTarget.
	node holder isSelectable ifFalse: [ anEvent sourceEvent: nil ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].

	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listHiddenSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].

	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	listElement nodeContainer hasChildren ifFalse: [ ^ self ].
	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].

	listElement selectionModel unselectableSelectionModelDo: [ :sm |
		| firstPos lastPos |
		firstPos := listElement nodeContainer firstChild holder position.
		lastPos := listElement nodeContainer lastChild holder position.
		firstPos to: lastPos do: [ :idx |
			((listElement selectionModel containsIndex: idx) and: [
				 sm containsIndex: idx ]) ifTrue: [
				listElement selecter deselectIndex: idx ] ] ].

	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]
