Class {
	#name : #ToSingleSelectDataItemView,
	#superclass : #ToTripletElement,
	#instVars : [
		'container'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'api - hooks' }
ToSingleSelectDataItemView >> container: aContainer [

	container := aContainer
]

{ #category : #initialization }
ToSingleSelectDataItemView >> initialize [

	super initialize.

	self applySkinInstallerOnFirstRequest: true.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	self middleContainer constraintsDo: [ :c | c horizontal matchParent ]
]

{ #category : #skin }
ToSingleSelectDataItemView >> installRawStyle [

	super installRawStyle.
	self background: Color transparent.

]

{ #category : #accessing }
ToSingleSelectDataItemView >> selectedDataTextField [

	^ container textInputElement selectedDataTextField
]
