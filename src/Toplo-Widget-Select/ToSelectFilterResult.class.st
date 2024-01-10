Class {
	#name : #ToSelectFilterResult,
	#superclass : #Object,
	#instVars : [
		'selectedData',
		'indexes',
		'listElement'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #'list building' }
ToSelectFilterResult >> buildListFor: aSelectWindowManager [

	| cpt |
	listElement := aSelectWindowManager newListElement.
	listElement data updateAllWith: self selectedData.
	cpt := 0.

	self selectedData with: self indexes do: [ :d :i |
		cpt := cpt + 1.
		(aSelectWindowManager listElement selection includes: i)
			ifTrue: [ listElement selection doSelectIndex: cpt ]
			ifFalse: [ listElement selection doDeselectIndex: cpt ] ].

	listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event |
				 | le |
				 le := aSelectWindowManager listElement.
				 le dispatchSelectionChangedAfter: [
					 | filterIdx |
					 filterIdx := 0.
					 self indexes do: [ :idx |
						 filterIdx := filterIdx + 1.
						 (listElement selection includes: filterIdx)
							 ifTrue: [ le selection doSelectIndex: idx ]
							 ifFalse: [ le selection doDeselectIndex: idx ] ] ].
				 aSelectWindowManager onFilterListRemoved ])
]

{ #category : #accessing }
ToSelectFilterResult >> indexes [

	^ indexes
]

{ #category : #accessing }
ToSelectFilterResult >> indexes: aCollection [

	indexes := aCollection
]

{ #category : #accessing }
ToSelectFilterResult >> listElement [

	^ listElement
]

{ #category : #accessing }
ToSelectFilterResult >> selectedData [

	^ selectedData
]

{ #category : #accessing }
ToSelectFilterResult >> selectedData: aCollection [

	selectedData := aCollection
]
