Class {
	#name : #ToButton,
	#superclass : #ToPairedButton,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - skin accessing' }
ToButton >> defaultSkin [ 

	^ ToButtonSkin new
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self whenIconChangedDo: [ :new :prev |
		self dispatchEvent: (ToButtonIconChangedEvent current: new previous: prev) ].
	self whenLabelChangedDo: [ :new :prev |
		self dispatchEvent: (ToButtonLabelChangedEvent current: new previous: prev) ]
]
