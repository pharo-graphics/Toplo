Class {
	#name : #ToComboBoxHead,
	#superclass : #ToGeneralButton,
	#traits : 'TToWidgetWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToWidgetWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
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

{ #category : #'t - accessing layers' }
ToComboBoxHead >> layerReferentElement [

	^ self 
]
