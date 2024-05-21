Class {
	#name : #ToSelectNode,
	#superclass : #ToNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSelectNode >> initialize [

	super initialize.
	self initializeForToplo.
	self applySkinInstallerOnFirstRequest: true.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	textInputElement := ToSelectTextInputElement new.
	self addChild: textInputElement
]

{ #category : #skin }
ToSelectNode >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets horizontal: 3 vertical: 4).
	self margin: (BlInsets all: 2).
	self background: Color transparent.

]

{ #category : #'api - hooks' }
ToSelectNode >> onInstalledIn: aNodeContainer [

	textInputElement onInstalledIn: aNodeContainer.

]

{ #category : #'api - hooks' }
ToSelectNode >> onUninstalledIn: aNodeContainer [

	textInputElement onUninstalledIn: aNodeContainer
]

{ #category : #accessing }
ToSelectNode >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectNode >> textInputElement [ 

	^ textInputElement 
]
