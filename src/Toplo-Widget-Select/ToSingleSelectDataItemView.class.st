Class {
	#name : #ToSingleSelectDataItemView,
	#superclass : #ToSelectDataItemView,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'api - hooks' }
ToSingleSelectDataItemView >> onInstalledIn: anInnerContainer [

	super onInstalledIn: anInnerContainer.
	textInputElement := anInnerContainer textInputElement

]

{ #category : #'api - hooks' }
ToSingleSelectDataItemView >> onUninstalledIn: anInnerContainer [

	textInputElement := nil.
	super onUninstalledIn: anInnerContainer
]

{ #category : #accessing }
ToSingleSelectDataItemView >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSingleSelectDataItemView >> textInputElement [ 

	^ textInputElement 
]
