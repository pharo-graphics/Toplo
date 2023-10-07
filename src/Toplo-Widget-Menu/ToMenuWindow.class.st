Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
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
ToMenuWindow >> items [

	^ self associateElement ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - orientable - accessing' }
ToMenuWindow >> layoutStrategy [

	^ self rootLayout

	
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
	super popupEvent: anEvent
]
