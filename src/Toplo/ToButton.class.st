Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientableButton',
	#classTraits : 'TToOrientableButton classTrait',
	#instVars : [
		'#label',
		'#icon'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button accessing' }
ToButton >> buttonPane [

	^ self 
]

{ #category : #'t - initialization dresser' }
ToButton >> defaultDresser [

	^ ToButtonDresser new
]

{ #category : #'t - button accessing' }
ToButton >> icon [

	^ icon
]

{ #category : #'t - button accessing' }
ToButton >> icon: anImage [

	icon := anImage
]

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeButton.
	
	self initializeDresser 
]

{ #category : #'t - button accessing' }
ToButton >> label [

	^ label
]

{ #category : #'t - button accessing' }
ToButton >> label: aLabel [

	label := aLabel
	
]
