Class {
	#name : #ToMultipleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToMultipleSelectStrategy >> headerNodeContainerClass [

	^ ToMultipleSelectHeaderNodeContainerElement
]

{ #category : #testing }
ToMultipleSelectStrategy >> isMultipleSelection [

	^ true
]

{ #category : #'api - hooks' }
ToMultipleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode:
		(ToListSelectionMode primaryOn: aSelect listElement) beMultipleSelection.
	super onInstalledIn: aSelect
]
