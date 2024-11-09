Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items'
	],
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'t - menu item holder - adding/removing' }
ToContextMenu >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item holder - adding/removing' }
ToContextMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self root addChild: aMenuItem.
	aMenuItem  addedInMenu: self
]

{ #category : #'t - menu item holder - adding/removing' }
ToContextMenu >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'api - displaying' }
ToContextMenu >> close [ 

	self items do: [ :it | it closeWindow ].
	super close
]

{ #category : #'t - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #'t - menu item holder - testing' }
ToContextMenu >> hasItems [ 

	^ self items notEmpty
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

{ #category : #'t - menu item holder - accessing' }
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

{ #category : #'t - menu item holder - adding/removing' }
ToContextMenu >> removeItem: aMenuItem [

	self items remove: aMenuItem.
	self root removeChild: aMenuItem.
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
