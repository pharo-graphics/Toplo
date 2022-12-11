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
