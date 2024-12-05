Class {
	#name : #ToRadioMenuItem,
	#superclass : #ToCheckMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToRadioMenuItem >> buttonClass [

	^ ToRadioButton 
]

{ #category : #skin }
ToRadioMenuItem >> newRawSkin [ 

	^ ToRadioMenuItemSkin new

]
