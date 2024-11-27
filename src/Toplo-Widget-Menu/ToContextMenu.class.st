Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'itemList'
	],
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

{ #category : #'t - menu window model' }
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

{ #category : #'t - menu window model' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : #testing }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #accessing }
ToContextMenu >> itemContainer [

	^ self 
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : #'t - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	^ super popupEvent: anEvent
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
