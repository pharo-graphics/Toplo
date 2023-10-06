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

	^ ToMenuItemEventHandler 
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

{ #category : #initialization }
ToMenuWindow >> defaultEventHandlerClass [
	
	ToMenuWindowEventHandlerDep.
	^ super defaultEventHandlerClass
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self associateElement ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - orientable - accessing' }
ToMenuWindow >> layoutStrategy [

	^ self rootLayout

	
]

{ #category : #'api - displaying' }
ToMenuWindow >> openSubmenuWindowFor: anElement event: anEvent [

	" the sub menu window must not be already opened "
	anElement window isAttachedToSceneGraph ifTrue: [ ^ self ].
	
	" do not open if empty "
	anElement hasItems ifFalse: [ ^ self ].
	
	" close currently opened submenu window (issue #50) "
	self openedSubmenuWindow ifNotNil: [ :w | w close ].
	
	" ok, open the sub menu window "
	self openedSubmenuWindow: anElement window.
	anElement window popupEvent: anEvent
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow := aWindow
]

{ #category : #'api - displaying' }
ToMenuWindow >> popupEvent: anEvent [

	self items ifEmpty: [ ^ self ].
	super popupEvent: anEvent
]
