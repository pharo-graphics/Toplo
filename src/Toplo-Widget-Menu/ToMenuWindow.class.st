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
ToMenuWindow >> defaulPositioningHook [ 

	^ [ :w :event | w widget isSubmenu
		  ifTrue: [ w widget bounds inSpace bounds topRight ]
		  ifFalse: [ w widget bounds inSpace bounds bottomLeft ] ]
]

{ #category : #initialization }
ToMenuWindow >> defaultBackground [

	^ Color white
]

{ #category : #initialization }
ToMenuWindow >> defaultBorder [

	^ BlBorder paint: Color lightGray width: 1
]

{ #category : #initialization }
ToMenuWindow >> defaultEventHandler [ 
	
	^ ToMenuWindowEventHandler new
]

{ #category : #accessing }
ToMenuWindow >> items [

	self widget ifNil: [ ^ #() ].
	^ self widget items
]

{ #category : #'api - displaying' }
ToMenuWindow >> mouseEnterOnMenuItem: aMenuItem [

	" test if a submenu is opened "
	self openedSubmenuWindow ifNil: [ ^ self ].

	" test if the submenu is not the menuItem one "
	self openedSubmenuWindow == aMenuItem menuWindow 
		ifTrue: [ ^ self ].

	" ok, I can close other item submenu window"
	self openedSubmenuWindow close.
	self openedSubmenuWindow: nil
]

{ #category : #'api - displaying' }
ToMenuWindow >> openSubmenuWindowFor: anElement event: anEvent [

	" the sub menu window must not be already opened "
	anElement menuWindow isAttachedToSceneGraph ifTrue: [ ^ self ].
	
	" do not open if empty "
	anElement hasItems ifFalse: [ ^ self ].
	
	" close currently opened submenu window (issue #50) "
	self openedSubmenuWindow ifNotNil: [ :w | w close ].
	
	" ok, open the sub menu window "
	self openedSubmenuWindow: anElement menuWindow.
	anElement menuWindow popupEvent: anEvent
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

	self widget ifNil: [ ^ self ].
	self items ifEmpty: [ ^ self ].
	^ super popupEvent: anEvent
]
