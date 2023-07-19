Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToRadioButton >> defaultDresser [

	^ ToCheckableButtonDresser new
]

{ #category : #'t - skin accessing' }
ToRadioButton >> defaultSkin [ 

	^ ToRadioSkin new
]
