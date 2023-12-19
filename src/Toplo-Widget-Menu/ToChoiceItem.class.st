Class {
	#name : 'ToChoiceItem',
	#superclass : 'ToCheckMenuItem',
	#category : 'Toplo-Widget-Menu-Choice menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Choice menu'
}

{ #category : 'testing' }
ToChoiceItem >> closeOnMouseEvent [

	^ true
]

{ #category : 'skin' }
ToChoiceItem >> installRawStyle [ 

	super installRawStyle.
	self button rightLabelAlignment: 30
]
