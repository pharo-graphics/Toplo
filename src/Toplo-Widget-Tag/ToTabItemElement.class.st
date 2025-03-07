Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]
