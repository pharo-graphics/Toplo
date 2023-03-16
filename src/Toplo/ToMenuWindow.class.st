Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'openedSubmenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - displaying' }
ToMenuWindow >> close [

	openedSubmenuWindow ifNotNil: [ :w | w close ].
	super close
	
]

{ #category : #initialization }
ToMenuWindow >> defaultBorder [

	^ BlBorder paint: Color lightGray width: 1
]

{ #category : #'t - initialization dresser' }
ToMenuWindow >> defaultDresser [ 

	^ ToMenuWindowDresser new
]

{ #category : #initialization }
ToMenuWindow >> initialize [

	super initialize.
	self initializeDresser 
	
]

{ #category : #'api - displaying' }
ToMenuWindow >> mouseEnterOnMenuItem: aMenuItem [

	" test if a submenu is opened "
	self openedSubmenuWindow ifNil: [ ^ self ].

	" test if the submenu is not the menuItem one "
	self openedSubmenuWindow == aMenuItem subMenuWindow 
		ifTrue: [ ^ self ].

	" ok, I can close other item submenu window"
	self openedSubmenuWindow close.
	self openedSubmenuWindow: nil
]

{ #category : #initialization }
ToMenuWindow >> openPositionFromEvent: anEvent [

	^ self widget isSubmenu
		  ifTrue: [ widget bounds inSpace bounds topRight ]
		  ifFalse: [ widget bounds inSpace bounds bottomLeft ]
]

{ #category : #'api - displaying' }
ToMenuWindow >> openSubmenuWindowFor: anElement event: anEvent [

	" the sub menu window must not be already opened "
	anElement subMenuWindow isAttachedToSceneGraph ifTrue: [ ^ self ].
	
	" do not open if empty "
	anElement hasItems ifFalse: [ ^ self ].
	
	" ok, open the sub menu window "
	self openedSubmenuWindow: anElement subMenuWindow.
	anElement subMenuWindow popupEvent: anEvent
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow := aWindow
]
