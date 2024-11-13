Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items'
	],
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'t - menu item container - adding/removing' }
ToContextMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self root addChild: aMenuItem.
	aMenuItem  addedInMenu: self
]

{ #category : #'t - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #'t - menu window model' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : #'t - menu window model' }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #accessing }
ToContextMenu >> itemHolder [

	^ self 
]

{ #category : #'t - menu item container - accessing' }
ToContextMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : #'t - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	^ super popupEvent: anEvent
]

{ #category : #'t - menu item container - adding/removing' }
ToContextMenu >> removeItem: aMenuItem [

	self items remove: aMenuItem.
	self root removeChild: aMenuItem.
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
