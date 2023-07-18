Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToRadioButton >> defaultDresser [

	^ ToCheckBoxDresser new
]

{ #category : #'t - skin accessing' }
ToRadioButton >> defaultSkin [ 

	^ ToRadioSkin new
]
