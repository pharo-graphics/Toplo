Class {
	#name : #ToSingleSelectDataItemView,
	#superclass : #ToTripletElement,
	#instVars : [
		'textInputElement',
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleSelectDataItemView >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #skin }
ToSingleSelectDataItemView >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets horizontal: 3 vertical: 4).
	self margin: (BlInsets all: 2).
	self background: Color transparent.

]

{ #category : #'api - hooks' }
ToSingleSelectDataItemView >> onInstalledIn: anInnerContainer [

	self middleContainer constraintsDo: [ :c | c horizontal matchParent ].
	textInputElement := anInnerContainer textInputElement
]

{ #category : #'api - hooks' }
ToSingleSelectDataItemView >> onUninstalledIn: anInnerContainer [

	textInputElement := nil
]

{ #category : #accessing }
ToSingleSelectDataItemView >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToSingleSelectDataItemView >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSingleSelectDataItemView >> textInputElement [ 

	^ textInputElement 
]
