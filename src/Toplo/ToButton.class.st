Class {
	#name : #ToButton,
	#superclass : #ToPairedButton,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToButton >> defaultDresser [

	^ ToButtonDresser new
]

{ #category : #'t - skin accessing' }
ToButton >> defaultSkin [ 

	^ ToButtonSkin new
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self whenIconChangedDo: [ :new :prev |
		self dispatchEvent: (ToButtonIconChanged current: new previous: prev) ].
	self whenLabelChangedDo: [ :new :prev |
		self dispatchEvent: (ToButtonLabelChanged current: new previous: prev) ]
]
