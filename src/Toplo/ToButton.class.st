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

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize
]

{ #category : #'t - initialization dresser' }
ToButton >> preInitializeDresser [ 
	
	super preInitializeDresser.

	self initializePair
]
