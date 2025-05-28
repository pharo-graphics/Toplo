Class {
	#name : #ToSelectPopupManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve'
	],
	#category : #'Toplo-Widget-Select-List'
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
ToSelectPopupManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupManager >> listElementClass [

	^ ToSelectListElement
]

{ #category : #accessing }
ToSelectPopupManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToSelectPopupManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
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
