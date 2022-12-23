Class {
	#name : #ToMultiStateButton,
	#superclass : #ToButton,
	#traits : 'TToWidgetWithState',
	#classTraits : 'TToWidgetWithState classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToMultiStateButton >> initialize [ 

	super initialize.
	self whenClickedDo: [ self switchToNextState ]
]
