Class {
	#name : 'ToRadioMenuItem',
	#superclass : 'ToCheckMenuItem',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'initialization' }
ToRadioMenuItem >> buttonClass [

	^ ToRadioButton 
]

{ #category : 'skin' }
ToRadioMenuItem >> newRawSkin [ 

	^ ToRadioMenuItemSkin new
]
