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
ToSelectFilterResult >> applyOn: aSelectWindowManager [

	| cpt |
	listElement := aSelectWindowManager newListElement.
	listElement data updateAllWith: self selectedData.
	cpt := 0.

	self selectedData with: self indexes do: [ :d :i |
		cpt := cpt + 1.
		(aSelectWindowManager listElement selection includes: i)
			ifTrue: [ listElement selection doSelectIndex: cpt ]
			ifFalse: [ listElement selection doDeselectIndex: cpt ] ]
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
