Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToToggleMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #skin }
ToCheckMenuItem >> newRawSkin [ 

	^ ToCheckMenuItemSkin new
]
