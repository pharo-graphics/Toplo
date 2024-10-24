Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'as yet unclassified' }
ToSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"

	super applyDataSourceSieveCommand: aDataSourceCommand.
	" the window can be opened but invisible if opened from the text input element.
	see ToSelectFilterTextField>>onInstalledIn:. #popupWindowHiddenEvent: is sent
	to the select popup window manager when the filter is changed "
	selectElement currentPopupWindow ifNotNil: [ :w |
		w visibility: BlVisibility visible ]
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> groupSelecter [

	^ self groupSelectionMode selecter
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> groupSelectionMode [

	^ self selectionModeWithEventClass: ToSelectGroupSelectionChangedEvent
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	self newGroupSelectionMode onInstalledIn: self.
	self primarySelectionMode selectOnMouseDown: true.
	self primarySelectionMode requestFocusOnMouseDown: false.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> newGroupSelectionMode [

	^ ToSelectListGroupSelectionMode parentMode: self primarySelectionMode
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> selectElement [

	^ selectElement 
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #'as yet unclassified' }
ToSelectListElement >> sieve [

	^ selectElement sieve
]
