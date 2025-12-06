Class {
	#name : #ToSelectPopupManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'maxHeightPolicy'
	],
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #initialization }
ToSelectPopupManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectPopupManager >> defaultMeasurement [

	^ ToAnchoredSameWidthMeasurement new
]

{ #category : #initialization }
ToSelectPopupManager >> defaultMinHeight [

	^ 80
]

{ #category : #initialization }
ToSelectPopupManager >> defaultPlacement [

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
ToSelectPopupManager >> defaultWindowClass [

	^ ToSelectPopupWindow 
]

{ #category : #accessing }
ToSelectPopupManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupManager >> listElementClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectPopupManager >> maxHeight: aNumber [

	self maxHeightPolicy: (ToSelectPopupExactMaxHeightPolicy new
	maxHeight: aNumber;
	yourself)
]

{ #category : #accessing }
ToSelectPopupManager >> maxHeightPolicy [

	^ maxHeightPolicy 
]

{ #category : #accessing }
ToSelectPopupManager >> maxHeightPolicy: aPopupMaxHeightPolicy [

	maxHeightPolicy := aPopupMaxHeightPolicy.
	self anchorElement requestLayout
]

{ #category : #accessing }
ToSelectPopupManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToSelectPopupManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToSelectPopupManager >> newListElement [

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
ToSelectPopupManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self anchorElement.
	listElement focusability: BlFocusability none.

	self maxHeight:  self defaultMaxHeight.
	self windowBuilder: [ :selectWin :request |
		selectWin root addChild: self listElement ].

	sieve := listElement newSieve
]

{ #category : #'api - hooks' }
ToSelectPopupManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectPopupManager >> onWindowClosedOnEvent: anEvent [

	super onWindowClosedOnEvent: anEvent.
	" if case one of my children has focus "
	self anchorElement onPopupWindowClosed
]

{ #category : #'window handling' }
ToSelectPopupManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	self anchorElement onPopupWindowOpened
]

{ #category : #'window handling' }
ToSelectPopupManager >> requestCloseWindowOnEvent: anEvent [
	" don't autoclose if mouse up on a filter textfield "

	| target |
	target := anEvent target.
	(target withAllParentsInclude: anchorElement filterTextField)
		ifTrue: [ ^ self ].
	super requestCloseWindowOnEvent: anEvent
]

{ #category : #accessing }
ToSelectPopupManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectPopupManager >> withMatchParentMaxHeight [

	self maxHeightPolicy: ToSelectPopupMatchParentMaxHeightPolicy new
]
