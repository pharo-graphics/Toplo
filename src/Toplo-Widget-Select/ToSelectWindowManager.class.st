Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'maxHeight'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelectWindowManager >> data [

	^ self listElement data
]

{ #category : #initialization }
ToSelectWindowManager >> defaultMaxHeight [

	^ 200
]

{ #category : #initialization }
ToSelectWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft + (4 @ 4) ]
]

{ #category : #initialization }
ToSelectWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth - 8 ]
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #initialization }
ToSelectWindowManager >> initialize [

	super initialize.
	maxHeight := self defaultMaxHeight.
	listElement := ToListElement new
		               vFitContent;
		               hMatchParent.
	listElement requestFocusOnMouseDown: false.
	listElement infinite maxHeight: self maxHeight.
	listElement infinite vFitContent.

	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement ]
]

{ #category : #accessing }
ToSelectWindowManager >> listElement [

	^ listElement 
]

{ #category : #accessing }
ToSelectWindowManager >> maxHeight [

	^ maxHeight
]

{ #category : #accessing }
ToSelectWindowManager >> maxHeight: anInteger [

	maxHeight := anInteger
]

{ #category : #'window handling' }
ToSelectWindowManager >> onCloseRequest [

	super onCloseRequest.
	" if case one of my children has focus "
	self element onListCloseRequest.


]
