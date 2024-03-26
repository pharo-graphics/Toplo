Class {
	#name : #ToSingleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSingleSelectStrategy >> headerNodeContainerClass [

	^ ToSingleSelectHeaderNodeContainerElement
]

{ #category : #'api - hooks' }
ToSingleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode:
		(ToListSelectionMode primaryOn: aSelect listElement)
			beSingleSelection.
	super onInstalledIn: aSelect
]
