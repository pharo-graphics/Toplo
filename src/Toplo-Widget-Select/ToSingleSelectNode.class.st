Class {
	#name : #ToSingleSelectNode,
	#superclass : #ToTripletElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSingleSelectNode >> initialize [ 

	super initialize.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #skin }
ToSingleSelectNode >> installRawStyle [

	super installRawStyle.
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self margin: (BlInsets all: 2).
	self padding: (BlInsets vertical: 4).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: Color transparent.

]

{ #category : #'api - hooks' }
ToSingleSelectNode >> onInstalledIn: aNodeContainer [

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
	self middleContainer removeChild: textInputElement
]

{ #category : #accessing }
ToSingleSelectNode >> textInputElement [ 

	^ textInputElement 
]
