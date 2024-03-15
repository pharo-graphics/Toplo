Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'select'
	],
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

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	select := aSelect.	
	aSelect listElement selectionMode selectOnMouseDown: true.
	aSelect listElement selectionMode requestFocusOnMouseDown: false
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]
