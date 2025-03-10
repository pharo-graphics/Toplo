Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToToggleMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #'t - labeled icon' }
ToCheckMenuItem >> hasIcon [

	^ true
]

{ #category : #skin }
ToCheckMenuItem >> newRawSkin [ 

	^ ToCheckMenuItemSkin new
]
