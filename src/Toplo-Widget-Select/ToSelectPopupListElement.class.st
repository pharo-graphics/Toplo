Class {
	#name : #ToSelectPopupListElement,
	#superclass : #ToListElement,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #initialization }
ToSelectPopupListElement >> defaultNodeManager [

	^ self defaultNodeManagerClass new
		  nodeHolderFactory: [ ToSelectPopupListNodeHolder new ];
		  yourself
]

{ #category : #accessing }
ToSelectPopupListElement >> groupSelecter [

	^ self groupSelectionMode selecter
]

{ #category : #accessing }
ToSelectPopupListElement >> groupSelectionMode [

	^ self selectionModeWithEventClass: ToSelectGroupSelectionChangedEvent
]

{ #category : #accessing }
ToSelectPopupListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToSelectPopupListElement >> initialize [

	super initialize.
	
	self nodeFactory: [ :holder | self listNodeClass new ].
	self newGroupSelectionMode onInstalledIn: self.
	self primarySelectionMode deselectOnPressed: true.
	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #initialization }
ToSelectPopupListElement >> listNodeClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectPopupListElement >> newGroupSelectionMode [

	^ ToSelectPopupListGroupSelectionMode parentMode: self primarySelectionMode
]

{ #category : #skin }
ToSelectPopupListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #accessing }
ToSelectPopupListElement >> selectElement [

	^ selectElement 
]

{ #category : #accessing }
ToSelectPopupListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToSelectPopupListElement >> sieve [

	^ selectElement sieve
]
