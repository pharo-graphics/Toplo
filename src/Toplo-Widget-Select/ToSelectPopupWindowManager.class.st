Class {
	#name : #ToSelectPopupWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultAutoCloseDelay [

	^ nil
]

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

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #'event handling' }
ToSelectPopupWindowManager >> elementExtentChangedEvent: anEvent [

	super elementExtentChangedEvent: anEvent.
	currentWindow ifNil: [ ^ self ].
	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
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

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onInstalledIn: anElement [

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
		selectWin root addChild: self listElement.
		self listElement secondarySelectionModel ifEmpty: [
			self listElement secondarySelecter selectIndex: 1 ] ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element onPopupWindowClosed
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onPopupWindowOpened
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

{ #category : #accessing }
ToSelectPopupWindowManager >> windowClass [

	^ ToSelectPopupWindow 
]
