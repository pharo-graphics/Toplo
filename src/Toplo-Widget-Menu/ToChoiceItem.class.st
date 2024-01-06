Class {
	#name : #ToChoiceItem,
	#superclass : #ToCheckMenuItem,
	#instVars : [
		'data'
	],
	#category : 'Toplo-Widget-Menu-Choice menu'
}

{ #category : #testing }
ToChoiceItem >> closeOnMouseEvent [

	^ true
]

{ #category : #accessing }
ToChoiceItem >> data [

	^ data
]

{ #category : #accessing }
ToChoiceItem >> data: anObject [

	data := anObject
]

{ #category : #skin }
ToChoiceItem >> installRawStyle [ 

	super installRawStyle.
	self button rightLabelAlignment: 30
]
