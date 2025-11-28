Class {
	#name : #ToTabBarInGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> barVisibleNodeContainerListChangedEvent: anEvent [

	tabGroup
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers
]

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> checkableGroupChangedEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabBarInGroupElementEventHandler >> eventsToHandle [

	^ {
		  ToBarVisibleNodeContainerListChangedEvent.
		  ToCheckableGroupChangedEvent.
		  ToBarItemEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> itemAddedInBarEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> itemRemovedFromBarEvent: anEvent [

	| tabItemHolder |
	tabGroup dispatchEvent: anEvent copy.
	anEvent wasSelected ifFalse: [ ^ self ].
	tabItemHolder := anEvent item holder.
	tabItemHolder checkNextAfterRemovalAtPosition: tabItemHolder position.

]

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent selectedIndexes do: [ :idx |
		anEvent currentTarget selecter scrollTowardStartToDataSourcePosition: idx ]
]

{ #category : #accessing }
ToTabBarInGroupElementEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
