Class {
	#name : #ToTabListInTabGroupEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> checkableGroupChangedEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabListInTabGroupEventHandler >> eventsToHandle [

	^ {
		  ToListVisibleNodeContainersChangedEvent.
		  ToCheckableGroupChangedEvent.
		  ToListItemEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> itemAddedInListEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> itemRemovedFromListEvent: anEvent [

	| tabItemHolder dataAccessor nextChecked |
	tabGroup dispatchEvent: anEvent copy.
	anEvent wasSelected ifFalse: [ ^ self ].
	tabItemHolder := anEvent item holder.
	dataAccessor := tabGroup dataAccessor.
	dataAccessor ifEmpty: [ ^ self ].
	nextChecked := dataAccessor size < tabItemHolder position
		               ifTrue: [ dataAccessor last ]
		               ifFalse: [ dataAccessor at: tabItemHolder position ].
	tabGroup itemList postponeAction: [ nextChecked checked: true ]
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent selectedIndexes do: [ :idx |
		anEvent currentTarget selecter scrollTowardStartToDataSourcePosition: idx ]
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> listVisibleNodeContainersChangedEvent: anEvent [

	tabGroup
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers
]

{ #category : #accessing }
ToTabListInTabGroupEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
