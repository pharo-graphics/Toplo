Class {
	#name : #ToSelectPopupWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> defaultListElementEventHandler [ 

	^ ToSelectListElementEventHandler new
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMinHeight [

	^ 0
]

{ #category : #initializing }
ToSelectPopupWindowManager >> defaultPlacement [

	^ ToActionPlacement new
		  action: [ :theWin  :evt | | theElem theRoot |
			  theElem := theWin  element.
			  theRoot := theWin  anchorRoot.
			  theWin width: theElem measuredWidth.
			  theWin position:
					  (theElem bounds inParent: theRoot) bounds bottomLeft ];
		  yourself
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultWidthHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredWidth ]
]

{ #category : #accessing }
ToSelectPopupWindowManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupWindowManager >> listElementClass [

	^ ToSelectListElement
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToSelectPopupWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToSelectPopupWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToSelectPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := self listElementClass new.
	newListElement primarySelectionMode multiple: false.
	newListElement innerElement maxHeight: self defaultMaxHeight.
	newListElement innerElement minHeight: self defaultMinHeight.
	newListElement innerElement vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onClosed [

	super onClosed.
	" if case one of my children has focus "
	self element onPopupWindowClosed
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self element.
	listElement focusability: BlFocusability none.

	listElement addEventHandler: (self defaultListElementEventHandler
			 select: self element;
			 yourself).

	self windowBuilder: [ :selectWin :request |
		selectWin root addChild: self listElement ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onOpened [

	super onOpened.
	self element onPopupWindowOpened
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #accessing }
ToSelectPopupWindowManager >> popupWindowClass [

	^ ToSelectPopupWindow 
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> popupWindowHiddenEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	" currentWindow can be nil in case the element is disabled "
	currentWindow visibility: BlVisibility hidden.
	currentWindow popupEvent: anEvent
]

{ #category : #accessing }
ToSelectPopupWindowManager >> sieve [ 

	^ sieve
]
