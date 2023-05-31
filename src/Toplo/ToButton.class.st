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
