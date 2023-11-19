Class {
	#name : #ToSelectItem,
	#superclass : #ToCheckMenuItem,
	#category : 'Toplo-Widget-Select'
}

{ #category : #skin }
ToSelectItem >> installRawStyle [ 

	super installRawStyle.
	self button rightLabelAlignment: 30
]
