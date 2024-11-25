Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #accessing }
ToContextMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #'friend only' }
ToContextMenu >> closeRequestFrom: anItem [

	self closeWindow
]

{ #category : #'as yet unclassified' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #initialization }
ToContextMenu >> initialize [ 

	super initialize.
	self fitContent.
	self root addChild: self itemList
]

{ #category : #testing }
ToContextMenu >> isMenu [

	^ true
]

{ #category : #'as yet unclassified' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : #'as yet unclassified' }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #'as yet unclassified' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #'as yet unclassified' }
ToContextMenu >> itemContainer [

	^ self 
]

{ #category : #'as yet unclassified' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : #'as yet unclassified' }
ToContextMenu >> popupEvent: anEvent [

	^ super popupEvent: anEvent
]

{ #category : #'as yet unclassified' }
ToContextMenu >> rootMenu [

	^ self 
]
