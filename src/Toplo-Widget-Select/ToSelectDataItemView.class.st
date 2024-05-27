Class {
	#name : #ToSelectDataItemView,
	#superclass : #ToElement,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSelectDataItemView >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #skin }
ToSelectDataItemView >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets horizontal: 3 vertical: 4).
	self margin: (BlInsets all: 2).
	self background: Color transparent.

]

{ #category : #'api - hooks' }
ToSelectDataItemView >> onInstalledIn: anInnerContainer [
]

{ #category : #'api - hooks' }
ToSelectDataItemView >> onUninstalledIn: anInnerContainer [
]

{ #category : #accessing }
ToSelectDataItemView >> selectElement: aSelectElement [

	selectElement := aSelectElement
]
