Class {
	#name : #ToSingleSelectHeaderDataItemView,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleSelectHeaderDataItemView >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToSingleSelectHeaderDataItemView >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c linear vertical alignCenter ].
]

{ #category : #skin }
ToSingleSelectHeaderDataItemView >> installRawStyle [

	super installRawStyle.
	self background: Color transparent
]

{ #category : #accessing }
ToSingleSelectHeaderDataItemView >> selectedDataTextField [

	self deprecated: 'No more implemented. Please, add a ToLabel child in the data item view'.
	^ self
]

{ #category : #accessing }
ToSingleSelectHeaderDataItemView >> text: aText [

	self deprecated: 'No more implemented. Please, add a ToLabel child in the data item view'.
	self addChild: (ToLabel text: aText)
]
