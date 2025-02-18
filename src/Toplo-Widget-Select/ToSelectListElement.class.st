Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #initialization }
ToSelectListElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #accessing }
ToSelectListElement >> groupSelecter [

	^ self groupSelectionMode selecter
]

{ #category : #accessing }
ToSelectListElement >> groupSelectionMode [

	^ self selectionModeWithEventClass: ToSelectGroupSelectionChangedEvent
]

{ #category : #accessing }
ToSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	self newGroupSelectionMode onInstalledIn: self.
	self primarySelectionMode selectOnPressed: true.
	self primarySelectionMode deselectOnPressed: true.
	self primarySelectionMode requestFocusOnPressed: false.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #accessing }
ToSelectListElement >> newGroupSelectionMode [

	^ ToSelectListGroupSelectionMode parentMode: self primarySelectionMode
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #accessing }
ToSelectListElement >> selectElement [

	^ selectElement 
]

{ #category : #accessing }
ToSelectListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToSelectListElement >> sieve [

	^ selectElement sieve
]
