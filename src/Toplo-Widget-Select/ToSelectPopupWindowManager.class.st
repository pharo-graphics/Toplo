Class {
	#name : #ToSelectPopupWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'maxHeightPolicy'
	],
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMeasurement [

	^ ToAnchoredSameWidthMeasurement new
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMinHeight [

	^ 80
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultPlacement [

	^ ToActionPlacement new
		  action: [ :theWin :evt :aBoundsUpdater |
			  | theElem theRoot |
			  theElem := theWin anchorElement.
			  theRoot := theWin anchorRoot.
			  theWin position:
					  (theElem bounds inParent: theRoot) bounds bottomLeft ];
		  yourself
]

{ #category : #accessing }
ToSelectPopupWindowManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupWindowManager >> listElementClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeight: aNumber [

	self maxHeightPolicy: (ToSelectPopupExactMaxHeightPolicy new
	maxHeight: aNumber;
	yourself)
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeightPolicy [

	^ maxHeightPolicy 
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeightPolicy: aPopupMaxHeightPolicy [

	maxHeightPolicy := aPopupMaxHeightPolicy.
	self anchorElement requestLayout
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
	newListElement innerElementDo: [ :inner |
		inner maxHeight: self defaultMaxHeight.
		inner minHeight: self defaultMinHeight.
		inner constraintsDo: [ :c | c vertical fitContent ] ].
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self anchorElement.
	listElement focusability: BlFocusability none.

	self maxHeight:  self defaultMaxHeight.
	self windowBuilder: [ :selectWin :request |
		selectWin root addChild: self listElement ].

	sieve := listElement dataAccessor newSieve
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowClosedOnEvent: anEvent [

	super onWindowClosedOnEvent: anEvent.
	" if case one of my children has focus "
	self anchorElement onPopupWindowClosed
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	self anchorElement onPopupWindowOpened
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> requestCloseWindowOnEvent: anEvent [
	" don't autoclose if mouse up on a filter textfield "

	| target |
	target := anEvent target.
	(target withAllParentsInclude: anchorElement filterTextField)
		ifTrue: [ ^ self ].
	super requestCloseWindowOnEvent: anEvent
]

{ #category : #accessing }
ToSelectPopupWindowManager >> sieve [ 

	^ sieve
]

{ #category : #initialization }
ToSelectPopupWindowManager >> windowClass [

	^ ToSelectPopupWindow
]

{ #category : #accessing }
ToSelectPopupWindowManager >> withMatchParentMaxHeight [

	self maxHeightPolicy: ToSelectPopupMatchParentMaxHeightPolicy new
]
