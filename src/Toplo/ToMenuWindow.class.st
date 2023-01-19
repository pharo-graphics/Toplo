Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'openedSubmenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'initialize-release' }
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
ToMenuWindow >> openSubmenuWindowFor: anElement [

	" the sub menu window must not be already opened "
	| pos |
	anElement menuWindow isAttachedToSceneGraph ifTrue: [ ^ self ].
	
	" do not open if empty "
	anElement hasItems ifFalse: [ ^ self ].
	
	" ok, open the sub menu window "
	self openedSubmenuWindow: anElement menuWindow.
	pos := anElement bounds inSpace bounds topRight.
	anElement menuWindow popupAtGlobalPosition: pos
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow := aWindow
]
