Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu window model' }
ToContextMenu >> close [ 

	self items do: [ :it | it close ].
	super close
]

{ #category : #initialization }
ToContextMenu >> defaulPositionHook [

	^ [ :w :event | event position ]
]

{ #category : #initialization }
ToContextMenu >> defaultAssociateElementEventHandlerClass [

	^ ToContextMenuEventHandler 
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

	^ self
]

{ #category : #'t - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	super popupEvent: anEvent
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
