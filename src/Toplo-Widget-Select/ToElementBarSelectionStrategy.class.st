Class {
	#name : #ToElementBarSelectionStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToElementBarSelectionStrategy >> headerNodeContainerClass [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToElementBarSelectionStrategy >> isMultipleSelection [

	^ false
]

{ #category : #testing }
ToElementBarSelectionStrategy >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #'api - hooks' }
ToElementBarSelectionStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode selectOnMouseDown: true.
	aSelect listElement selectionMode requestFocusOnMouseDown: false
]

{ #category : #'api - hooks' }
ToElementBarSelectionStrategy >> onUninstalledIn: aSelect [


]
