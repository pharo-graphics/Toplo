Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectStrategy >> headerNodeContainerClass [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToSelectStrategy >> isMultipleSelection [

	^ false
]

{ #category : #testing }
ToSelectStrategy >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode selectOnMouseDown: true.
	aSelect listElement selectionMode requestFocusOnMouseDown: false
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [


]
