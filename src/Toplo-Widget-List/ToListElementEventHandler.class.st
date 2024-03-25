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

	| listElement firstPos lastPos |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	listElement infinite hasChildren ifFalse: [ ^ self ].
	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	firstPos := listElement infinite firstChild holder position.
	lastPos := listElement infinite lastChild holder position.
	firstPos to: lastPos do: [ :idx |
		((listElement selectionModel containsIndex: idx) and: [
			 listElement unselectableSelectionModel containsIndex: idx ]) ifTrue: [
			listElement selecter deselectIndex: idx ] ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]
