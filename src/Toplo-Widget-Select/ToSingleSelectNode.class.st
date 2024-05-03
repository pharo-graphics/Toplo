Class {
	#name : #ToSingleSelectNode,
	#superclass : #ToElementBarNode,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSingleSelectNode >> installRawStyle [

	super installRawStyle.
	self background: Color transparent.
	self padding: (BlInsets vertical: 4)
]

{ #category : #'api - hooks' }
ToSingleSelectNode >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
	self hMatchParent.
	self vFitContent.
	self hMatchParent.
	self middleContainer constraintsDo: [ :c |
		c horizontal matchParent ].
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: anElementBar.
	self middleContainer addChild: textInputElement
]

{ #category : #'api - hooks' }
ToSingleSelectNode >> onUninstalledIn: anElementBar [

	textInputElement onUninstalledIn: anElementBar.
	self middleContainer removeChild: textInputElement.
	super onUninstalledIn: anElementBar.

]

{ #category : #accessing }
ToSingleSelectNode >> textInputElement [ 

	^ textInputElement 
]
