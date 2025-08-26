Class {
	#name : #ToTabBarInGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> barVisibleNodeListChangedEvent: anEvent [

	tabGroup
		onInvisibleNodes: anEvent invisibleNodes
		visibleNodes: anEvent visibleNodes
]

{ #category : #'events handling' }
ToTabBarInGroupElementEventHandler >> checkableGroupChangedEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabBarInGroupElementEventHandler >> eventsToHandle [

	^ {
		  ToBarVisibleNodeListChangedEvent.
		  ToCheckableGroupChangedEvent.
		  ToBarItemEvent }
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

{ #category : #accessing }
ToTabBarInGroupElementEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
