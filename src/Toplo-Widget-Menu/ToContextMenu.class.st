Class {
	#name : 'ToContextMenu',
	#superclass : 'ToMenuWindow',
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'api - displaying' }
ToContextMenu >> close [ 

	self items do: [ :it | it closeWindow ].
	super close
]

{ #category : 't - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : 'accessing' }
ToContextMenu >> closedEventClass [

	^ ToContextMenuClosedEvent 
]

{ #category : 'initialization' }
ToContextMenu >> defaulPositionHook [

	^ [ :w :event | event position ]
]

{ #category : 't - menu window model' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : 't - menu window model' }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : 't - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : 'accessing' }
ToContextMenu >> itemHolder [

	^ self 
]

{ #category : 't - menu item holder - accessing' }
ToContextMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : 't - menu window model' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : 'accessing' }
ToContextMenu >> openedEventClass [

	^ ToContextMenuOpenedEvent 
]

{ #category : 't - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	super popupEvent: anEvent
]

{ #category : 't - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
