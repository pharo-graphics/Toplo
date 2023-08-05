Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToLabelAndIconWithSkinHolder',
	#classTraits : 'TToLabelAndIconWithSkinHolder classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - skin accessing' }
ToButton >> defaultSkin [ 

	^ ToButtonSkin new
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self initializeLabeledIconWithSkin.


]
