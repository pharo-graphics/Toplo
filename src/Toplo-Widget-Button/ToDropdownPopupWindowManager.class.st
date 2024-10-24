Class {
	#name : #ToDropdownPopupWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-Button-Dropdown'
}

{ #category : #initialization }
ToDropdownPopupWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

{ #category : #'api - hooks' }
ToDropdownPopupWindowManager >> defaultListElementEventHandler [ 

	^ ToSelectListElementEventHandler new
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> defaultMinHeight [

	^ 0
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> listElementClass [

	^ ToSelectListElement
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToDropdownPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := self listElementClass new.
	newListElement primarySelectionMode multiple: false.
	newListElement innerContainer maxHeight: self defaultMaxHeight.
	newListElement innerContainer minHeight: self defaultMinHeight.
	newListElement innerContainer vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hooks' }
ToDropdownPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self element.
	listElement focusability: BlFocusability none.

	listElement addEventHandler: (self defaultListElementEventHandler
			 select: self element;
			 yourself).

	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement ]
]

{ #category : #'api - hooks' }
ToDropdownPopupWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToDropdownPopupWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element onPopupWindowClosed
]

{ #category : #'window handling' }
ToDropdownPopupWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onPopupWindowOpened
]

{ #category : #'window handling' }
ToDropdownPopupWindowManager >> popupWindowHiddenEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	" currentWindow can be nil in case the element is disabled "
	currentWindow visibility: BlVisibility hidden.
	currentWindow popupEvent: anEvent
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToDropdownPopupWindowManager >> windowClass [

	^ ToSelectPopupWindow 
]
