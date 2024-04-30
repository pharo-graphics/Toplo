Class {
	#name : #ToSingleSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSingleSelectHeaderNode >> installRawStyle [ 

	super installRawStyle.
	self middleContainer padding: (BlInsets right: 3).
	self padding: (BlInsets vertical: 4)
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self hMatchParent.
	self vFitContent.
	triplet middleContainer constraintsDo: [ :c |
		c horizontal matchParent ].
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: aSelect.
	self middleContainer addChild: textInputElement
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNode >> onUninstalledIn: aSelect [

	textInputElement onUninstalledIn: aSelect.
	self middleContainer removeChild: textInputElement.
	super onUninstalledIn: aSelect.

]

{ #category : #accessing }
ToSingleSelectHeaderNode >> textInputElement [ 

	^ textInputElement 
]
