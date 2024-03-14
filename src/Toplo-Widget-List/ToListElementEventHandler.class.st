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

	| target nodesArray |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [ ^ self ].

	nodesArray := target infinite children asArray.
	anEvent selectionModel ifEmpty: [
		target dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		target dataSource notifyItemsChanged: (interval first to: interval last) ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listHiddenSelectionChangedEvent: anEvent [

	| listElement nodesArray |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	nodesArray := listElement infinite children asArray.
	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| target firstPos lastPos |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [ ^ self ].
	target infinite hasChildren ifFalse: [ ^ self ].
	anEvent selectionModel ifEmpty: [
		target dataSource notifyChanged.
		^ self ].
	firstPos := target infinite firstChild holder position.
	lastPos := target infinite lastChild holder position.
	(target selectionModel hasUnselectableInInterval:
		 (firstPos to: lastPos)) ifFalse: [ ^ self ].
	firstPos to: lastPos do: [ :idx |
		((target selectionModel containsIndex: idx) and: [
			 target unselectableSelectionModel containsIndex: idx ]) ifTrue: [
			target selecter deselectIndex: idx ] ].
	target dataSource notifyItemsChanged: (firstPos to: lastPos).
	target requestLayout
]
