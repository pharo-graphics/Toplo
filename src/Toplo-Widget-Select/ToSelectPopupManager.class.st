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

{ #category : #'window handling' }
ToSelectPopupManager >> checkCloseWindowOnPickingEvent: anEvent [
	" don't autoclose if mouse up on a filter textfield "

	| target |
	target := anEvent target.
	target = anchorElement filterTextField ifTrue: [ ^ self ].
	target
		withAllParentsUpTo: anchorElement filterTextField
		do: [ :e | ^ self ].
	super checkCloseWindowOnPickingEvent: anEvent
]

{ #category : #'event handling' }
ToSelectPopupManager >> closeOnMouseDownEvent: anEvent [

	^ true
]

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
ToSelectPopupManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupManager >> listElementClass [

	^ ToSelectListElement
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

{ #category : #'window handling' }
ToSelectPopupManager >> onClosed [

	super onClosed.
	" if case one of my children has focus "
	self anchorElement onPopupWindowClosed
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

	sieve := listElement newSieve.
	sieve onInstalledIn: listElement
]

{ #category : #'window handling' }
ToSelectPopupManager >> onOpened [

	super onOpened.
	self anchorElement onPopupWindowOpened
]

{ #category : #'api - hooks' }
ToSelectPopupManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #accessing }
ToSelectPopupManager >> popupWindowClass [

	^ ToSelectPopupWindow 
]

{ #category : #accessing }
ToSelectPopupManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectPopupManager >> withMatchParentMaxHeight [

	self maxHeightPolicy: ToSelectPopupMatchParentMaxHeightPolicy new
]
