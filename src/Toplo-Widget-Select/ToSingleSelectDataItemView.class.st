Class {
	#name : #ToSingleSelectDataItemView,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleSelectDataItemView >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToSingleSelectDataItemView >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
]

{ #category : #skin }
ToSingleSelectDataItemView >> installRawStyle [

	super installRawStyle.
	self background: Color transparent.
	self padding: (BlInsets all: 5)

]

{ #category : #accessing }
ToSingleSelectDataItemView >> selectedDataTextField [

	self deprecated: 'No more implemented. Please, add a ToLabel child in the data item view'.
	^ self
]

{ #category : #accessing }
ToSingleSelectDataItemView >> text: aText [

	self deprecated: 'No more implemented. Please, add a ToLabel child in the data item view'.
	self addChild: (ToLabel text: aText)
]
