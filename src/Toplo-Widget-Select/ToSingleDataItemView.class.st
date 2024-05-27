Class {
	#name : #ToSingleDataItemView,
	#superclass : #ToSelectDataItemView,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleDataItemView >> initialize [

	super initialize.
	textInputElement := ToSelectTextInputElement new.
	self addChild: textInputElement
]

{ #category : #'api - hooks' }
ToSingleDataItemView >> onInstalledIn: anInnerContainer [

	super onInstalledIn: anInnerContainer.
	textInputElement onInstalledIn: anInnerContainer

]

{ #category : #'api - hooks' }
ToSingleDataItemView >> onUninstalledIn: anInnerContainer [

	textInputElement onUninstalledIn: anInnerContainer.
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
