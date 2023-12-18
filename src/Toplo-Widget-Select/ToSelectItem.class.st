Class {
	#name : 'ToSelectItem',
	#superclass : 'ToCheckMenuItem',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'testing' }
ToSelectItem >> closeOnMouseEvent [

	^ true
]

{ #category : 'skin' }
ToSelectItem >> installRawStyle [ 

	super installRawStyle.
	self button rightLabelAlignment: 30
]
