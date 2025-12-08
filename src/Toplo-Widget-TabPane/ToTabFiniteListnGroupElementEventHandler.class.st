Class {
	#name : #ToTabFiniteListnGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'events handling' }
ToTabFiniteListnGroupElementEventHandler >> checkableGroupChangedEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabFiniteListnGroupElementEventHandler >> eventsToHandle [

	^ {
		  ToFiniteListVisibleNodeContainerListChangedEvent.
		  ToCheckableGroupChangedEvent.
		  ToFiniteListItemEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabFiniteListnGroupElementEventHandler >> finiteListVisibleNodeContainerListChangedEvent: anEvent [

	tabGroup
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers
]

{ #category : #'events handling' }
ToTabFiniteListnGroupElementEventHandler >> itemAddedInBarEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabFiniteListnGroupElementEventHandler >> itemRemovedFromBarEvent: anEvent [

	| tabItemHolder |
	tabGroup dispatchEvent: anEvent copy.
	anEvent wasSelected ifFalse: [ ^ self ].
	tabItemHolder := anEvent item holder.
	tabItemHolder checkNextAfterRemovalAtPosition: tabItemHolder position.

]

{ #category : #'events handling' }
ToTabFiniteListnGroupElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent selectedIndexes do: [ :idx |
		anEvent currentTarget selecter scrollTowardStartToDataSourcePosition: idx ]
]

{ #category : #accessing }
ToTabFiniteListnGroupElementEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
