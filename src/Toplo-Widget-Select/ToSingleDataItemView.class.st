Class {
	#name : #ToSingleDataItemView,
	#superclass : #ToSelectDataItemView,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'api - hooks' }
ToSingleDataItemView >> onInstalledIn: anInnerContainer [

	super onInstalledIn: anInnerContainer.
	textInputElement := anInnerContainer textInputElement

]

{ #category : #'api - hooks' }
ToSingleDataItemView >> onUninstalledIn: anInnerContainer [

	textInputElement := nil.
	super onUninstalledIn: anInnerContainer
]

{ #category : #accessing }
ToSingleDataItemView >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSingleDataItemView >> textInputElement [ 

	^ textInputElement 
]
