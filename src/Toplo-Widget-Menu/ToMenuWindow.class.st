Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'openedSubmenuWindow'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - displaying' }
ToMenuWindow >> close [ 

	openedSubmenuWindow ifNotNil: [ :w | w close ].
	super close
]

{ #category : #initialization }
ToMenuWindow >> defaulPositionHook [ 

	^ [ :w :event | w associateElement isSubmenu
		  ifTrue: [ w associateElement bounds inSpace bounds topRight ]
		  ifFalse: [ w associateElement bounds inSpace bounds bottomLeft ] ]
]

{ #category : #initialization }
ToMenuWindow >> defaultAssociateElementEventHandlerClass [

	^ ToMenuEventHandler 
]

{ #category : #initialization }
ToMenuWindow >> defaultBackground [

	^ Color white
]

{ #category : #initialization }
ToMenuWindow >> defaultBorder [

	^ BlBorder paint: Color lightGray width: 1
]

{ #category : #accessing }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #accessing }
ToMenuWindow >> itemHolder [

	^ self associateElement
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self associateElement ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow ifNotNil: [ openedSubmenuWindow close ].
	openedSubmenuWindow := aWindow.
]

{ #category : #'api - displaying' }
ToMenuWindow >> popupEvent: anEvent [

	self items ifEmpty: [ ^ self ].
	self items do: [ :it |
		self root addChild: it.
		it addedInMenu: self itemHolder  ].
	super popupEvent: anEvent
]
