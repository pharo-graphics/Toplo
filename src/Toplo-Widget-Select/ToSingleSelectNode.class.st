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
ToSingleSelectNode >> onInstalledIn: aNodeContainer [

	super onInstalledIn: aNodeContainer.
	self hMatchParent.
	self vFitContent.
	self middleContainer constraintsDo: [ :c |
		c horizontal matchParent ].
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: aNodeContainer.
	self middleContainer addChild: textInputElement
]

{ #category : #'api - hooks' }
ToSingleSelectNode >> onUninstalledIn: aNodeContainer [

	textInputElement onUninstalledIn: aNodeContainer.
	self middleContainer removeChild: textInputElement.
	super onUninstalledIn: aNodeContainer.

]

{ #category : #accessing }
ToSingleSelectNode >> textInputElement [ 

	^ textInputElement 
]
