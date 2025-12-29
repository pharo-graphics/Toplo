Class {
	#name : #ToTabListGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'events handling' }
ToTabListGroupElementEventHandler >> checkableGroupChangedEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabListGroupElementEventHandler >> eventsToHandle [

	^ {
		  ToFiniteListVisibleNodeContainerListChangedEvent.
		  ToCheckableGroupChangedEvent.
		  ToFiniteListItemEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabListGroupElementEventHandler >> finiteListVisibleNodeContainerListChangedEvent: anEvent [

	tabGroup
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers
]

{ #category : #'events handling' }
ToTabListGroupElementEventHandler >> itemAddedInBarEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabListGroupElementEventHandler >> itemRemovedFromBarEvent: anEvent [

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
ToTabListGroupElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent selectedIndexes do: [ :idx |
		anEvent currentTarget selecter scrollTowardStartToDataSourcePosition: idx ]
]

{ #category : #accessing }
ToTabListGroupElementEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
