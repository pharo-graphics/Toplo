Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'currentOpenedSubmenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'initialize-release' }
ToMenuWindow >> close [

	currentOpenedSubmenuWindow ifNotNil: [ :w | w close ].
	super close
	
]

{ #category : #accessing }
ToMenuWindow >> currentOpenedSubmenuWindow [

	^ currentOpenedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> currentOpenedSubmenuWindow: aWindow [

	currentOpenedSubmenuWindow := aWindow
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
	anElement items ifEmpty: [ ^ self ].
	
	" ok, open the sub menu window "
	self currentOpenedSubmenuWindow: anElement menuWindow.
	pos := anElement bounds inSpace bounds topRight.
	anElement menuWindow popupAtGlobalPosition: pos
]
