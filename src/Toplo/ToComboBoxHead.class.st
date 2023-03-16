Class {
	#name : #ToComboBoxHead,
	#superclass : #ToGeneralButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHead >> contentElement: anElement [

	self firstChild removeFromParent.
	anElement ifNil: [ ^ self ].
	anElement hMatchParent.
	self addChild: anElement at: 1
]

{ #category : #'t - initialization dresser' }
ToComboBoxHead >> defaultDresser [

	^ ToComboBoxHeadDresser new
]
